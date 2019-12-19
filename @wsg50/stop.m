%stop Function

%   Copyright 2019 Fachhochschule Dortmund LIT


function stop(obj)


%Initial Error Check
ErrorCode = 0;
if isfield(obj.msg_table.msg_tbl, 'ID_22')
	if ~(obj.msg_table.msg_tbl.ID_22.STATUS == 0)
		obj.decode_status('22')
		ErrorCode = 1;
	end
end

if ErrorCode == 0
	obj.ID = '22';                              %ID Graps
	obj.Payload = ['00'; '00'];                 %Payload length grasp
	obj.Command = [];                           %No Command
	
	DataEncode(obj);
	DataSend(obj);
end
end
