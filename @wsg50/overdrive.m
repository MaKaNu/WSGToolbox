%overdrive Function

%   Copyright 2020 Fachhochschule Dortmund LIT


function overdrive(obj,bool)

%%%%%% DEPRECATED %%%%%%% 
ErrorCode = 1;
error('This function is deprecated and will no longer be supported')
%%%%%%%%%%%%%%%%%%%%%%%%%

switch bool
	case 1
		flag_vec = [0 0 0 0 0 0 0 1];
		warning('Use overdrivemode carefully. Could cause destruction.')
		obj.status.OVERDRIVE = true;
	case 0
		flag_vec = [0 0 0 0 0 0 0 0];
		obj.status.OVERDRIVE = false;
	otherwise
		error(strcat('ERROR: Variable-Type is not correct.',...
			' Error-Code #37001'))
		ErrorCode = 1;
end

if ErrorCode == 0
	obj.ID = '37';                                      %ID set Force
	obj.Payload = ['01'; '00'];                         %Payload length Force
	obj.Command = binaryVectorToHex(flag_vec);          %Force in Float Little Endian
	
	DataEncode(obj);
	DataSend(obj);

end
end
