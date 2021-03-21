% get syslimits Function

%   Copyright 2020 - 2021 Fachhochschule Dortmund LIT
%       $Revision: 1.0.0 $
%       $Author: Matti Kaupenjohann $
%       $Date: 2021/03/21 $

function power_finger1(obj, enable)
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
	obj.ID = '62';                              %ID Finger 1 Info
	obj.Payload = ['01'; '00'];                 %Payload length grasp
	obj.Command = [on_off];									  %No Command
	
	DataEncode(obj);
	DataSend(obj);
end
end