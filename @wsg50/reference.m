%Reference function

%   Copyright 2019 Fachhochschule Dortmund LIT


function reference(Obj,direction)
    ErrorCode = 0;

    switch direction
        case 'open'
            cmd = '01';
        case 'close'
            cmd = '02';
        otherwise
            cmd = '00';
    end

    if ErrorCode == 0
        Obj.ID = '20';                      %ID Graps
        Obj.Payload = ['01'; '00'];         %Payload length
        Obj.Command = cmd;                  %Speed in Enum Little Endian

        DataEncode(Obj);
        DataSend(Obj);
        command_complete(Obj);
    end

end
