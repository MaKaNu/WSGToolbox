%overdrive Function

%   Copyright 2019 Fachhochschule Dortmund LIT


function overdrive(Obj,bool)

    %TYPE CHECK
    ErrorCode = 0;

    switch bool
        case 1
            flag_vec = [0 0 0 0 0 0 0 1];
            warning('Use overdrivemode carefully. Could cause destruction.')
            Obj.status.OVERDRIVE = true;
        case 0
            flag_vec = [0 0 0 0 0 0 0 0];
            Obj.status.OVERDRIVE = false;
        otherwise            
            error(strcat('ERROR: Variable-Type is not correct.',...
                 ' Error-Code #37001'))
            ErrorCode = 1;
    end
    
    if ErrorCode == 0
        Obj.ID = '37';                                      %ID set Force
        Obj.Payload = ['01'; '00'];                         %Payload length Force
        Obj.Command = binaryVectorToHex(flag_vec);          %Force in Float Little Endian

        DataEncode(Obj);
        DataSend(Obj);
        command_complete(Obj);
    end
end
