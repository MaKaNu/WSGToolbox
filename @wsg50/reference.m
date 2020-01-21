%Reference function

%   Copyright 2019 Fachhochschule Dortmund LIT


function reference(obj,direction)

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
