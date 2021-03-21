% Get Finger 2 data Function

%   Copyright 2020 - 2021 Fachhochschule Dortmund LIT
%       $Revision: 1.0.0 $
%       $Author: Matti Kaupenjohann $
%       $Date: 2021/03/21 $

function get_finger2_data(obj)

ErrorCode = 0;

if ErrorCode == 0
	obj.ID = '73';                              %ID Finger 1 Info
	obj.Payload = ['00'; '00'];                 %Payload length grasp
	obj.Command = [];									  %No Command
	
	DataEncode(obj);
	DataSend(obj);
end
end