%Get Device Tag function

%   Copyright 2020 Fachhochschule Dortmund LIT


function get_device_tag(obj)

ErrorCode = 0;

if ErrorCode == 0
	obj.ID = '52';                              %ID get device tag
	obj.Payload = ['00'; '00'];                 %Payload length temp_state
	obj.Command = [];                           %No Command
	
	DataEncode(obj);
	DataSend(obj);

end
end
