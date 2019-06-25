classdef wsg50 < handle
    
    properties (Constant, Access = private)
        preambel = ['aa';'aa';'aa'];
        CRC_0 = ['00';'00'];
    end
    
    properties (Access = private)
        ID
        Payload
        Command
        Data
        Data_R
        ID_R
        payloadlength_R
        payload_R
        command_R
        status_R
        crc_R  
        CRC
    end
    
    properties
        IP
        PORT
        TCPIP
        verbose
        debug
        status = struct('OVERDRIVE',false,'LIMITS',false);
    end
    
    methods (Access = private)
        
        %Create TCPIP Object
        function ipobject(Obj)
            Obj.TCPIP = tcpip(Obj.IP,Obj.PORT);
            Obj.TCPIP.OutputBufferSize = 3000;
            Obj.TCPIP.InputBufferSize = 3000;
            Obj.TCPIP.ByteOrder = 'littleEndian';
            Obj.TCPIP.Timeout = 1;
        end
        
        %Convert Data
        function DataEncode(Obj)
            %Checking if CRC set
            if isempty(Obj.CRC)
                Obj.CRC = Obj.CRC_0;
            end
            
            %Concatinate Data String
            Obj.Data = [Obj.preambel;...        %Preambel     
                            Obj.ID;...              %Command ID
                            Obj.Payload;...         %Payload length
                            Obj.Command;...         %Command
                            Obj.CRC];               %CRC
            Obj.Data = hex2dec(Obj.Data);
        end
                      
        %Send Data
        function DataSend(Obj)
            if strcmp(Obj.TCPIP.Status,'open')
                fwrite(Obj.TCPIP, uint8(Obj.Data), 'uint8');
            else
                error(strcat('ERROR: Connection is not open. ',...
                             'Error-Code #00001'))
            end
        end
        
        %Receive Data
        function DataReceive(Obj)
            if strcmp(Obj.TCPIP.Status,'open')
                cnt = 0;
                while Obj.TCPIP.BytesAvailable <= 0
                    pause(0.1);
                    cnt = cnt + 1;
                    if cnt == 50
                        error(strcat('ERROR: No Data Available. ',...
                              'Error-Code #00002'))
                    end
                end
                %Receive one byte                
                Obj.Data_R = fread(Obj.TCPIP, 1, 'uint8');
                %Transform Data
                Obj.Data_R = dec2hex(Obj.Data_R);
                if length(Obj.Data_R) == 1
                    Obj.Data_R = strcat('0',Obj.Data_R);
                end
            else
                error(strcat('ERROR: Connection is not open. ',...
                             'Error-Code #00002'))
            end
        end
        
        %Disconnect
        function Disconnect(Obj)
            Obj.Data = [Obj.preambel; '07'; '00'; '00'; '00'];
            Obj.Data = hex2dec(Obj.Data);
            fwrite(Obj.TCPIP, uint8(Obj.Data), 'uint8');
            if Obj.TCPIP.BytesAvailable>0
               flushinput(Obj.TCPIP) 
            end
            fclose(Obj.TCPIP);
        end
        
        %Read a single command
        function ReadCommand(Obj)
            repeat_FLAG = true;
            %Find first 'AA'
            while repeat_FLAG
                DataReceive(Obj)
                if strcmp(Obj.Data_R,'AA')
                    Obj.command_R = Obj.Data_R;
                    %Find second 'AA'
                    DataReceive(Obj)
                    if (strcmp(Obj.Data_R,'AA') &&...
                        strcmp(Obj.command_R,'AA'))
                        Obj.command_R = [Obj.command_R; Obj.Data_R];
                        %Find third 'AA'
                        DataReceive(Obj)
                        if  (strcmp(Obj.Data_R,'AA') &&...
                            strcmp(Obj.command_R,['AA';'AA']))
                            Obj.command_R = [Obj.command_R; Obj.Data_R];
                            repeat_FLAG = false;
                        else
                            repeat_FLAG = true;
                        end
                    else
                        repeat_FLAG = true;
                    end
                else
                    repeat_FLAG = true;
                end
            end
            %Read ID, Payloadlength and Status
            if strcmp(Obj.command_R,['AA';'AA';'AA'])
                for i = 1:5
                    DataReceive(Obj)
                    Obj.command_R = [Obj.command_R; Obj.Data_R];
                    switch i
                        case 1
                            Obj.ID_R = Obj.Data_R;
                            if Obj.debug
                                disp(Obj.ID_R)
                            end
                        case 2
                            Obj.payloadlength_R = Obj.Data_R;
                        case 3
                            Obj.payloadlength_R = strcat(Obj.payloadlength_R, Obj.Data_R);
                        case 4
                            Obj.status_R = Obj.Data_R;
                        case 5
                            Obj.status_R = [Obj.status_R; Obj.Data_R];
                    end
                end
                %Read Payload
                for i = 1:(hex2dec(Obj.payloadlength_R(1:2))+hex2dec(Obj.payloadlength_R(3:4))*256-2)
                   DataReceive(Obj)
                   Obj.command_R = [Obj.command_R; Obj.Data_R];
                   if i == 1
                       Obj.payload_R = Obj.Data_R;
                   else
                       Obj.payload_R = [Obj.payload_R; Obj.Data_R];
                   end
                end
                %Read CRC-Checksum
                for i = 1:2
                   DataReceive(Obj)
                   Obj.command_R = [Obj.command_R; Obj.Data_R];
                   if i == 1
                       Obj.crc_R = Obj.Data_R;
                   else
                       Obj.crc_R = [Obj.crc_R; Obj.Data_R];
                   end
                end
                                     
            else
                error(strcat('ERROR: Wrong Preambel. ',...
                             'Error-Code #00003'))
            end
                
        end
        
        %DecodeStatus
        function decode_status(Obj)
            switch Obj.status_R
                case ['00';'00']
                    disp('E_SUCCESS')
                    disp('Kein Fehler aufgetreten,Befehl erfolgreich.')
                case ['01'; '00']
                    disp('E_NOT_AVAILABLE')
                    disp('Funktion oder Daten nicht verfügbar.')
                case ['02'; '00']
                    disp('E_NO_SENSOR')
                    disp('Kein Messumformer angeschlossen.')
                case['03'; '00']
                    disp('E_NOT_INITIALIZED')
                    disp('Gerät nicht initialisiert.')
                case ['04'; '00']
                    disp('E_ALREADY_RUNNING')
                    disp('Datenerfassung wird bereits ausgeführt.')
                case ['05'; '00']
                    disp('E_FEATURE_NOT_SUPPORTED')
                    disp('Die Funktion ist nicht verfügbar.')
                case ['06'; '00']
                    disp('E_INCONSISTENT_DATA')
                    disp('Einer oder mehrere Parameter sind inkonsistent.')
                case ['07'; '00']
                    disp('E_TIMEOUT')
                    disp('Zeitüberschreitung.')
                case ['08'; '00']
                    disp('E_READ_ERROR')
                    disp('Fehler beim Lesen von Daten.')
                case ['09'; '00']
                    disp('E_WRITE_ERROR')
                    disp('Fehler beim Schreiben von Daten.')
                case['0A'; '00']
                    disp('E_INSUFFICIENT_RESOURCES')
                    disp('Nicht genügend Speicher vorhanden.')
                case ['0B'; '00']
                    disp('E_CHECKSUM_ERROR')
                    disp('Prüfsummenfehler.')
                case ['0C'; '00']
                    disp('E_NO_PARAM_EXPECTED')
                    disp('Parameter übergeben, obwohl keiner erwartet.')
                case ['0D'; '00']
                    disp('E_NOT_ENOUGH_PARAMS')
                    disp('Zu wenige Parameter für den Befehl übergeben.')
                case ['0E'; '00']
                    disp('E_CMD_UNKNOWN')
                    disp('Unbekannter Befehl.')
                case ['0F'; '00']
                    disp('E_CMD_FORMAT_ERROR')
                    disp('Fehler im Befehlsformat.')
                case ['10'; '00']
                    disp('E_ACCESS_DENIED')
                    disp('Zugriff verweigert.')
                case ['11'; '00']
                    disp('E_ALREADY_OPEN')
                    disp('Schnittstelle ist bereits geöffnet.')
                case ['12'; '00']
                    disp('E_CMD_FAILED')
                    disp('Fehler während der Ausführung eines Befehls.')
                case ['13'; '00']
                    disp('E_CMD_ABORTED')
                    disp('Befehlsausführung vom Benutzer abgebrochen.')
                case ['14'; '00']
                    disp('E_INVALID_HANDLE')
                    disp('Ungültiges Handle.')
                case ['15'; '00']
                    disp('E_NOT_FOUND')
                    disp('Gerät oder Datei nicht gefunden.')
                case ['16'; '00']
                    disp('E_NOT_OPEN')
                    disp('Gerät oder Datei nicht geöffnet.')
                case ['17'; '00']
                    disp('E_IO_ERROR')
                    disp('Ein-/Ausgabefehler.')
                case ['18'; '00']
                    disp('E_INVALID_PARAMETER')
                    disp('Ungültiger Parameter.')
                case ['19'; '00']
                    disp('E_INDEX_OUT_OF_BOUNDS')
                    disp('Index außerhalb des zulässigen Bereichs.')
                case ['1A'; '00']
                    disp('E_CMD_PENDING')
                    disp(strcat('Der Befehl wurde noch nicht',...
                                ' vollständig ausgeführt.'))
                    disp(strcat('Eine Rückmeldung mit Statuscode folgt',...
                                ' nach Ausführung des Befehls.'))
                case ['1B'; '00']
                    disp('E_OVERRUN')
                    disp('Datenüberlauf.')
                case ['1C'; '00']
                    disp('E_RANGE_ERROR')
                    disp('Bereichsfehler.')
                case ['1D'; '00']
                    disp('E_AXIS_BLOCKED')
                    disp('Achse blockiert.')
                case ['1E'; '00']
                    disp('E_FILE_EXISTS')
                    disp('Datei existiert bereits.')
                otherwise
                   error('ERROR: Status Code unknown.') 
            end
        end
                
        %DecodePayload
        function decode_payload(Obj,Type,TypeLength,Num_CMD,symbol)
            end_idx = 0;
            for i = 1:Num_CMD
                if i == 1
                    PreviousLength = 1;
                else
                    PreviousLength = TypeLength{i-1}+1;
                end
                start_idx = PreviousLength;
                end_idx = end_idx + TypeLength{i};
                
                switch Type{i}
                    case 'INTEGER'
                        
                    case 'FLOAT'    %TypeLength not used for FLOAT
                        hex_str = reshape(flipud(Obj.payload_R)',1,2*size(Obj.payload_R,1));
                        hex_str = hex_str(start_idx:end_idx);
                        if iscellstr(symbol)
                            Obj.status.(symbol{i})= typecast(uint32(hex2dec(hex_str)),'single');
                        else
                            error('ERROR: THIS SHOULD NOT HAPPEN!!')
                        end
                    case 'STRING'
                    case 'BITVEC'
                    case 'ENUM'
                    otherwise
                end
            end
        end
        
        %Command Complete
        function command_complete(Obj)
           repeat_flag = true;
           while repeat_flag
                ReadCommand(Obj)
                if Obj.ID_R == Obj.ID
                    if strcmp(Obj.status_R,['1A';'00'])
                        repeat_flag = true;
                        if Obj.verbose
                        decode_status(Obj)
                        end
                    elseif strcmp(Obj.status_R,['00';'00'])
                        if Obj.TCPIP.BytesAvailable>0
                           flushinput(Obj.TCPIP) 
                        end
                        repeat_flag = false;
                        if Obj.verbose
                            decode_status(Obj)
                        end
                    else
                        repeat_flag = false;
                        decode_status(Obj)
                    end
                end
            end 
        end
    end
    
    methods
        
        %CONSTRUCTOR
        function Obj = wsg50(varargin)

            %Set Standards
            Obj.IP = 'localhost';
            Obj.PORT = 1000;
            Obj.verbose = false;
            Obj.debug = false;
            
            n=1;
            while n <= length(varargin)
                if ischar(varargin{n})
                    str = varargin{n};
                    switch str
                        case 'IP'
                            Obj.IP = varargin{n+1};
                        case 'PORT'
                            Obj.PORT = varargin{n+1};
                        case 'verbose'
                            Obj.verbose = true;
                        case 'debug'
                            Obj.debug = true;
                    end
                end
                n = n +1;
            end
            
            ipobject(Obj);
        end
        
        %DECONSTRUCTER
        function delete(~) 
            instrreset
        end   

    end
               
end    