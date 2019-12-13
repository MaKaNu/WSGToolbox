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


if ErrorCode == 0
	obj.ID = '31';                              %ID Acc
	obj.Payload = ['00'; '00'];                 %Payload length Acc
	obj.Command = [];                           %no Payload
	
	DataEncode(obj);
	DataSend(obj);
end
end

