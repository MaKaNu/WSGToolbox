%Softlimit Function

%   Copyright 2019 Fachhochschule Dortmund LIT


function set_softlimits(obj,minus_limit,plus_limit)

ErrorCode = 0;

if (isa(minus_limit,'double') || isa (minus_limit, 'single'))
	if minus_limit<=110.0 && minus_limit >= 0.0
		minus_hex = num2hex(single(minus_limit));
		minus1 = minus_hex(7:8); minus2 = minus_hex(5:6); minus3 = minus_hex(3:4); minus4 = minus_hex(1:2);
	else
		%                     msgbox('Error, your input-value is not inside the accepted range. Change the value between 0 and 110.','Error')
		error(strcat('ERROR: Input-value is not inside the accepted range.',...
			' Error-Code #34002'))
		ErrorCode = 2;
	end
else
	%                     msgbox('Error, you did not use the correct class-Type. Use instead "single" or "double".','Error')
	error(strcat('ERROR: Variable-Type is not correct.',...
		' Error-Code #34002'))
	ErrorCode = 3;
end



if (isa(plus_limit,'double') || isa(plus_limit, 'single'))
	if plus_limit > minus_limit
		plus_hex = num2hex(single(plus_limit));
		plus1 = plus_hex(7:8); plus2 = plus_hex(5:6); plus3 = plus_hex(3:4); plus4 = plus_hex(1:2);
	else
		%                     msgbox('Error, your input-value is not inside the accepted range. Change the value between 5 and 420.','Error')
		error(strcat('ERROR: Plus-Limit should be greater then Minus-Limit.',...
			' Error-Code #34002'))
		ErrorCode = 2;
	end
else
	%                     msgbox('Error, you did not use the correct var-type. Use instead "single" or "double".','Error')
	error(strcat('ERROR: Variable-Type is not correct.',...
		' Error-Code #34003'))
	ErrorCode = 3;
end

if ErrorCode == 0
	obj.ID = '34';                                      %ID Set Softlimits
	obj.Payload = ['08'; '00'];                         %Payload length grasp
	obj.Command = [minus1; minus2; minus3; minus4;...   %minus_limit in Float Little Endian
		plus1; plus2; plus3; plus4];         %plus_limit in Float Little Endian
	
	DataEncode(obj);
	DataSend(obj);
	
	obj.status.LIMITS = true;
end
end

