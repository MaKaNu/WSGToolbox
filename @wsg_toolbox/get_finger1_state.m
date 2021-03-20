% Get Finger 1 State Function

%   Copyright 2020 Fachhochschule Dortmund LIT

function get_finger1_state(obj)

ErrorCode = 0;

if ErrorCode == 0
	obj.ID = '61';                              %ID Finger 1 Info
	obj.Payload = ['00'; '00'];                 %Payload length grasp
	obj.Command = [];									  %No Command
	
	DataEncode(obj);
	DataSend(obj);
end
end