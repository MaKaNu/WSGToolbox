%Loop Command
function loop(Obj,testdata)
    ErrorCode = 0;
    DataLength = length(testdata);
    if not(size(testdata,1)==1)
        error(strcat('ERROR: Testdata has tto be 1xN char.',...
                 ' Error-Code #06001'))
        ErrorCode = 1;
    end
    if (ischar(testdata) && mod(DataLength,2)==0 ...
        && ErrorCode == 0 && DataLength<=512)
        DataLength = dec2hex(DataLength/2);
        switch length(DataLength)
            case 1
                Byte_1 = strcat('0',DataLength);
                Byte_2 = '00';
            case 2
                Byte_1 = DataLength;
                Byte_2 = '00';
            case 3
                Byte_1 = DataLength(2:3);
                Byte_2 = strcat('0',DataLength(1));
            case 4
                Byte_1 = DataLength(3:4);
                Byte_2 = DataLength(1:2);
        end
    else
        error(strcat('ERROR: Testdata parameters are not valid.',...
                 ' Error-Code #06002'))
        ErrorCode = 1;
    end

    if ErrorCode == 0
        c = [];

        for i = 1:2:length(testdata)
            c = [c; testdata(1,i:i+1)]; 
        end

        Obj.ID = '06';                          %ID Loop
        Obj.Payload = [Byte_1; Byte_2];         %Payload length
        Obj.Command = c;  

        DataEncode(Obj);
        fopen(Obj.TCPIP);
        DataSend(Obj);
        command_complete(Obj);
        Disconnect(Obj);
        disp(Obj.payload_R)
    end
end