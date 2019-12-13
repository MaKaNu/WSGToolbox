%Get Force Function

%   Copyright 2019 Fachhochschule Dortmund LIT


function get_force(obj)

%Initial Error Check
ErrorCode = 0;
if isfield(obj.msg_table.msg_tbl, 'ID_33')
	if ~(obj.msg_table.msg_tbl.ID_33.STATUS == 0)
		obj.decode_status('33')
		ErrorCode = 1;
	end
end

if ErrorCode == 0
	obj.ID = '33';                              %ID get Force
	obj.Payload = ['00'; '00'];                 %Payload length Acc
	obj.Command = [];                           %no Payload
	
	DataEncode(obj);
	DataSend(obj);
end
end

