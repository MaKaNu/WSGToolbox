%overdrive Function

%   Copyright 2019 Fachhochschule Dortmund LIT


function overdrive(obj,bool)


%Initial Error Check
ErrorCode = 0;
if isfield(obj.msg_table.msg_tbl, 'ID_37')
	if ~(obj.msg_table.msg_tbl.ID_37.STATUS == 0)
		obj.decode_status('37')
		ErrorCode = 1;
	end
end

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
