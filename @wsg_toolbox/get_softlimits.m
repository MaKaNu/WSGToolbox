%Get Force Function

%   Copyright 2020 - 2021 Fachhochschule Dortmund LIT
%       $Revision: 1.0.1 $
%       $Author: Matti Kaupenjohann $
%       $Date: 2021/03/22 $


function get_softlimits(obj)

ErrorCode = 0;

if ErrorCode == 0
	obj.ID = '35';                              %ID get Force
	obj.Payload = ['00'; '00'];                 %Payload length Acc
	obj.Command = [];                           %no Payload
	
	DataEncode(obj);
	DataSend(obj);

end
end

