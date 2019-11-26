%reset Softlimits Function

%   Copyright 2019 Fachhochschule Dortmund LIT


function reset_softlimits(Obj)

    %TYPE CHECK
    ErrorCode = 0;

    
    if ErrorCode == 0
        Obj.ID = '36';                              %ID reset Softlimits
        Obj.Payload = ['00'; '00'];                 %Payload length
        Obj.Command = [];                           %no Payload

        DataEncode(Obj);
        DataSend(Obj);
        command_complete(Obj);
        Obj.status.LIMITS = false;
    end
end
            
