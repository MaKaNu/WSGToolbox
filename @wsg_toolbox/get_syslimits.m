% get syslimits Function

%   Copyright 2020 - 2021 Fachhochschule Dortmund LIT
%       $Revision: 1.0.1 $
%       $Author: Matti Kaupenjohann $
%       $Date: 2021/03/22 $

function get_syslimits(obj)

ErrorCode = 0;

if ErrorCode == 0
    obj.ID = '53';              %ID system infos
    obj.Payload = ['00'; '00']; %Payload length grasp
    obj.Command = [];           %No Command
    
    DataEncode(obj);
    DataSend(obj);
end
end
