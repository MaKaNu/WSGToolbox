classdef wsg50_mini < handle

	%PUBLICS
	properties
		IP
		PORT
		TCPIP                   %TCPIP-objekt
	end
	
	%PUBLIC METHODS
	methods
		
		%CONSTRUCTOR
		function obj = wsg50_mini(varargin)
			
			%Set Standards
			obj.IP = 'localhost';
			obj.PORT = 1000;

			defaultHost = 'localhost';
			
			switch nargin
				case 0
					obj.IP = defaultHost;
					warning('Host and Port are not set. The object uses defaultHost and defaultPort.')
				case 1
					obj.IP = varargin{1};
					warning('Port is not set. The object uses defaultPort.')
				case 2
					obj.IP = varargin{1};
					obj.PORT = varargin{2};
				otherwise
					error('Too many input arguments.')
			end
			
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
		function obj = delete(obj)
			instrreset
		end
		
		%Check varargins greater then 2
		function check_vars(obj,classvars)
			n=3;
			while n <= length(classvars)
				if ischar(classvars{n})
					str = classvars{n};
					switch str
						case 'verbose'
							obj.verbose = true;
						case 'debug'
							obj.debug = true;
						case 'autoopen'
							obj.autoopen = true;
					end
				end
				n = n +1;
			end
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

