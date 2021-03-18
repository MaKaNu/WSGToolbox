%fast_stop Function

%   Copyright 2020 Fachhochschule Dortmund LIT

function fast_stop(obj)

ErrorCode = 0;

if ErrorCode == 0
	obj.ID = '23';                              %ID Graps
	obj.Payload = ['00'; '00'];                 %Payload length grasp
	obj.Command = [];                           %No Command
	
	DataEncode(obj);
	DataSend(obj);
end
end
