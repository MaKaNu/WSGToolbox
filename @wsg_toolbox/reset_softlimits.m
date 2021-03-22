%reset Softlimits Function

%   Copyright 2020 - 2021 Fachhochschule Dortmund LIT
%       $Revision: 1.0.1 $
%       $Author: Matti Kaupenjohann $
%       $Date: 2021/03/22 $


function reset_softlimits(obj)

ErrorCode = 0;

if ErrorCode == 0
	obj.ID = '36';                              %ID reset Softlimits
	obj.Payload = ['00'; '00'];                 %Payload length
	obj.Command = [];                           %no Payload
	
	DataEncode(obj);
	DataSend(obj);
	
	obj.status.LIMITS = false;
end
end

