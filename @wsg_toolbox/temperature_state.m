%gripperstate function

%   Copyright 2020 - 2021 Fachhochschule Dortmund LIT
%       $Revision: 1.0.0 $
%       $Author: Matti Kaupenjohann $
%       $Date: 2021/03/21 $


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
