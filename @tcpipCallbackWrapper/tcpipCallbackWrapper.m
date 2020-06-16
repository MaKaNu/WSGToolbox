classdef tcpipCallbackWrapper < handle
    properties(Access=private)
        tcpip
    end
    events
        BytesAvailableFcn
    end
    methods
        % tcpipCallbackWrapper Constructor
        function obj = tcpipCallbackWrapper(tcpip)
            disp 'CONSTRUCTED tcpipCallbackWrapper'
            % Keep a reference to the tcpip object
            obj.tcpip = tcpip;
            % Adding this listener will result in the destructor not being
            % called automatically anymore; but luckily we have myClass
            % which will explicitly call it for us
				obj.tcpip.BytesAvailableFcnMode = 'byte';
				obj.tcpip.BytesAvailableFcnCount = 1;
            obj.tcpip.BytesAvailableFcn = @obj.bytesAvailableFcn;
        end
        % tcpipCallbackWrapper Destructor
        function delete(obj)
            disp 'DESTRUCTED tcpipCallbackWrapper'
            % Overwrite the callback with a new empty one, removing the
            % reference from the callback to our class instance, allowing
            % the instance to truly be destroyed
            obj.tcpip.BytesAvailableFcn = '';
        end
    end
    methods (Access=private)
        % Callback for BytesAvailableFcn
        function bytesAvailableFcn(obj,~,~)
            % Raise the BytesAvailableFcn event which myClass can listen to
            notify(obj, 'BytesAvailableFcn');
        end
    end
end