%fast_stop Function
function fast_stop(Obj)

    %Flags Input check
    ErrorCode = 0;

    if ErrorCode == 0
            Obj.ID = '23';                              %ID Graps
            Obj.Payload = ['00'; '00'];                 %Payload length grasp
            Obj.Command = [];                           %No Command

            DataEncode(Obj);
            fopen(Obj.TCPIP);
            DataSend(Obj);
            command_complete(Obj);
            Disconnect(Obj);
    end
end