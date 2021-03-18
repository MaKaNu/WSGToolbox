%System info function

%   Copyright 2020 Fachhochschule Dortmund LIT


function sys_info(obj)

ErrorCode = 0;

if ErrorCode == 0
	obj.ID = '50';                              %ID system info
	obj.Payload = ['00'; '00'];                 %Payload length temp_state
	obj.Command = [];                           %No Command
	
	DataEncode(obj);
	DataSend(obj);

end
end
