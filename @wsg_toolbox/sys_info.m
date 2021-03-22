%System info function

%   Copyright 2020 - 2021 Fachhochschule Dortmund LIT
%       $Revision: 1.0.1 $
%       $Author: Matti Kaupenjohann $
%       $Date: 2021/03/22 $


function sys_info(obj)

ErrorCode = 0;

if ErrorCode == 0
	obj.ID = '50';                              %ID system info
	obj.Payload = ['00'; '00'];                 %Payload length temp_state
	obj.Command = [];                           %No Command
	
	DataEncode(obj);
	DataSend(obj);

end
end
