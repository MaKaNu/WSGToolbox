% get syslimits Function

%   Copyright 2020 Fachhochschule Dortmund LIT

function get_syslimits(obj)

ErrorCode = 0;

if ErrorCode == 0
	obj.ID = '53';                              %ID system infos
	obj.Payload = ['00'; '00'];                 %Payload length grasp
	obj.Command = [];									  %No Command
	
	DataEncode(obj);
	DataSend(obj);
end
end
