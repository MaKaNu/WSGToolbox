%reset Softlimits Function
function reset_softlimits(Obj)

    %TYPE CHECK
    ErrorCode = 0;

    
    if ErrorCode == 0
        Obj.ID = '36';                              %ID reset Softlimits
        Obj.Payload = ['00'; '00'];                 %Payload length
        Obj.Command = [];                           %no Payload

        DataEncode(Obj);
        fopen(Obj.TCPIP);
        DataSend(Obj);
        command_complete(Obj);
        Disconnect(Obj);
        Obj.status.LIMITS = false;
    end
end
            