classdef msg_id_tbl < handle
	%MAG_ID_TBL Summary of this class goes here
	%   Detailed explanation goes here
	
	properties
		active
		msg_tbl = struct;
		respond_value_tbl;
		crc_16_lut
		IDs
		data_path
	end
	
	methods
		function obj = msg_id_tbl(varargin)
			%MAG_ID_TBL Construct an instance of this class
			%   Detailed explanation goes here
			obj.active = true;
			obj.data_path = which('wsg50');
			obj.data_path = obj.data_path(1:end-14);
			obj.LoadRespondTable()
			obj.LoadCRC16LUT()
			
		end
		
		function LoadRespondTable(obj)
			tmp = load(strcat(obj.data_path,'\data\respond.mat'));
			obj.respond_value_tbl = tmp.RespondTable;
		end
		
		function LoadCRC16LUT(obj)
			tmp = load(strcat(obj.data_path,'data\CRC16Table.mat'));
			obj.crc_16_lut = tmp.CRC16Table';
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

