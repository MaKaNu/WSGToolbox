%stop Function

%   Copyright 2019 Fachhochschule Dortmund LIT


function stop(Obj)

    %Flags Input check
    ErrorCode = 0;

    if ErrorCode == 0
            Obj.ID = '22';                              %ID Graps
            Obj.Payload = ['00'; '00'];                 %Payload length grasp
            Obj.Command = [];                           %No Command

            DataEncode(Obj);
            DataSend(Obj);
            command_complete(Obj);
    end
end
