function connect(Obj)

    if strcmp(Obj.TCPIP.status,'closed')
        fopen(Obj.TCPIP);
    else
        warning('Connection is already established!')
    end
end

