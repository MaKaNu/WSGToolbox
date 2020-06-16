%ack Function

%   Copyright 2020 Fachhochschule Dortmund LIT

function ack(obj)

ErrorCode = 0;

if ErrorCode == 0
	obj.ID = '24';                              %ID Graps
	obj.Payload = ['03'; '00'];                 %Payload length grasp
	obj.Command = ['61'; '63'; '6B'];           %No Command
	
	DataEncode(obj);
	DataSend(obj);
end
end
