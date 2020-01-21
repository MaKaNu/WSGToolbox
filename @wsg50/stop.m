%stop Function

%   Copyright 2019 Fachhochschule Dortmund LIT


function stop(obj)

ErrorCode = 0;

if ErrorCode == 0
	obj.ID = '22';                              %ID Graps
	obj.Payload = ['00'; '00'];                 %Payload length grasp
	obj.Command = [];                           %No Command
	
	DataEncode(obj);
	DataSend(obj);
end
end
