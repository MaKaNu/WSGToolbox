%Get Acceleration Function

%   Copyright 2020 Fachhochschule Dortmund LIT


function get_acc(obj)

ErrorCode = 0;

if ErrorCode == 0
	obj.ID = '31';                              %ID Acc
	obj.Payload = ['00'; '00'];                 %Payload length Acc
	obj.Command = [];                           %no Payload
	
	DataEncode(obj);
	DataSend(obj);
end
end

