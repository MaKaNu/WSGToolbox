%Grasp Function

%   Copyright 2020 - 2021 Fachhochschule Dortmund LIT
%       $Revision: 1.0.0 $
%       $Author: Matti Kaupenjohann $
%       $Date: 2021/03/21 $


function grasp(obj,width,speed)

ErrorCode = 0;

if (isa(width,'double') || isa (width, 'single'))
	if width<=110.0 && width >= 0.0
		width_hex = num2hex(single(width));
		wid1 = width_hex(7:8); wid2 = width_hex(5:6); wid3 = width_hex(3:4); wid4 = width_hex(1:2);
	else
		%                     msgbox('Error, your input-value is not inside the accepted range. Change the value between 0 and 110.','Error')
		error(strcat('ERROR: Input-value is not inside the accepted range.',...
			' Error-Code #25001'))
		ErrorCode = 1;
	end
else
	%                     msgbox('Error, you did not use the correct class-Type. Use instead "single" or "double".','Error')
	error(strcat('ERROR: Variable-Type is not correct.',...
		' Error-Code #25002'))
	ErrorCode = 1;
end



if (isa(speed,'double') || isa(speed, 'single'))
	if speed<= 420.0 && speed>=5.0
		speed_hex = num2hex(single(speed));
		spd1 = speed_hex(7:8); spd2 = speed_hex(5:6); spd3 = speed_hex(3:4); spd4 = speed_hex(1:2);
	else
		%                     msgbox('Error, your input-value is not inside the accepted range. Change the value between 5 and 420.','Error')
		error(strcat('ERROR: Input-value is not inside the accepted range.',...
			' Error-Code #25001'))
		ErrorCode = 1;
	end
else
	%                     msgbox('Error, you did not use the correct var-type. Use instead "single" or "double".','Error')
	error(strcat('ERROR: Variable-Type is not correct.',...
		' Error-Code #25002'))
	ErrorCode = 1;
end

if ErrorCode == 0
	obj.ID = '25';                              %ID Graps
	obj.Payload = ['08'; '00'];                 %Payload length grasp
	obj.Command = [wid1; wid2; wid3; wid4;...   %Width in Float Little Endian
		spd1; spd2; spd3; spd4];     %Speed in Float Little Endian
	
	DataEncode(obj);
	DataSend(obj);
	
end
end

