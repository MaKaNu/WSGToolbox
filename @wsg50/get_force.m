%Get Force Function

%   Copyright 2019 Fachhochschule Dortmund LIT


function get_force(obj)

    %Initial Error Check
    ErrorCode = 0;
	 if isfield(obj.msg_table.msg_tbl, 'ID_33')
		 if ~(obj.msg_table.msg_tbl.ID_33.STATUS == 0)
			obj.decode_status('33')
			ErrorCode = 1;
		 end
	 end
    
    %create vars for Decode_payload function 
    Type = {'FLOAT'};
    TypeLength = {4};
    Num_CMD = size(Type,2);
    symbol = {'FORCE'};
    
    
    if ErrorCode == 0
        obj.ID = '33';                              %ID get Force
        obj.Payload = ['00'; '00'];                 %Payload length Acc
        obj.Command = [];                           %no Payload

        DataEncode(obj);
        DataSend(obj);

		  decode_payload(obj,obj.ID,Type,TypeLength,Num_CMD,symbol);
        if obj.verbose
            disp(strcat('Force:', num2str(obj.status.FORCE),' N'))
        end
    end
end
            
