%Get Force Function
function get_softlimits(Obj)

    %TYPE CHECK
    ErrorCode = 0;
    
    %create vars for Decode_payload function 
    Type = {'FLOAT', 'FLOAT'};
    TypeLength = {8,8};
    Num_CMD = size(Type,2);
    symbol = {'LIMIT_PLUS', 'LIMIT_MINUS'};
    if Obj.status.LIMITS==false
        warning('No softlimits set. Command will not be executed.')
        ErrorCode = 1;
    end
    
    if ErrorCode == 0
        Obj.ID = '35';                              %ID get Force
        Obj.Payload = ['00'; '00'];                 %Payload length Acc
        Obj.Command = [];                           %no Payload

        DataEncode(Obj);
        DataSend(Obj);
        command_complete(Obj);
        decode_payload(Obj,Type,TypeLength,Num_CMD,symbol);
        if Obj.verbose
            disp(strcat('LIMIT MINUS:', num2str(Obj.status.LIMIT_MINUS),' mm'))
            disp(strcat('LIMIT PLUS:', num2str(Obj.status.LIMIT_PLUS),' mm'))
        end
    end
end
            