% connect function

%   Copyright 2020 Fachhochschule Dortmund LIT

function connect(obj)

    if strcmp(obj.TCPIP.status,'closed')
        fopen(obj.TCPIP);
    else
        warning('Connection is already established!')
    end
end
