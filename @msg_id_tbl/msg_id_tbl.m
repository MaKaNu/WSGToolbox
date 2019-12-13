classdef msg_id_tbl < handle
	%MAG_ID_TBL Summary of this class goes here
	%   Detailed explanation goes here
	
	properties
		active
		msg_tbl = struct;
		respond_value_tbl;
		IDs
	end
	
	methods
		function obj = msg_id_tbl(varargin)
			%MAG_ID_TBL Construct an instance of this class
			%   Detailed explanation goes here
			obj.active = true;
			Types = {'cell','cell','int8','cell','cell','cell'};
			Names = {'Type','TypeLength','Num_CMD','Symbol','Name','Unit'};
			obj.CreateRespondTable(Types,Names)
			obj.FillRespondTable()
			
		end
		
		function CreateRespondTable(obj,Types,Names)
			IDsAll = ['06';'07';...
				'20';'21';'22';'23';'24';'25';'26';...
				'30';'31';'32';'33';'34';'35';'36';'37';'38';...
				'40';'41';'42';'43';'44';'45';'46';...
				'50';'51';'52';'53';...
				'60';'61';'62';'63';...
				'70';'71';'72';'73'];
			IDResponse = [1;0;...
				0;0;0;0;0;0;0;...
				0;1;0;1;0;1;0;0;0;...
				1;1;1;1;1;1;1;...
				1;0;1;1;...
				1;1;0;1;...
				1;1;0;1];
			obj.IDs = IDsAll(IDResponse==1,:);
			Rows = cellstr(strcat('ID_', string(obj.IDs)));
			obj.respond_value_tbl = table('Size',[size(obj.IDs,1) 6],...
				'VariableTypes',Types,...
				'VariableNames',Names,...
				'RowNames',Rows);
		end
		
		function FillRespondTable(obj)
			%Fill Respond of Command ID 06h
			obj.respond_value_tbl{'ID_06','Type'}{:} = {
				'INTEGER'};
			obj.respond_value_tbl{'ID_06','TypeLength'}{:} = {5}; %NEED TO BE FIXED
			NUM_CMD = size(obj.respond_value_tbl{'ID_06','Type'}{:},2);
			obj.respond_value_tbl{'ID_06','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_06','Symbol'}{:} = {
				'LOOPDATA'};
			obj.respond_value_tbl{'ID_06','Name'}{:} = {
				'Your Entry: '};
			obj.respond_value_tbl{'ID_06','Unit'}{:} = {''};
			
			%Fill Respond of Command ID 31h
			obj.respond_value_tbl{'ID_31','Type'}{:} = {
				'FLOAT'};
			obj.respond_value_tbl{'ID_31','TypeLength'}{:} = {4}; 
			NUM_CMD = size(obj.respond_value_tbl{'ID_31','Type'}{:},2);
			obj.respond_value_tbl{'ID_31','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_31','Symbol'}{:} = {
				'ACC'};
			obj.respond_value_tbl{'ID_31','Name'}{:} = {
				'Acceleration: '};
			obj.respond_value_tbl{'ID_31','Unit'}{:} = {' mm/s^2'};
			
			%Fill Respond of Command ID 33h
			obj.respond_value_tbl{'ID_33','Type'}{:} = {
				'FLOAT'};
			obj.respond_value_tbl{'ID_33','TypeLength'}{:} = {4}; 
			NUM_CMD = size(obj.respond_value_tbl{'ID_33','Type'}{:},2);
			obj.respond_value_tbl{'ID_33','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_33','Symbol'}{:} = {
				'FORCE'};
			obj.respond_value_tbl{'ID_33','Name'}{:} = {'Force: '};
			obj.respond_value_tbl{'ID_33','Unit'}{:} = {' N'};
			
			%Fill Respond of Command ID 35h
			obj.respond_value_tbl{'ID_35','Type'}{:} = {
				'FLOAT', 'FLOAT'};
			obj.respond_value_tbl{'ID_35','TypeLength'}{:} = {4, 4}; 
			NUM_CMD = size(obj.respond_value_tbl{'ID_35','Type'}{:},2);
			obj.respond_value_tbl{'ID_35','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_35','Symbol'}{:} = {
				'LIMIT_MINUS','LIMIT_PLUS'};
			obj.respond_value_tbl{'ID_35','Name'}{:} = {
				'Inner Limit: ', 'Outer Limit: '};
			obj.respond_value_tbl{'ID_35','Unit'}{:} = {' mm', ' mm'};
			
			%Fill Respond of Command ID 40h
			obj.respond_value_tbl{'ID_40','Type'}{:} = {
				'BITVEC'};
			obj.respond_value_tbl{'ID_40','TypeLength'}{:} = {4}; 
			NUM_CMD = size(obj.respond_value_tbl{'ID_40','Type'}{:},2);
			obj.respond_value_tbl{'ID_40','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_40','Symbol'}{:} = {
				'SSTATE'};
			obj.respond_value_tbl{'ID_40','Name'}{:} = {
				'System status: '};
			obj.respond_value_tbl{'ID_40','Unit'}{:} = {''};
			
			%Fill Respond of Command ID 41h
			obj.respond_value_tbl{'ID_41','Type'}{:} = {
				'ENUM'};
			obj.respond_value_tbl{'ID_41','TypeLength'}{:} = {1}; 
			NUM_CMD = size(obj.respond_value_tbl{'ID_41','Type'}{:},2);
			obj.respond_value_tbl{'ID_41','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_41','Symbol'}{:} = {
				'GSTATE'};
			obj.respond_value_tbl{'ID_41','Name'}{:} = {
				'Gripper status: '};
			obj.respond_value_tbl{'ID_41','Unit'}{:} = {''};
		
			%Fill Respond of Command ID 42h
			obj.respond_value_tbl{'ID_42','Type'}{:} = {
				'INTEGER', 'INTEGER', 'INTEGER'};
			obj.respond_value_tbl{'ID_42','TypeLength'}{:} = {4, 2, 2}; 
			NUM_CMD = size(obj.respond_value_tbl{'ID_42','Type'}{:},2);
			obj.respond_value_tbl{'ID_42','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_42','Symbol'}{:} = {
				'TOTAL', 'NO_PART', 'LOST_PART'};
			obj.respond_value_tbl{'ID_42','Name'}{:} = {
				'Number grasps: ','Number no part Found: ',...
				'Number lost parts: '};
			obj.respond_value_tbl{'ID_42','Unit'}{:} = {'', '', ''};

			%Fill Respond of Command ID 43h
			obj.respond_value_tbl{'ID_43','Type'}{:} = {
				'FLOAT'};
			obj.respond_value_tbl{'ID_43','TypeLength'}{:} = {4}; 
			NUM_CMD = size(obj.respond_value_tbl{'ID_41','Type'}{:},2);
			obj.respond_value_tbl{'ID_43','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_43','Symbol'}{:} = {
				'WIDTH'};
			obj.respond_value_tbl{'ID_43','Name'}{:} = {
				'Opening width: '};
			obj.respond_value_tbl{'ID_43','Unit'}{:} = {' mm'};
			
			%Fill Respond of Command ID 44h
			obj.respond_value_tbl{'ID_44','Type'}{:} = {
				'FLOAT'};
			obj.respond_value_tbl{'ID_44','TypeLength'}{:} = {4}; 
			NUM_CMD = size(obj.respond_value_tbl{'ID_44','Type'}{:},2);
			obj.respond_value_tbl{'ID_44','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_44','Symbol'}{:} = {
				'SPEED'};
			obj.respond_value_tbl{'ID_44','Name'}{:} = {
				'Finger velocity: '};
			obj.respond_value_tbl{'ID_44','Unit'}{:} = {' mm/s'};

			%Fill Respond of Command ID 45h
			obj.respond_value_tbl{'ID_45','Type'}{:} = {
				'FLOAT'};
			obj.respond_value_tbl{'ID_45','TypeLength'}{:} = {4}; 
			NUM_CMD = size(obj.respond_value_tbl{'ID_45','Type'}{:},2);
			obj.respond_value_tbl{'ID_45','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_45','Symbol'}{:} = {
				'FINGERFORCE'};
			obj.respond_value_tbl{'ID_45','Name'}{:} = {
				'Finger force: '};
			obj.respond_value_tbl{'ID_45','Unit'}{:} = {' N'};
			
			%Fill Respond of Command ID 46h
			obj.respond_value_tbl{'ID_46','Type'}{:} = {
				'FLOAT'};
			obj.respond_value_tbl{'ID_46','TypeLength'}{:} = {2}; 
			NUM_CMD = size(obj.respond_value_tbl{'ID_46','Type'}{:},2);
			obj.respond_value_tbl{'ID_46','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_46','Symbol'}{:} = {
				'TEMP'};
			obj.respond_value_tbl{'ID_46','Name'}{:} = {
				'Temperature: '};
			obj.respond_value_tbl{'ID_46','Unit'}{:} = {' °C'};
			
			%Fill Respond of Command ID 50h
			obj.respond_value_tbl{'ID_50','Type'}{:} = {
				'ENUM', 'INTEGER','INTEGER', 'INTEGER'};
			obj.respond_value_tbl{'ID_50','TypeLength'}{:} = {1, 1, 2, 4}; 
			NUM_CMD = size(obj.respond_value_tbl{'ID_46','Type'}{:},2);
			obj.respond_value_tbl{'ID_50','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_50','Symbol'}{:} = {
				'TYPE', 'HWREV','FW_VERSION', 'SN'};
			obj.respond_value_tbl{'ID_50','Name'}{:} = {
				'Device type: ','Hardware revision: ',...
				'Firmware version: ', 'Serialnumber: '};
			obj.respond_value_tbl{'ID_50','Unit'}{:} = {'','','',''};
			
			%Fill Respond of Command ID 52h
			obj.respond_value_tbl{'ID_52','Type'}{:} = {
				'STRING'};
			obj.respond_value_tbl{'ID_52','TypeLength'}{:} = {4}; %NEED TO BE FIXED
			NUM_CMD = size(obj.respond_value_tbl{'ID_52','Type'}{:},2);
			obj.respond_value_tbl{'ID_52','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_52','Symbol'}{:} = {
				'TAG'};
			obj.respond_value_tbl{'ID_52','Name'}{:} = {
				'Device tag: '};
			obj.respond_value_tbl{'ID_52','Unit'}{:} = {''};
			
			%Fill Respond of Command ID 53h
			obj.respond_value_tbl{'ID_53','Type'}{:} = {
				'FLOAT','FLOAT','FLOAT','FLOAT',...
				'FLOAT','FLOAT','FLOAT','FLOAT'};
			obj.respond_value_tbl{'ID_53','TypeLength'}{:} = {
				4,4,4,4,4,4,4,4};
			NUM_CMD = size(obj.respond_value_tbl{'ID_53','Type'}{:},2);
			obj.respond_value_tbl{'ID_53','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_53','Symbol'}{:} = {
				'TOTALSTROKE', 'MIN_SPEED', 'MAX_SPEED','MIN_ACC',...
				'MAX_ACC', 'MIN_FORCE','NOM_FORCE', 'OVR_FORCE' };
			obj.respond_value_tbl{'ID_53','Name'}{:} = {
				'Total width: ', 'Minimum velocity: ', 'Maximum velocity: ',...
				'Minimum acceleration: ','Maximum acceleration: ',...
				'Minimum force: ', 'Nominal force: ', 'Overdrive Force: '};
			obj.respond_value_tbl{'ID_53','Unit'}{:} = {
				' mm', ' mm/s', ' mm/s', ' mm/sÂ²',....
				' mm/s^2', ' N', ' N', ' N'};
		
			%Fill Respond of Command ID 60h
			obj.respond_value_tbl{'ID_60','Type'}{:} = {
				'ENUM', 'INTEGER'};
			obj.respond_value_tbl{'ID_60','TypeLength'}{:} = {1,2};
			NUM_CMD = size(obj.respond_value_tbl{'ID_60','Type'}{:},2);
			obj.respond_value_tbl{'ID_60','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_60','Symbol'}{:} = {
				'FINGERTYPE1', 'SIZE1'};
			obj.respond_value_tbl{'ID_60','Name'}{:} = {
				'Finger 1 type: ', 'Data Size: '};
			obj.respond_value_tbl{'ID_60','Unit'}{:} = {'', ''};
			
			%Fill Respond of Command ID 61h
			obj.respond_value_tbl{'ID_61','Type'}{:} = {
				'BITVEKTOR'};
			obj.respond_value_tbl{'ID_61','TypeLength'}{:} = {2};
			NUM_CMD = size(obj.respond_value_tbl{'ID_61','Type'}{:},2);
			obj.respond_value_tbl{'ID_61','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_61','Symbol'}{:} = {
				'FLAGS1'};
			obj.respond_value_tbl{'ID_61','Name'}{:} = {
				'Finger 1 Flags: '};
			obj.respond_value_tbl{'ID_61','Unit'}{:} = {''};
			
			%Fill Respond of Command ID 63h
			obj.respond_value_tbl{'ID_63','Type'}{:} = {
				'STRING'};
			obj.respond_value_tbl{'ID_63','TypeLength'}{:} = {4}; %NEED TO BE FIXED
			NUM_CMD = size(obj.respond_value_tbl{'ID_63','Type'}{:},2);
			obj.respond_value_tbl{'ID_63','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_63','Symbol'}{:} = {
				'FINGER1'};
			obj.respond_value_tbl{'ID_63','Name'}{:} = {
				'specific '};
			obj.respond_value_tbl{'ID_63','Unit'}{:} = {''};
		
			%Fill Respond of Command ID 70h
			obj.respond_value_tbl{'ID_70','Type'}{:} = {
				'ENUM', 'INTEGER'};
			obj.respond_value_tbl{'ID_70','TypeLength'}{:} = {1,2};
			NUM_CMD = size(obj.respond_value_tbl{'ID_70','Type'}{:},2);
			obj.respond_value_tbl{'ID_70','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_70','Symbol'}{:} = {
				'FINGERTYPE2', 'SIZE2'};
			obj.respond_value_tbl{'ID_70','Name'}{:} = {
				'Finger 2 type: ', 'Data Size: '};
			obj.respond_value_tbl{'ID_70','Unit'}{:} = {'', ''};
			
			%Fill Respond of Command ID 71h
			obj.respond_value_tbl{'ID_71','Type'}{:} = {
				'BITVEKTOR'};
			obj.respond_value_tbl{'ID_71','TypeLength'}{:} = {2};
			NUM_CMD = size(obj.respond_value_tbl{'ID_71','Type'}{:},2);
			obj.respond_value_tbl{'ID_71','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_71','Symbol'}{:} = {
				'FLAGS2'};
			obj.respond_value_tbl{'ID_71','Name'}{:} = {
				'Finger 2 Flags: '};
			obj.respond_value_tbl{'ID_71','Unit'}{:} = {''};
			
			%Fill Respond of Command ID 73h
			obj.respond_value_tbl{'ID_73','Type'}{:} = {
				'STRING'};
			obj.respond_value_tbl{'ID_73','TypeLength'}{:} = {4}; %NEED TO BE FIXED
			NUM_CMD = size(obj.respond_value_tbl{'ID_73','Type'}{:},2);
			obj.respond_value_tbl{'ID_73','Num_CMD'} = NUM_CMD;
			obj.respond_value_tbl{'ID_73','Symbol'}{:} = {
				'FINGER2'};
			obj.respond_value_tbl{'ID_73','Name'}{:} = {
				'specific '};
			obj.respond_value_tbl{'ID_73','Unit'}{:} = {''};

		end
		
		function new_ID(obj,ID_num)
			%METHOD1 Summary of this method goes here
			%   Detailed explanation goes here
			ID_entry = strcat('ID_',dec2hex(ID_num,2));
			obj.msg_tbl.(ID_entry).('ID') = ID_num;
		end
		
		function enter_ID_val(obj,ID_num,field,value)
			ID_entry = strcat('ID_',dec2hex(ID_num,2));
			obj.msg_tbl.(ID_entry).(field) = value;
		end
	end
end

