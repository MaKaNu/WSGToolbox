%Set Force Function

%   Copyright 2019 Fachhochschule Dortmund LIT


function set_force(obj,force)


%Initial Error Check
ErrorCode = 0;
if isfield(obj.msg_table.msg_tbl, 'ID_32')
	if ~(obj.msg_table.msg_tbl.ID_32.STATUS == 0)
		obj.decode_status('32')
		ErrorCode = 1;
	end
end

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
