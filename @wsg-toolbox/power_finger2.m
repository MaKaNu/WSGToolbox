% get syslimits Function

%   Copyright 2020 Fachhochschule Dortmund LIT

function power_finger2(obj, enable)
if ~islogical(enable)
	warning('please use correct logical value!')
	return
end

if enable
	on_off = '01';
else
	on_off = '00';
end

ErrorCode = 0;

if ErrorCode == 0
	obj.ID = '72';                              %ID Finger 1 Info
	obj.Payload = ['01'; '00'];                 %Payload length grasp
	obj.Command = [on_off];									  %No Command
	
	DataEncode(obj);
	DataSend(obj);
end
end