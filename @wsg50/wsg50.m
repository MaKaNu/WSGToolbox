classdef wsg50 < handle
% WSG50 Class summary goes here:
%
% gripper = wsg50(varargin) Creates a gripper object
% 
% Optional inputs:
%   - 'IP', 'aaa.bbb.ccc.ddd'
%   - 'PORT', 1234
%   - 'verbose'
%   - 'debug'
%   - 'autoopen'

%   Copyright 2019 Fachhochschule Dortmund LIT
% $Revision: 0.2.1 $
% $Author: Matti Kaupenjohann $ 
% $Date: 2019/11/26 $ 


  
    %CONSTANTS & PRIVATES
    properties (Constant, Access = private)
        preambel = ['aa';'aa';'aa'];    
        CRC_0 = ['00';'00'];            % If CRC disabled
    end
    
    %PRIVATES
    properties (Access = private)
        autoopen                %Boolean for autoconnection
        ID                      %Mem for sending Command ID
        Payload                 %Mem for sending Command Payload
        Command                 %Mem for sending complete Command
        Data                    %Mem for sending Data
        Data_R                  %Mem for receiving Data
        ID_R                    %Mem for receiving Command ID
        payloadlength_R         %Mem for receiving payloadlength
        payload_R               %Mem for receiving Payload
        command_R               %Mem for receiving complete Command
        status_R                %Mem for receining Status Message
        crc_R                   %Mem for receiving CRC-Sum
        CRC                     %Mem for sending CRC
        msg_table               %Continous Memory for every msg
        new_msg                 %Boolean for checking of new messages
        buffer                  %Memory for received Data
    end
    
    %PUBLICS
    properties
        IP
        PORT
        TCPIP                   %TCPIP-Objekt
        verbose                 %Boolean for info messages
        debug                   %Boolean for debugging enviroment
        %Status variable for different ???
        status = struct('OVERDRIVE',false,'LIMITS',false);
    end
    
    methods
        
        %CONSTRUCTOR
        function Obj = wsg50(varargin)

            %Set Standards
            Obj.IP = 'localhost';
            Obj.PORT = 1000;
            Obj.verbose = false;
            Obj.debug = false;
            Obj.autoopen = false;
            
            %Set properties
            Obj.msg_table = msg_id_tbl();
            Obj.buffer = [];
            
            
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
                        case 'autoopen'
                            Obj.autoopen = true;
                    end
                end
                n = n +1;
            end
            
            ipobject(Obj);
            if Obj.autoopen
                Obj.connect();
                disp('Connection is open!')
            end
        end
        
        %DECONSTRUCTER
        function delete(Obj) 
            Obj.disconnect
            instrreset
        end   

    end
    
    %PRIVATE METHODS
    methods (Access = private)
        
        %Create TCPIP Object
        function ipobject(Obj)
            Obj.TCPIP = tcpip(Obj.IP,Obj.PORT);
            Obj.TCPIP.OutputBufferSize = 3000;
            Obj.TCPIP.InputBufferSize = 3000;
            Obj.TCPIP.ByteOrder = 'littleEndian';
            Obj.TCPIP.Timeout = 1;
            %Setting up Callbackfunction
            Obj.TCPIP.BytesAvailableFcnMode = 'byte';
            Obj.TCPIP.BytesAvailableFcnCount = 1;
            Obj.TCPIP.BytesAvailableFcn = {@TCP_Callback};
            
        end
        
        %TCP Callback
        %This function will be called if one Byte is available at the TCPIP
        %buffer. 
        function TCP_Callback(Obj,~)
            Obj.DataReceive
            if Obj.buffer
            end
        end
        
        %Convert Data
        %This function is used in every public method. It concatinate the
        %command message and convert it from hex to dec. Also it is
        %checking for CRC-sum.
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
            %Convert hex 2 dec
            Obj.Data = hex2dec(Obj.Data);
        end
                      
        %Send Data
        %This function is used in every publi   c method. It checks if the
        %connection is opened and sends the data, which is saved in the mem
        %for sending data.
        function DataSend(Obj)
            if strcmp(Obj.TCPIP.Status,'open')
                fwrite(Obj.TCPIP, uint8(Obj.Data), 'uint8');
            else
                error(strcat('ERROR: Connection is not open. ',...
                             ' Error-Code #00001'))
            end
        end
        
        %Receive Data
        %This function is only used by the method ReadCommand. If Bytes are
        %available it reads one Byte and Converts it to 2-Byte-Hex. This
        %function should only be called if it receiving data is expected.
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
                Obj.buffer = [Obj.buffer, Obj.Data_R];
            else
                error(strcat('ERROR: Connection is not open. ',...
                             'Error-Code #00002'))
            end
        end
        
        %Read a single command
        %This function is used by the Method Command_Complete. It is
        %looking for the preambel and saves the receiving command,
        %depending on its length.
        function ReadData(Obj)
            %Wait until preambel
            if Obj.command_R(1:3) == 170
                Obj.new_msg = false;
                
            end

            %Read ID, Payloadlength and Status
            if Obj.command_R(1:3) == [170;170;170]
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
                            Obj.payloadlength_R = [Obj.payloadlength_R, Obj.Data_R];
                        case 4
                            Obj.status_R = Obj.Data_R;
                        case 5
                            Obj.status_R = [Obj.status_R; Obj.Data_R];
                    end
                end
                %Read Payload depending on payloadlength
                for i = 1:Obj.payloadlength_R(1)+Obj.payloadlength_R(2)*255-2
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
        %Simple Switch case LUT for Status message. USed in method
        %command_complete
        function decode_status(Obj)
            switch dec2hex(Obj.status_R,2)
                case ['00';'00']
                    disp('E_SUCCESS')
                    disp('Kein Fehler aufgetreten,Befehl erfolgreich.')
                case ['01'; '00']
                    disp('E_NOT_AVAILABLE')
                    disp('Funktion oder Daten nicht verfuegbar.')
                case ['02'; '00']
                    disp('E_NO_SENSOR')
                    disp('Kein Messumformer angeschlossen.')
                case['03'; '00']
                    disp('E_NOT_INITIALIZED')
                    disp('Geraet nicht initialisiert.')
                case ['04'; '00']
                    disp('E_ALREADY_RUNNING')
                    disp('Datenerfassung wird bereits ausgefuehrt.')
                case ['05'; '00']
                    disp('E_FEATURE_NOT_SUPPORTED')
                    disp('Die Funktion ist nicht verfuegbar.')
                case ['06'; '00']
                    disp('E_INCONSISTENT_DATA')
                    disp('Einer oder mehrere Parameter sind inkonsistent.')
                case ['07'; '00']
                    disp('E_TIMEOUT')
                    disp('Zeitueberschreitung.')
                case ['08'; '00']
                    disp('E_READ_ERROR')
                    disp('Fehler beim Lesen von Daten.')
                case ['09'; '00']
                    disp('E_WRITE_ERROR')
                    disp('Fehler beim Schreiben von Daten.')
                case ['0A'; '00']
                    disp('E_INSUFFICIENT_RESOURCES')
                    disp('Nicht genuegend Speicher vorhanden.')
                case ['0B'; '00']
                    disp('E_CHECKSUM_ERROR')
                    disp('Pruefsummenfehler.')
                case ['0C'; '00']
                    disp('E_NO_PARAM_EXPECTED')
                    disp('Parameter uebergeben, obwohl keiner erwartet.')
                case ['0D'; '00']
                    disp('E_NOT_ENOUGH_PARAMS')
                    disp('Zu wenige Parameter fuer den Befehl uebergeben.')
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
                    disp('Schnittstelle ist bereits geoeffnet.')
                case ['12'; '00']
                    disp('E_CMD_FAILED')
                    disp('Fehler waehrend der Ausfuehrung eines Befehls.')
                case ['13'; '00']
                    disp('E_CMD_ABORTED')
                    disp('Befehlsausfuehrung vom Benutzer abgebrochen.')
                case ['14'; '00']
                    disp('E_INVALID_HANDLE')
                    disp('Ungueltiges Handle.')
                case ['15'; '00']
                    disp('E_NOT_FOUND')
                    disp('Geraet oder Datei nicht gefunden.')
                case ['16'; '00']
                    disp('E_NOT_OPEN')
                    disp('Geraet oder Datei nicht geoeffnet.')
                case ['17'; '00']
                    disp('E_IO_ERROR')
                    disp('Ein-/Ausgabefehler.')
                case ['18'; '00']
                    disp('E_INVALID_PARAMETER')
                    disp('Ungueltiger Parameter.')
                case ['19'; '00']
                    disp('E_INDEX_OUT_OF_BOUNDS')
                    disp('Index ausserhalb des zulaessigen Bereichs.')
                case ['1A'; '00']
                    disp('E_CMD_PENDING')
                    disp(strcat('Der Befehl wurde noch nicht',...
                                ' vollstaendig ausgefuehrt.'))
                    disp(strcat('Eine Rueckmeldung mit Statuscode folgt',...
                                ' nach Ausfuehrung des Befehls.'))
                case ['1B'; '00']
                    disp('E_OVERRUN')
                    disp('Datenueberlauf.')
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
                
        %Command Complete
        %This function should be called after every sended command. It is
        %looking (at the moment) for two different status codes. A
        %Byproduct of this method is the awnser command that is received
        %from the gripper.
        function command_complete(Obj)
           repeat_flag = true;
           while repeat_flag
                ReadCommand(Obj)
                switch dec2hex(Obj.ID_R)
                    case Obj.ID
                        % E_CMD_PENDING
                        if Obj.status_R(1) == 26 && Obj.status_R(2) == 0
                            repeat_flag = true;
                            if Obj.verbose
                            decode_status(Obj)
                            end
                        % E_SUCCESS Messagepayload could be decode
                        elseif Obj.status_R(1) == 0 && Obj.status_R(2) == 0
                            repeat_flag = false;
                            if Obj.verbose
                                decode_status(Obj)
                            end
                            if Obj.TCPIP.BytesAvailable>0
                                flushinput(Obj.TCPIP) 
                            end
                        else
                            repeat_flag = false;
                            decode_status(Obj)
                        end
                    otherwise
                        if Obj.debug
                            warning('THIS MESSAGE IS JUST FOR DEBUGING!')
                            disp(Obj.ID_R)
                            repeat_flag = true;
                        end
                end
           end
        end
        
        %DecodePayload
        %This function is used in every public method. It depends on Type,
        %TypeLength, number of commands, and symbolname which is given
        %inside the public functions
        function decode_payload(Obj,Type,TypeLength,Num_CMD,symbol)
            end_idx = 0;
            for i = 1:Num_CMD
                if i == 1
                    PreviousLength = 1;
                else
                    PreviousLength = PreviousLength + TypeLength{i-1};
                end
                start_idx = PreviousLength;
                end_idx = end_idx + TypeLength{i};
                
                switch Type{i}
                    case 'INTEGER'
                        dec_str = Obj.payload_R';
                        dec_str = dec_str(start_idx:end_idx);
                        tmp_int = 0;
                        for j = 1:length(dec_str)
                             tmp_int =  tmp_int + dec_str(j)*255^(j-1);
                        end
                        if iscellstr(symbol)
                            Obj.status.(symbol{i}) = tmp_int;
                        else
                            error('ERROR: THIS SHOULD NOT HAPPEN!! FIX THE FUNCTION ARGUMENTS')
                        end
                    case 'FLOAT'    %TypeLength not used for FLOAT ??? What did I mean
                        dec_str = Obj.payload_R';
                        dec_str = dec_str(start_idx:end_idx);
                        if iscellstr(symbol)
                            Obj.status.(symbol{i})= typecast(uint8(dec_str),'single');
                        else
                            error('ERROR: THIS SHOULD NOT HAPPEN!! FIX THE FUNCTION ARGUMENTS')
                        end
                    case 'STRING'
                    case 'BITVEC'
                        dec_str = Obj.payload_R';
                        dec_str = dec_str(start_idx:end_idx);
                        dec_str = de2bi(dec_str);
                        tmp_bivec = zeros(1,4*length(dec_str));
                        a=1;b=8;
                        for j = 1:size(dec_str,1)
                            tmp_bivec(a:b) = dec_str(j,:);
                            a=a+8;
                            b=b+8;
                        end
                        if iscellstr(symbol)
                            Obj.status.(symbol{i})= fliplr(tmp_bivec);      
                        else
                            error('ERROR: THIS SHOULD NOT HAPPEN!! FIX THE FUNCTION ARGUMENTS')
                        end
                    case 'ENUM'
                        dec_str = Obj.payload_R';
                        dec_str = dec_str(start_idx:end_idx);
                        if iscellstr(symbol)
                            Obj.status.(symbol{i})= dec_str;
                        else
                            error('ERROR: THIS SHOULD NOT HAPPEN!! FIX THE FUNCTION ARGUMENTS')
                        end
                    otherwise
                end
            end
        end
    end
    
    
               
end    
