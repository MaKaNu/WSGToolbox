%Decode SSTATE
function decode_SSTATE(Obj)

    try
        idx = find(fliplr(Obj.status.SSTATE))-1;
    
        state_msg = cell(length(idx),1);
        for i = 1:length(idx)
            switch idx(i)
                case 0
                    state_msg{i} = 'SF_REFERENCED';
                case 1
                    state_msg{i} = 'SF_MOVING';
                case 2
                    state_msg{i} = 'SF_BLOCKED_MINUS';
                case 3
                    state_msg{i} = 'SF_BLOCKED_PLUS';
                case 4
                    state_msg{i} = 'SF_SOFT_LIMIT_MINUS';
                case 5
                    state_msg{i} = 'SF_SOFT_LIMIT_PLUS';
                case 6
                    state_msg{i} = 'SF_AXIS_STOPPED';
                case 7
                    state_msg{i} = 'SF_TARGET_POS_REACHED';
                case 8
                    state_msg{i} = 'SF_OVERRIDE_MODE';
                case 9
                    state_msg{i} = 'SF_FORCECNTL_MODE';
                case num2cell(10:11)
                    state_msg{i} = 'RESERVED';
                case 12
                    state_msg{i} = 'SF_FAST_STOP';
                case 13
                    state_msg{i} = 'SF_TEMP_WARNING';
                case 14
                    state_msg{i} = 'SF_TEMP_FAULT';
                case 15
                    state_msg{i} = 'SF_POWER_FAULT';
                case 16
                    state_msg{i} = 'SF_CURR_FAULT';
                case 17
                    state_msg{i} = 'SF_FINGER_FAULT';
                case 18
                    state_msg{i} = 'SF_CMD_FAILURE';
                case 19
                    state_msg{i} = 'SF_SCRIPT_RUNNING';
                case 20
                    state_msg{i} = 'SF_SCRIPT_FAILURE';
                case num2cell(21:31)
                    state_msg{i} = 'RESERVED';
                otherwise
                    error('OUT OF RANGE. SHOULD NOT BE OVER 31. LOT OF WORK IS APPROACHING TO MAINTAINER!')
            end
        end
        disp(state_msg)
        disp('For further information search in WSG_Commandreference --> APENDIX B')
    catch
        error('No SSTATE available. Please request SSTATE with sys_state method')
    end
end