%gripperstate function
function gripper_state(Obj,change, automatic,time)

    %TYPE CHECK
    ErrorCode = 0;
    
    %create vars for Decode_payload function 
    Type = {'ENUM'};
    TypeLength = {1};
    Num_CMD = size(Type,2);
    symbol = {'GSTATE'};
    
    if isnumeric(time) && (9999 >= time) && (time >= 10)
            switch length(num2str(time))
                case 2
                    tmp = num2str(time);
                    time_ = [tmp; '00'];
                case 3
                    tmp = num2str(time);
                    time_ = [tmp(2:3); strcat('0', tmp(1))];
                case 4
                    tmp = num2str(time);
                    time_ = [tmp(3:4); tmp(1:2)];
                otherwise
                    error('This is strange!');
                    ErrorCode = 1;
                    
            end
    else
        error('time interval has to be between 10 and 9999!')  
        ErrorCode = 1;
    end

    
    
    
    if ErrorCode == 0
        Obj.ID = '41';                              %ID systemstate
        Obj.Payload = ['03'; '00'];                 %Payload length systemstate
        
        if automatic && change
            Obj.Command = ['03';time_];              
        elseif change
            Obj.Command = ['02';time_];             % This Option is irrelvant
            warning('Just Because something is possible, doesnt mean it is usefull!')
        elseif automatic
            Obj.Command = ['01';time_];  
        else
            Obj.Command = ['00';time_];  
        end
        
        DataEncode(Obj);
        DataSend(Obj);
        command_complete(Obj);
        decode_payload(Obj,Type,TypeLength,Num_CMD,symbol);
        if Obj.verbose
            disp(strcat('GRIPPER STATUS: ', num2str(Obj.status.GSTATE)))
            switch Obj.status.GSTATE
                case 0
                    disp('IDLE')
                case 1
                    disp('GRASPING')
                case 2
                    disp('NO PART FOUND')
                case 3
                    disp('PART LOST')
                case 4
                    disp('HOLDING')
                case 5
                    disp('RELEASING')
                case 6
                    disp('POSITIONING')
                case 7
                    disp('ERROR')
                otherwise
                    disp('RESERVED')
            end
        end
    end
end