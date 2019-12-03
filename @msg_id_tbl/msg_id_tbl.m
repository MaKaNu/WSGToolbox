classdef msg_id_tbl < handle
	%MAG_ID_TBL Summary of this class goes here
	%   Detailed explanation goes here
	
	properties
		active
		msg_tbl = struct;
	end
	
	methods
		function obj = mag_id_tbl(varargin)
			%MAG_ID_TBL Construct an instance of this class
			%   Detailed explanation goes here
			obj.active = true;
		end
		
		function new_ID(obj,ID_num)
			%METHOD1 Summary of this method goes here
			%   Detailed explanation goes here
			ID_entry = strcat('ID_',dec2hex(ID_num,2));
			obj.msg_tbl.(ID_entry).('ID') = ID_num;
		end
		
		function enter_ID_val(obj,ID_num,field,value)
			obj.msg_tbl.(dec2hex(ID_num,2)).(field) = value;
		end
	end
end

