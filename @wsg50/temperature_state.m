%gripperstate function

%   Copyright 2019 Fachhochschule Dortmund LIT


function temperature_state(obj)

ErrorCode = 0;

if ErrorCode == 0
	obj.ID = '46';                              %ID temp_state
	obj.Payload = ['00'; '00'];                 %Payload length temp_state
	obj.Command = [];                           %No Command
	
	DataEncode(obj);
	DataSend(obj);

end
end
