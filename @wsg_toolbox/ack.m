%ack Function
% DESCRIPTION
% This method is used to acknowledge a fast-stop command.
%
% PARAMETER:
% none

%   Copyright 2020 - 2021 Fachhochschule Dortmund LIT
%       $Revision: 1.0.0 $
%       $Author: Matti Kaupenjohann $
%       $Date: 2021/03/21 $

function ack(obj)

ErrorCode = 0;

if ErrorCode == 0
	obj.ID = '24';                              %ID Graps
	obj.Payload = ['03'; '00'];                 %Payload length grasp
	obj.Command = ['61'; '63'; '6B'];           %No Command
	
	DataEncode(obj);
	DataSend(obj);
end
end
