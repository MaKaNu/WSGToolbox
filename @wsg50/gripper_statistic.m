function gripper_statistic(Obj,reset)

    %TYPE CHECK
    ErrorCode = 0;
    
    %create vars for Decode_payload function 
    Type = {'INTEGER','INTEGER','INTEGER'};
    TypeLength = {4,2,2};
    Num_CMD = size(Type,2);
    symbol = {'TOTAL','NO_PART','LOST_PART'};
    
    if ErrorCode == 0
        Obj.ID = '42';                              %ID systemstate
        Obj.Payload = ['01'; '00'];                 %Payload length systemstate
        
        if reset
            Obj.Command = '01';              
        else
            Obj.Command = '00';  
        end
        
        DataEncode(Obj);
        DataSend(Obj);
        command_complete(Obj);
        decode_payload(Obj,Type,TypeLength,Num_CMD,symbol);
        if Obj.verbose
            disp(strcat('GRASP COMMANDS SENDED: ', num2str(Obj.status.TOTAL)))
            disp(strcat('NO PART FOUND: ', num2str(Obj.status.NO_PART)))
            disp(strcat('LOST PART: ', num2str(Obj.status.LOST_PART)))
        end
    end
end