%Get Acceleration Function

%   Copyright 2019 Fachhochschule Dortmund LIT


function get_acc(obj)

%Initial Error Check
ErrorCode = 0;
if isfield(obj.msg_table.msg_tbl, 'ID_31')
	if ~(obj.msg_table.msg_tbl.ID_31.STATUS == 0)
		obj.decode_status('31')
		ErrorCode = 1;
	end
end

%create vars for Decode_payload function
obj.decodeprop.Type = {'FLOAT'};
obj.decodeprop.TypeLength = {4};
obj.decodeprop.Num_CMD = size(obj.decodeprop.Type,2);
obj.decodeprop.symbol = {'ACC'};
obj.decodeprop.name = 'Acceleration:';
obj.decodeprop.unit = ' mm/s^2';

if ErrorCode == 0
	obj.ID = '31';                              %ID Acc
	obj.Payload = ['00'; '00'];                 %Payload length Acc
	obj.Command = [];                           %no Payload
	
	DataEncode(obj);
	DataSend(obj);
	
% 	while ~isfield(obj.msg_table.msg_tbl, 'ID_31')
% 		pause(0.01)
% 	end
% 	while ~isfield(obj.msg_table.msg_tbl.ID_31, 'PAYLOAD')
% 		pause(0.01)
% 	end
% 	decode_payload(obj,obj.ID,Type,TypeLength,Num_CMD,symbol);
% 	if obj.verbose
% 		disp(strcat('Acceleration:', num2str(obj.status.ACC),' mm/s^2'))
% 	end
end
end

