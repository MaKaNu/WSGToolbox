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
			IDsAll = [6;7;...
				20;21;22;23;24;25;26;...
				30;31;32;33;34;35;36;37;38;...
				40;41;42;43;44;45;46;...
				50;51;52;53;...
				60;61;62;63;...
				70;71;72;73];
			IDResponse = [1;0;...
				0;0;0;0;0;0;0;...
				0;1;0;1;0;1;0;0;0;...
				1;1;1;1;1;1;1;...
				1;0;1;1;...
				1;1;0;1;...
				1;1;0;1];
			obj.IDs = IDsAll(IDsAll.*IDResponse>0);
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
	end
end

