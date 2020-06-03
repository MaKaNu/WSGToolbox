classdef wsg50_mini2 < handle
	
	properties
		IP
		PORT
		TCPIP
	end
	
	%PUBLIC METHODS
	methods
		
		%CONSTRUCTOR
		function obj = wsg50_mini2()
			fprintf('################# I am created #################\n')
			
			%Set Standards
			obj.IP = 'localhost';
			obj.PORT = 1000;
		
			obj.conf_conn();
			
			%Setting up Callbackfunction
			obj.TCPIP.BytesAvailableFcnMode = 'byte';
			obj.TCPIP.BytesAvailableFcnCount = 1;
			obj.TCPIP.BytesAvailableFcn = {@obj.TCP_Callback, obj};
			
		end
			
	end
	
	%PRIVATE METHODS
	methods (Access = private)
		
		%DESTRUCTER
		function delete(obj)
			fprintf('################# Hey I am called! #################\n')
			instrreset
		end
		
		%Create TCPIP object
		function conf_conn(obj)
			obj.TCPIP = tcpip(obj.IP,obj.PORT);
			obj.TCPIP.OutputBufferSize = 3000;
			obj.TCPIP.InputBufferSize = 3000;
			obj.TCPIP.ByteOrder = 'littleEndian';
			obj.TCPIP.Timeout = 1;
			
		end
	end
		
		%STATIC METHODS
	methods (Static)
		%TCP Callback
		%This function will be called if one Byte is available at the TCPIP
		%buffer.
		function TCP_Callback(tcpsocket,event,obj)
			fprintf('Loading 1 Byte Data From Buffer.\n')
		end
	end
end

