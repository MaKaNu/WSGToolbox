%ack Function

%   Copyright 2019 Fachhochschule Dortmund LIT

function ack(obj)

    %Initial Error Check
    ErrorCode = 0;
	 if isfield(obj.msg_table.msg_tbl, 'ID_24')
		 if ~(obj.msg_table.msg_tbl.ID_24.STATUS == 0)
			obj.decode_status('24')
			ErrorCode = 1;
		 end
	 end

    if ErrorCode == 0
            obj.ID = '24';                              %ID Graps
            obj.Payload = ['03'; '00'];                 %Payload length grasp
            obj.Command = ['61'; '63'; '6B'];           %No Command

            DataEncode(obj);
            DataSend(obj);
    end
end
