%gripperstate function

%   Copyright 2020 Fachhochschule Dortmund LIT


function gripper_state(obj,change, automatic,time)

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
	obj.ID = '41';                              %ID systemstate
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
	
	% 	if obj.verbose
	% 		disp(strcat('GRIPPER STATUS: ', num2str(obj.status.GSTATE)))
	% 		switch obj.status.GSTATE
	% 			case 0
	% 				disp('IDLE')
	% 			case 1
	% 				disp('GRASPING')
	% 			case 2
	% 				disp('NO PART FOUND')
	% 			case 3
	% 				disp('PART LOST')
	% 			case 4
	% 				disp('HOLDING')
	% 			case 5
	% 				disp('RELEASING')
	% 			case 6
	% 				disp('POSITIONING')
	% 			case 7
	% 				disp('ERROR')
	% 			otherwise
	% 				disp('RESERVED')
	% 		end
	% 	end
end
end
