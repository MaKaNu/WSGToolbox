%ack Function
function ack(Obj)

    %Flags Input check
    ErrorCode = 0;

    if ErrorCode == 0
            Obj.ID = '24';                              %ID Graps
            Obj.Payload = ['03'; '00'];                 %Payload length grasp
            Obj.Command = ['61'; '63'; '6B'];           %No Command

            DataEncode(Obj);
            fopen(Obj.TCPIP);
            DataSend(Obj);
            command_complete(Obj);
            Disconnect(Obj);
    end
end