%reset Softlimits Function

%   Copyright 2019 Fachhochschule Dortmund LIT


function reset_softlimits(obj)

if ErrorCode == 0
	obj.ID = '36';                              %ID reset Softlimits
	obj.Payload = ['00'; '00'];                 %Payload length
	obj.Command = [];                           %no Payload
	
	DataEncode(obj);
	DataSend(obj);
	
	obj.status.LIMITS = false;
end
end

