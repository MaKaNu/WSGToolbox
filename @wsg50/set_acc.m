%Set Acceleration Function

%   Copyright 2020 Fachhochschule Dortmund LIT


function set_acc(obj,acc)

ErrorCode = 0;

if (isa(acc,'double') || isa(acc,'single'))
	if not(acc<=5000.0 && acc >= 100.0)
		warning('Warning: Acceleration set to min or max.');
	end
	acc_hex = num2hex(single(acc));
	acc1 = acc_hex(7:8); acc2 = acc_hex(5:6); acc3 = acc_hex(3:4); acc4 = acc_hex(1:2);
else
	error(strcat('ERROR: Variable-Type is not correct.',...
		' Error-Code #30002'))
	ErrorCode = 1;
end

if ErrorCode == 0
	obj.ID = '30';                              %ID Acc
	obj.Payload = ['04'; '00'];                 %Payload length Acc
	obj.Command = [acc1; acc2; acc3; acc4];     %Acceleration in Float Little Endian
	
	DataEncode(obj);
	DataSend(obj);
	
end
end

