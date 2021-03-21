%Set Force Function

%   Copyright 2020 - 2021 Fachhochschule Dortmund LIT
%       $Revision: 1.0.0 $
%       $Author: Matti Kaupenjohann $
%       $Date: 2021/03/21 $


function set_force(obj,force)

ErrorCode = 0;

if (isa(force,'double') || isa(force,'single'))
	if not(force<=80.0 && force >= 5.0)
		if (force > 80 && obj.status.OVERDRIVE)
			warning('Overdrive-Mode is active max force 120 N.')
		else
			warning('Force set to min 5 N or max 80 N.');
		end
	end
	force_hex = num2hex(single(force));
	force1 = force_hex(7:8);
	force2 = force_hex(5:6);
	force3 = force_hex(3:4);
	force4 = force_hex(1:2);
else
	error(strcat('ERROR: Variable-Type is not correct.',...
		' Error-Code #32001'))
	ErrorCode = 1;
end

if ErrorCode == 0
	obj.ID = '32';							%ID set Force
	obj.Payload = ['04'; '00'];		%Payload length Force
	obj.Command = [force1;...
		force2;...
		force3;...
		force4];								%Force in Float Little Endian
	
	DataEncode(obj);
	DataSend(obj);
end
end
