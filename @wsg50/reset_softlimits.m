%reset Softlimits Function

%   Copyright 2019 Fachhochschule Dortmund LIT


function reset_softlimits(obj)

%Initial Error Check
ErrorCode = 0;
if isfield(obj.msg_table.msg_tbl, 'ID_36')
	if ~(obj.msg_table.msg_tbl.ID_36.STATUS == 0)
		obj.decode_status('36')
		ErrorCode = 1;
	end
end


if ErrorCode == 0
	obj.ID = '36';                              %ID reset Softlimits
	obj.Payload = ['00'; '00'];                 %Payload length
	obj.Command = [];                           %no Payload
	
	DataEncode(obj);
	DataSend(obj);

	obj.status.LIMITS = false;
end
end

