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
			obj.respond_value_tbl.Type{1} = {'INTEGER'};
			obj.respond_value_tbl.TypeLength{1} = 5; %NEED TO BE FIXED
			obj.respond_value_tbl.Num_CMD(1) = 1;
			obj.respond_value_tbl.Symbol{1} = {'LOOPDATA'};
			obj.respond_value_tbl.Name{1} = {'Your Entry: '};
			obj.respond_value_tbl.Unit{1} = {''};
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
		
		% ID_31
		%TYPE = {'FLOAT'}
		%TYPELENGTH = {4}
		%NUM_CMD = 1
		%SYMBOL = {'ACC'}
		%NAME = {'Acceleration: '}
		%UNIT = {' mm/s²'}
		
		% ID_33
		%TYPE = {'FLOAT'}
		%TYPELENGTH = {4}
		%NUM_CMD = 1
		%SYMBOL = {'FORCE'}
		%NAME = {'Force: '}
		%UNIT = {' N'}
		
		% ID_35
		%TYPE = {'FLOAT', 'FLOAT'}
		%TYPELENGTH = {4, 4}
		%NUM_CMD = 2
		%SYMBOL = {'LIMIT_MINUS', 'LIMIT_PLUS'}
		%NAME = {'Inner Limit: ', 'Outer Limit: '}
		%UNIT = {' mm', ' mm'}
		
		% ID_40
		%TYPE = {'BITVEKTOR'}
		%TYPELENGTH = {4}
		%NUM_CMD = 1
		%SYMBOL = {'SSTATE'}
		%NAME = {'System Status: '}
		%UNIT = {''}
		
		% ID_41
		%TYPE = {'ENUM'}
		%TYPELENGTH = {1}
		%NUM_CMD = 1
		%SYMBOL = {'GSTATE'}
		%NAME = {'Gripper State: '}
		%UNIT = {''}
		
		% ID_42
		%TYPE = {'INTEGER', 'INTEGER', 'INTEGER'}
		%TYPELENGTH = {4, 2, 2}
		%NUM_CMD = 1
		%SYMBOL = {'TOTAL', 'NO_PART', 'LOST_PART'}
		%NAME = {'Number grasps: ', 'Number no part Found: ', 'Number lost parts: '}
		%UNIT = {'', '', ''}
		
		% ID_43
		%TYPE = {'FLOAT'}
		%TYPELENGTH = {1}
		%NUM_CMD = 1
		%SYMBOL = {'WIDTH'}
		%NAME = {'Opening width: '}
		%UNIT = {' mm'}
		
		% ID_44
		%TYPE = {'FLOAT'}
		%TYPELENGTH = {1}
		%NUM_CMD = 1
		%SYMBOL = {'SPEED'}
		%NAME = {'Finger velocity: '}
		%UNIT = {' mm/s'}
		
		% ID_45
		%TYPE = {'FLOAT'}
		%TYPELENGTH = {1}
		%NUM_CMD = 1
		%SYMBOL = {'FINGERFORCE'}
		%NAME = {'Finger force: '}
		%UNIT = {' N'}
		
		% ID_46
		%TYPE = {'INTEGER'}
		%TYPELENGTH = {2}
		%NUM_CMD = 1
		%SYMBOL = {'TEMP'}
		%NAME = {'Temperature: '}
		%UNIT = {' °C'}
		
		% ID_50
		%TYPE = {'ENUM', 'INTEGER', 'INTEGER', 'INTEGER'}
		%TYPELENGTH = {1, 1, 2, 4}
		%NUM_CMD = 4
		%SYMBOL = {'TYPE', 'HWREV', 'FW_VERSION', 'SN'}
		%NAME = {'Device type: ', 'Hardware revision: ', 'Firmware version: ', 'Serialnumber: '}
		%UNIT = {'', '','',''}
		
		% ID_52
		%TYPE = {'STRING'}
		%TYPELENGTH = {n}
		%NUM_CMD = 1
		%SYMBOL = {'TAG'}
		%NAME = {'Device tag: '}
		%UNIT = {''}
		
		% ID_53
		%TYPE = {'FLOAT','FLOAT','FLOAT','FLOAT','FLOAT','FLOAT','FLOAT','FLOAT'}
		%TYPELENGTH = {4,4,4,4,4,4,4,4}
		%NUM_CMD = 8
		%SYMBOL = {'TOTALSTROKE', 'MIN_SPEED', 'MAX_SPEED', 'MIN_ACC', 'MAX_ACC', 'MIN_FORCE', 'MAX_FORCE', 'NOM_FORCE', 'OVR_FORCE' }
		%NAME = {'Total width: ', 'Minimum velocity: ', 'Maximum velocity: ', 'Minimum acceleration: ','Maximum acceleration: ', 'Minimum force: ', 'Nominal force: ', 'Overdrive Force: '}
		%UNIT = {' mm', ' mm/s', ' mm/s', ' mm/s²', ' mm/s²', ' N', ' N', ' N'}
		
		% ID_60
		%TYPE = {'ENUM', 'INTEGER'}
		%TYPELENGTH = {1,2}
		%NUM_CMD = 2
		%SYMBOL = {'FINGERTYPE1', 'SIZE1'}
		%NAME = {'Finger 1 type: ', 'Data Size: '}
		%UNIT = {'', ''}
		
		% ID_61
		%TYPE = {'BITVEKTOR'}
		%TYPELENGTH = {2}
		%NUM_CMD = 1
		%SYMBOL = {'FLAGS1'}
		%NAME = {'Finger 1 Flags: '}
		%UNIT = {''}
		
		% ID_63
		%NEED TO BE TESTED CHOOSE WHICH FINGERSENSOR
		%TYPE = {'STRING'}
		%TYPELENGTH = {n}
		%NUM_CMD = 1
		%SYMBOL = {'TAG'}
		%NAME = {'Device tag: '}
		%UNIT = {''}
		
		% ID_70
		%TYPE = {'ENUM', 'INTEGER'}
		%TYPELENGTH = {1,2}
		%NUM_CMD = 2
		%SYMBOL = {'FINGERTYPE2', 'SIZE2'}
		%NAME = {'Finger 2 type: ', 'Data Size: '}
		%UNIT = {'', ''}
		
		% ID_71
		%TYPE = {'BITVEKTOR'}
		%TYPELENGTH = {2}
		%NUM_CMD = 1
		%SYMBOL = {'FLAGS2'}
		%NAME = {'Finger 2 Flags: '}
		%UNIT = {''}
		
		% ID_73
		%NEED TO BE TESTED CHOOSE WHICH FINGERSENSOR
		%TYPE = {'STRING'}
		%TYPELENGTH = {n}
		%NUM_CMD = 1
		%SYMBOL = {'TAG'}
		%NAME = {'Device tag: '}
		%UNIT = {''}
	end
end

