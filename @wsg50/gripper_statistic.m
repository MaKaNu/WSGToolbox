% gripper_statistic function

%   Copyright 2019 Fachhochschule Dortmund LIT


function gripper_statistic(obj,reset)


%Initial Error Check
ErrorCode = 0;
if isfield(obj.msg_table.msg_tbl, 'ID_42')
	if ~(obj.msg_table.msg_tbl.ID_42.STATUS == 0)
		obj.decode_status('42')
		ErrorCode = 1;
	end
end

if ErrorCode == 0
	obj.ID = '42';                              %ID systemstate
	obj.Payload = ['01'; '00'];                 %Payload length systemstate
	
	if reset
		obj.Command = '01';
	else
		obj.Command = '00';
	end
	
	DataEncode(obj);
	DataSend(obj);
end
end
