%Get Force Function
function get_force(Obj)

    %TYPE CHECK
    ErrorCode = 0;
    
    %create vars for Decode_payload function 
    Type = {'FLOAT'};
    TypeLength = {8};
    Num_CMD = size(Type,2);
    symbol = {'FORCE'};
    
    
    if ErrorCode == 0
        Obj.ID = '33';                              %ID get Force
        Obj.Payload = ['00'; '00'];                 %Payload length Acc
        Obj.Command = [];                           %no Payload

        DataEncode(Obj);
        DataSend(Obj);
        command_complete(Obj);
        decode_payload(Obj,Type,TypeLength,Num_CMD,symbol);
        if Obj.verbose
            disp(strcat('Force:', num2str(Obj.status.FORCE),' N'))
        end
    end
end
            