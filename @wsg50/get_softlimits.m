%Get Force Function

%   Copyright 2019 Fachhochschule Dortmund LIT


function get_softlimits(obj)

%Initial Error Check
ErrorCode = 0;
if isfield(obj.msg_table.msg_tbl, 'ID_35')
	if ~(obj.msg_table.msg_tbl.ID_35.STATUS == 0)
		obj.decode_status('35')
		ErrorCode = 1;
	end
end

if obj.status.LIMITS==false
	warning('No softlimits set. Command will not be executed.')
end

if ErrorCode == 0
	obj.ID = '35';                              %ID get Force
	obj.Payload = ['00'; '00'];                 %Payload length Acc
	obj.Command = [];                           %no Payload
	
	DataEncode(obj);
	DataSend(obj);

end
end

