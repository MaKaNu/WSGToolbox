%stop Function

%   Copyright 2020 - 2021 Fachhochschule Dortmund LIT
%       $Revision: 1.0.1 $
%       $Author: Matti Kaupenjohann $
%       $Date: 2021/03/22 $


function stop(obj)

ErrorCode = 0;

if ErrorCode == 0
	obj.ID = '22';                              %ID Graps
	obj.Payload = ['00'; '00'];                 %Payload length grasp
	obj.Command = [];                           %No Command
	
	DataEncode(obj);
	DataSend(obj);
end
end
