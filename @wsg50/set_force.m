%Set Force Function
function set_force(Obj,force)

    %TYPE CHECK
    ErrorCode = 0;

    if (isa(force,'double') || isa(force,'single'))
        if not(force<=80.0 && force >= 5.0)
            if (force > 80 && Obj.status.OVERDRIVE)
                warning('Overdrive-Mode is active max force 120 N.')
            else
                warning('Force set to min 5 N or max 80 N.');
            end
        end
        force_hex = num2hex(single(force));
        force1 = force_hex(7:8); force2 = force_hex(5:6); force3 = force_hex(3:4); force4 = force_hex(1:2);
    else
            error(strcat('ERROR: Variable-Type is not correct.',...
                 ' Error-Code #32001'))
            ErrorCode = 1;
    end
    
    if ErrorCode == 0
        Obj.ID = '32';                                      %ID set Force
        Obj.Payload = ['04'; '00'];                         %Payload length Force
        Obj.Command = [force1; force2; force3; force4];     %Force in Float Little Endian

        DataEncode(Obj);
        DataSend(Obj);
        command_complete(Obj);
    end
end