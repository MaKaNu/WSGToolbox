% connect function

%   Copyright 2020 - 2021 Fachhochschule Dortmund LIT
%       $Revision: 1.0.1 $
%       $Author: Matti Kaupenjohann $
%       $Date: 2021/03/22 $

function connect(obj)

    if strcmp(obj.TCPIP.status,'closed')
        fopen(obj.TCPIP);
    else
        warning('Connection is already established!')
    end
end

