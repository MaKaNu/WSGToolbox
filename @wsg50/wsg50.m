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
	
	%   Copyright 2020 Fachhochschule Dortmund LIT
	% $Revision: 0.3.0 $
	% $Author: Matti Kaupenjohann $
	% $Date: 2020/06/16 $
	
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
		CRC                     %Mem for sending CRC
		buffer                  %Memory for received Data
		boolean_struct = struct;%Struct for message boolean values
		decodeprop = struct;		%struct for decoding msgs
		enumtype						%ENUMS for Symbol TYPE
		
		TCPIP                   % TCPIP-objekt
		TCPIPWrapper				% Wrapper for the TCP Callback
		LH								% Event Listener for TCP Callback
	end
	
	%PUBLICS
	properties
		msg_table
		IP
		PORT
		verbose                 % Boolean for info messages
		debug                   % Boolean for debugging enviroment
		use_crc						% Boolean for enabled crc
		%Status variable for different ???
		status = struct('OVERDRIVE',false,'LIMITS',false);
	end
	
	%PUBLIC METHODS
	methods
		
		%CONSTRUCTOR
		function obj = wsg50(varargin)
			disp 'CONSTRUCTED wsg50'
			
			%Set Standards
			obj.IP = 'localhost';
			obj.PORT = 1000;
			obj.verbose = false;
			obj.debug = false;
			obj.autoopen = false;
			obj.use_crc = true;
			
			%Set properties
			obj.msg_table = msg_id_tbl();
			obj.buffer = [];
			
			defaultHost = 'localhost';
			
			switch nargin
				case 0
					obj.IP = defaultHost;
					warning('Host and Port are not set. The object uses defaultHost and defaultPort.')
				case 1
					obj.IP = varargin{1};
					warning('Port is not set. The object uses defaultPort.')
				case 2
					obj.IP = varargin{1};
					obj.PORT = varargin{2};
				otherwise
					obj.IP = varargin{1};
					obj.PORT = varargin{2};
					obj.check_vars(varargin)
			end
			
			% Create TCP Object
			obj.TCPIP = tcpip(obj.IP,obj.PORT);
			
			% Create Callback Wrapper
			obj.TCPIPWrapper = tcpipCallbackWrapper(obj.TCPIP);
			
			% Create Callback Event Listener
			obj.LH = listener(obj.TCPIPWrapper,'BytesAvailableFcn',@obj.onBytes);
			
			% Configure TCPIP Objekt
			obj.conf_conn();
			
			% Initialize Boolean struct
			obj.init_b_struct();	
			
			% Initialize ENUMS
			obj.init_enums();
			
			% Open the connection
			if obj.autoopen
				obj.connect();
				disp('Connection is open!')
			end
			
		end
		
		%DESTRUCTER
		function delete(obj)
			disp 'DESTRUCTED wsg50'
			
			if strcmp(obj.TCPIP.Status,'open')
				obj.disconnect
			end
			
			% Destroy Listener
			delete(obj.LH);
			% destroy Wrapper
			delete(obj.TCPIPWrapper);
			
 			instrreset
		end
					
	end
	
	%PRIVATE METHODS
	methods (Access = private)
		%Check varargins greater then 2
		function check_vars(obj,classvars)
			n=3;
			while n <= length(classvars)
				if ischar(classvars{n})
					str = classvars{n};
					switch str
						case 'verbose'
							obj.verbose = true;
						case 'debug'
							obj.debug = true;
						case 'autoopen'
							obj.autoopen = true;
						case 'crcoff'
							obj.use_crc = false;
					end
				end
				n = n +1;
			end
		end
		
		%Create TCPIP object
		function conf_conn(obj)
			obj.TCPIP.OutputBufferSize = 3000;
			obj.TCPIP.InputBufferSize = 3000;
			obj.TCPIP.ByteOrder = 'littleEndian';
			obj.TCPIP.Timeout = 1;
			
		end
		
		%Build boolean_strcut
		function init_b_struct(obj)
			obj.boolean_struct.ID = false;
			obj.boolean_struct.LENGTH = false;
			obj.boolean_struct.STATUS = false;
			obj.boolean_struct.PAYLOAD = false;
			obj.boolean_struct.CRC = false;
		end	
		
		%Initialize all enum cells
		function init_enums(obj)
			obj.enumtype = {'unknown',...
								 'WSG50',...
								 'WSG32',...
								 'KMS40',...
								 'WTS',...
								 'WSG25',...
								 'WSG70'};
		end
		
		%Receive Data
		%This function is only used by the method ReadCommand. If Bytes are
		%available it reads one Byte and Converts it to 2-Byte-Hex. This
		%function should only be called if it receiving data is expected.
		function DataReceive(obj)
			if strcmp(obj.TCPIP.Status,'open')
				cnt = 0;
				while obj.TCPIP.BytesAvailable <= 0
					pause(0.1);
					cnt = cnt + 1;
					if cnt == 50
						error(strcat('ERROR: No Data Available. ',...
							'Error-Code #00002'))
					end
				end
				%Receive one byte
				obj.Data_R = fread(obj.TCPIP, 1, 'uint8');
				obj.buffer = [obj.buffer, obj.Data_R];
			else
				error(strcat('ERROR: Connection is not open. ',...
					'Error-Code #00002'))
			end
		end
		
		%Sort buffer
		%this function checks if more then one consecutive triple "AA" saved
		%in the buffer and resets the buffer to the second consecutive triple
		%"AA"
		function sort_buffer(obj)
			if obj.debug
			disp(obj.buffer)
			end
			b = obj.boolean_struct;
			if obj.buffer(1) == 170 && ~any(struct2array(b))
				if size(obj.buffer,2) == 3 && sum(obj.buffer==170) == 3
					obj.buffer = [];
					obj.boolean_struct.ID = true;
				end
			elseif obj.boolean_struct.ID
				obj.msg_table.new_ID(obj.buffer(1))
				obj.boolean_struct.ID = false;
				obj.boolean_struct.LENGTH = true;
				obj.ID_R = obj.buffer(1);
				obj.buffer = [];
			elseif obj.boolean_struct.LENGTH
				if size(obj.buffer,2) == 2
					obj.msg_table.enter_ID_val(obj.ID_R,'LENGTH',obj.buffer)
					obj.buffer = [];
					obj.boolean_struct.LENGTH = false;
					obj.boolean_struct.STATUS = true;
					obj.CorrectMsgLength()
				end
			elseif obj.boolean_struct.STATUS
				if size(obj.buffer,2) == 2
					obj.msg_table.enter_ID_val(obj.ID_R,'STATUS',obj.buffer)
					obj.buffer = [];
					obj.boolean_struct.STATUS = false;
					if obj.calc_payload(obj.ID_R)==2
						obj.boolean_struct.CRC = true;
					else
						obj.boolean_struct.PAYLOAD = true;
					end
				end
			elseif obj.boolean_struct.PAYLOAD
				if size(obj.buffer,2) == obj.calc_payload(obj.ID_R)-2
					obj.msg_table.enter_ID_val(obj.ID_R,'PAYLOAD',obj.buffer)
					obj.buffer = [];
					obj.boolean_struct.PAYLOAD = false;
					obj.boolean_struct.CRC = true;
				end
			elseif obj.boolean_struct.CRC
				if size(obj.buffer,2) == 2
					obj.msg_table.enter_ID_val(obj.ID_R,'CRC',obj.buffer)
					obj.buffer = [];
					obj.boolean_struct.CRC = false;
					obj.CheckCRC()
					if obj.calc_payload(obj.ID_R)>2
						decode_payload(obj, strcat('ID_',dec2hex(obj.ID_R,2)));
					end
					obj.CheckStatus()
				end
			else
				warning('RECEIVED BYTES ARE NO EXPECTED. Buffer will be cleaned.')
				obj.buffer = [];
			end
		end
		
		%Check if Status isnot 0 0
		function CheckStatus(obj)
% 			ID_ = strcat('ID_',dec2hex(obj.ID_R,2));
% 			status_ = obj.msg_table.msg_tbl.(ID_).STATUS;
			if obj.verbose
				obj.decode_status(dec2hex(obj.ID_R,2))
			end
		end
		
		function CheckCRC(obj)
			ID_ = strcat('ID_', dec2hex(obj.ID_R));
			msg = [dec2hex(obj.msg_table.msg_tbl.(ID_).ID,2);...
				dec2hex(obj.msg_table.msg_tbl.(ID_).LENGTH,2);...
				dec2hex(obj.msg_table.msg_tbl.(ID_).STATUS,2);...
				dec2hex(obj.msg_table.msg_tbl.(ID_).PAYLOAD,2)];
			obj.update_chksum(msg)
			
			if obj.CRC ~= dec2hex(obj.msg_table.msg_tbl.(ID_).CRC)
				warning('CRC check failed')
			end
		end
		
		%Calculate Payloadlength
		%Calculates the Payload length of a specific ID
		function payload_l = calc_payload(obj,ID)
			low_b = obj.msg_table.msg_tbl.(strcat('ID_',dec2hex(ID,2))).LENGTH(1);
			high_b = obj.msg_table.msg_tbl.(strcat('ID_',dec2hex(ID,2))).LENGTH(2);
			payload_l = low_b + high_b;
		end
		
		%Correct the messageslength in respond table if necesssary 
		function CorrectMsgLength(obj)
			table = obj.msg_table.respond_value_tbl;
			ID_hex = strcat('ID_',dec2hex(obj.ID_R,2));
			try
				table_size = sum([table{ID_hex,'TypeLength'}{:}{:}]);
				msg_size = obj.calc_payload(obj.ID_R)-2;
				if msg_size ~= table_size
					obj.msg_table.respond_value_tbl{ID_hex,'TypeLength'}{:}={msg_size};
				end
			catch
			end
		end
		
		%Convert Data
		%This function is used in every public method. It concatinate the
		%command message and convert it from hex to dec. Also it is
		%checking for CRC-sum.
		function DataEncode(obj)
			%Concatinate Data String
			obj.Data = [obj.preambel;...        %Preambel
				obj.ID;...              %Command ID
				obj.Payload;...         %Payload length
				obj.Command];	         %Command
			
			if obj.use_crc
				obj.update_chksum(obj.Data)
			end
			
			%Checking if CRC set
			if isempty(obj.CRC)
				obj.CRC = obj.CRC_0;
			end
			
			
			obj.Data = [obj.Data; obj.CRC];      %CRC
			%Convert hex 2 dec
			obj.Data = hex2dec(obj.Data);
		end
		
		%Send Data
		%This function is used in every publi   c method. It checks if the
		%connection is opened and sends the data, which is saved in the mem
		%for sending data.
		function DataSend(obj)
			if strcmp(obj.TCPIP.Status,'open')
				fwrite(obj.TCPIP, uint8(obj.Data), 'uint8');
			else
				error(strcat('ERROR: Connection is not open. ',...
					' Error-Code #00001'))
			end
		end
		
		%DecodeStatus
		%Simple Switch case LUT for Status message. USed in method
		%command_complete
		function decode_status(obj,ID)
			status_ = obj.msg_table.msg_tbl.(strcat('ID_',ID)).STATUS;
			switch dec2hex(status_,2)
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
		
		%DecodePayload
		%This function is used in every public method. It depends on Type,
		%TypeLength, number of commands, and symbolname which is given
		%inside the public functions
		function decode_payload(obj,ID)
			end_idx = 0;
			%Read the Values from Table for specific ID
			Num_CMD = obj.msg_table.respond_value_tbl.Num_CMD(ID);
			Type = obj.msg_table.respond_value_tbl.Type{ID};
			TypeLength = obj.msg_table.respond_value_tbl.TypeLength{ID};
			Symbol = obj.msg_table.respond_value_tbl.Symbol{ID};
			Name = obj.msg_table.respond_value_tbl.Name{ID};
			Unit = obj.msg_table.respond_value_tbl.Unit{ID};
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
						%Continue if no Payload Available
						if ~isfield(obj.msg_table.msg_tbl.(ID),'PAYLOAD')
							continue
						end
						dec_str = obj.msg_table.msg_tbl.(ID).PAYLOAD';
						dec_str = dec_str(start_idx:end_idx);
						hex_str = flipud(dec2hex(dec_str,2));
						tmp_int = '';
						for j = 1:size(hex_str,1)
							tmp_int =  strcat(tmp_int, hex_str(j,:));
						end
						tmp_int = hex2dec(tmp_int);
						if iscell(Symbol) && ischar(Symbol{i})
							switch ID
								case 'ID_06'
									obj.decode_loop(tmp_int, Symbol{i})
								case 'ID_46'
									obj.decode_temp(tmp_int, Symbol{i})
								case 'ID_50'
									obj.decode_sysinfo(tmp_int, Symbol{i})
								otherwise
									obj.status.(Symbol{i}) = tmp_int;
							end
						else
							error('ERROR: THIS SHOULD NOT HAPPEN!! FIX THE FUNCTION ARGUMENTS')
						end
					case 'FLOAT'    %TypeLength not used for FLOAT ??? What did I mean
						%Continue if no Payload Available
						if ~isfield(obj.msg_table.msg_tbl.(ID),'PAYLOAD')
							continue
						end
						dec_str = obj.msg_table.msg_tbl.(ID).PAYLOAD';
						dec_str = dec_str(start_idx:end_idx);
						if iscell(Symbol)  && ischar(Symbol{i})
							obj.status.(Symbol{i})= typecast(uint8(dec_str),'single');
						else
							error('ERROR: THIS SHOULD NOT HAPPEN!! FIX THE FUNCTION ARGUMENTS')
						end
					case 'STRING'
						%Continue if no Payload Available
						if ~isfield(obj.msg_table.msg_tbl.(ID),'PAYLOAD')
							continue
						end
						dec_str = obj.msg_table.msg_tbl.(ID).PAYLOAD';
						dec_str = dec_str(start_idx:end_idx);
						tmp_str = char(dec_str);
						if iscell(Symbol) && ischar(Symbol{i})
							obj.status.(Symbol{i}) = tmp_str';
						else
							error('ERROR: THIS SHOULD NOT HAPPEN!! FIX THE FUNCTION ARGUMENTS')
						end
					case 'BITVEC'
						%Continue if no Payload Available
						if ~isfield(obj.msg_table.msg_tbl.(ID),'PAYLOAD')
							continue
						end
						dec_str = obj.msg_table.msg_tbl.(ID).PAYLOAD';
						dec_str = dec_str(start_idx:end_idx);
						dec_str = de2bi(dec_str,8);
						tmp_bivec = zeros(1,4*length(dec_str));
						a=1;b=8;
						for j = 1:size(dec_str,1)
							tmp_bivec(a:b) = dec_str(j,:);
							a=a+8;
							b=b+8;
						end
						if iscell(Symbol) && ischar(Symbol{i})
							obj.status.(Symbol{i})= fliplr(tmp_bivec);
						else
							error('ERROR: THIS SHOULD NOT HAPPEN!! FIX THE FUNCTION ARGUMENTS')
						end
					case 'ENUM'
						%Continue if no Payload Available
						if ~isfield(obj.msg_table.msg_tbl.(ID),'PAYLOAD')
							continue
						end
						dec_str = obj.msg_table.msg_tbl.(ID).PAYLOAD';
						dec_str = dec_str(start_idx:end_idx);
						if iscell(Symbol) && ischar(Symbol{i})
							switch ID
								case 'ID_50'
									obj.decode_sysinfo(dec_str, Symbol{i})
								otherwise
									obj.status.(Symbol{i})= dec_str;
							end
						else
							error('ERROR: THIS SHOULD NOT HAPPEN!! FIX THE FUNCTION ARGUMENTS')
						end
					otherwise
				end
				%Display if Verbose
				if obj.verbose
					disp(strcat(Name{i}, num2str(obj.status.(Symbol{i})),Unit{i}))
				end
			end
		end
		
		%Decode Loop
		function decode_loop(obj, tmp_int, Symbol)
			tmp_hexf = fliplr(dec2hex(tmp_int));
			tmp_hex = '';
			for i = 2:2:size(tmp_hexf,2)
				tmp_hex = strcat(tmp_hex, tmp_hexf(i));
				tmp_hex = strcat(tmp_hex, tmp_hexf(i-1));
			end
			obj.status.(Symbol) = tmp_hex;
		end
		
		%DecodeTemperature
		%This Function decodes the temp integer values to correct °C values.
		%The function is called inside DecodePayload if the return value is
		%Temp.
		function decode_temp(obj,tmp_int, Symbol)
			if (hex2dec('0000') <= tmp_int && tmp_int <= hex2dec('0FFF'))
				tmp_int = tmp_int/10;
				obj.status.(Symbol) = tmp_int;
			elseif (hex2dec('F000') <= tmp_int && tmp_int <= hex2dec('FFFF'))
				tmp_int = (tmp_int - hex2dec('FFFF'))/10;	
				obj.status.(Symbol) = tmp_int;
			else
				error('Value out of expected range. Check gripper and tool.')
			end
		end
		
		%DecodeSysinfo
		%This Function decodes the sysinfo values to readable values.
		%The function is called inside DecodePayload if the return value is
		%Temp.
		function decode_sysinfo(obj, tmp, Symbol)
			switch Symbol
				case 'TYPE'
					obj.status.(Symbol) = obj.enumtype{tmp+1};
				case 'HWREV'
					obj.status.(Symbol) = tmp;
				case 'FW_VERSION'
					tmp = dec2bin(tmp,16);
					HVer = bin2dec(tmp(1:4));
					UVer1 = bin2dec(tmp(5:8));
					UVer2 = bin2dec(tmp(9:12));
					VVer = bin2dec(tmp(13:16));
					obj.status.(Symbol) = strcat(num2str(HVer),'.',...
														  num2str(UVer1),'.',...
														  num2str(UVer2),'.',...
														  num2str(VVer));
				case 'SN'
					obj.status.(Symbol) = tmp;
				otherwise
					error('Wrong Symbol. Check gripper and tool.')
			end
		end
		
		%Updtae Chksum
		%This function is called if CRC is enabled 
		function update_chksum(obj,msg)
			crc = 'FFFF';
			len = size(msg,1);
			
			% Update Checksum over all MessagBytes
			for i = 1:len
				cmp_msg_crc = bitxor(hex2dec(crc),hex2dec(msg(i,:)));
				rm_last_byte = bitand(cmp_msg_crc, hex2dec('00FF'))+1;
				table_value = obj.msg_table.crc_16_lut{rm_last_byte};
				shifted_value = bitxor(hex2dec(table_value), bitshift(hex2dec(crc), -8));
				crc = dec2hex(shifted_value);
			end
			obj.CRC = [crc(3:4); crc(1:2)];
		end
		
		% Listener Function
		% This Function will be called if the Event Listener receives the
		% notification from the CallbackWrapper that the BytesAvailableEvent
		% was triggered
		function onBytes(obj, ~, ~)
			if obj.debug
				disp 'One Byte Available'
			end
			obj.DataReceive()
			if ~isempty(obj.buffer)
				obj.sort_buffer()
			end
		end
	end
end

