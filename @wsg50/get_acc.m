%Get Acceleration Function
function get_acc(Obj)

    %TYPE CHECK
    ErrorCode = 0;

    %create vars for Decode_payload function 
    Type = {'FLOAT'};
    TypeLength = {8};
    Num_CMD = size(Type,2);
    symbol = {'ACC'};
    
    if ErrorCode == 0
        Obj.ID = '31';                              %ID Acc
        Obj.Payload = ['00'; '00'];                 %Payload length Acc
        Obj.Command = [];                           %no Payload

        DataEncode(Obj);
        fopen(Obj.TCPIP);
        DataSend(Obj);
        command_complete(Obj);
        decode_payload(Obj,Type,TypeLength,Num_CMD,symbol);
        if Obj.verbose
            disp(strcat('Acceleration:', num2str(Obj.status.ACC),' mm/s^2'))
        end
        Disconnect(Obj);
    end
end
            