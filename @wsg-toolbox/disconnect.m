% disconnect function
% DESCRIPTION
% This Function closes the connection between the users computer and the 
% gripper. Befor doing this, a command informs the gripper that the 
% connection will be closed. THis function will always be called if the
% gripper instance will be destructed.
%
% PARMAETER
% none


%   Copyright 2020 Fachhochschule Dortmund LIT

function disconnect(Obj)

ErrorCode = 0;

if ErrorCode == 0
	Obj.ID = '07';                                      %ID Disconnect
	Obj.Payload = '00';
	Obj.Command = [];
	
	DataEncode(Obj);
	DataSend(Obj);
	if Obj.TCPIP.BytesAvailable>0
		flushinput(Obj.TCPIP)
	end
	fclose(Obj.TCPIP);
end
end