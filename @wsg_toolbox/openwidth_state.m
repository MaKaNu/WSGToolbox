%gripperstate function

%   Copyright 2020 - 2021 Fachhochschule Dortmund LIT
%       $Revision: 1.0.1 $
%       $Author: Matti Kaupenjohann $
%       $Date: 2021/03/22 $


function openwidth_state(obj,change, automatic,time)

ErrorCode = 0;

%Data Check and Adjustment
switch length(num2str(time))
	case 2
		tmp = num2str(time);
		time_ = [tmp; '00'];
	case 3
		tmp = num2str(time);
		time_ = [tmp(2:3); strcat('0', tmp(1))];
	case 4
		tmp = num2str(time);
		time_ = [tmp(3:4); tmp(1:2)];
	otherwise
		error('time interval has to be between 10 and 9999!');
end


if ErrorCode == 0
	obj.ID = '43';                              %ID systemstate
	obj.Payload = ['03'; '00'];                 %Payload length systemstate
	
	if automatic && change
		obj.Command = ['03';time_];
	elseif change
		obj.Command = ['02';time_];             % This Option is irrelvant
		warning('Just Because something is possible, doesnt mean it is usefull!')
	elseif automatic
		obj.Command = ['01';time_];
	else
		obj.Command = ['00';time_];
	end
	
	DataEncode(obj);
	DataSend(obj);

end
end
