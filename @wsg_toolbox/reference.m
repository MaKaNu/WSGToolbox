%Reference function
% DESCRIPTION
% This method is used to perform a reference motion with the gripper. The 
% best precision will be achieved if the reference motion is executed in
% the same direction as later the grasp motion.
%
% PARAMETER
% direction

%   Copyright 2020 - 2021 Fachhochschule Dortmund LIT
%       $Revision: 1.0.1 $
%       $Author: Matti Kaupenjohann $
%       $Date: 2021/03/22 $


function reference(obj,direction)

ErrorCode = 0;

switch direction
	case 'open'
		cmd = '01';
	case 'close'
		cmd = '02';
	otherwise
		cmd = '00';
end

if ErrorCode == 0
	obj.ID = '20';                      %ID Graps
	obj.Payload = ['01'; '00'];         %Payload length
	obj.Command = cmd;                  %Speed in Enum Little Endian
	
	DataEncode(obj);
	DataSend(obj);
	
end

end
