%Get Force Function

%   Copyright 2020 Fachhochschule Dortmund LIT


function get_force(obj)

ErrorCode = 0;

if ErrorCode == 0
	obj.ID = '33';                              %ID get Force
	obj.Payload = ['00'; '00'];                 %Payload length Acc
	obj.Command = [];                           %no Payload
	
	DataEncode(obj);
	DataSend(obj);
end
end
