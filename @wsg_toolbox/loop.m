%Loop function
% DESCRIPTION
% This method is used to test the connection with testdata, which will be
% send back to the user. Last 4 bits will be cut if uneven.
%
% PARAMETER:
% testdata

%   Copyright 2020 - 2021 Fachhochschule Dortmund LIT
%       $Revision: 1.0.1 $
%       $Author: Matti Kaupenjohann $
%       $Date: 2021/03/22 $


function loop(obj,testdata)

ErrorCode = 0;
DataLength = size(testdata,2);

if not(size(testdata,1)==1) || ~ischar(testdata)
	error(strcat('ERROR: Testdata has to be 1xN char.',...
		' Error-Code #06002'))
	ErrorCode = 2;
end

if ErrorCode == 0 && DataLength<=512
	%Transform the Data to single Bytes
	try
		switch mod(DataLength,2)
			case 0
				Bytes = regexp(testdata, '\w{1,2}', 'match');
				Bytes = cell2mat(Bytes');
			case 1
				Bytes = regexp(testdata(1:end-1), '\w{1,2}', 'match');
				Bytes = cell2mat(Bytes');
				EndByte = dec2hex(hex2dec(testdata(end)),2);
				Bytes = [Bytes;EndByte];
		end
	catch
		error('testdata should have just 0-9, a-f, or A-F.')
	end
	
	%Calculate the Data Length in Hex
	PayloadLength = dec2hex(size(Bytes,1),4);
	
	Byte_1 = PayloadLength(1,3:4);
	Byte_2 = PayloadLength(1,1:2);

else
	error(strcat('ERROR: Testdata parameters are not valid.',...
		' Error-Code #06003'))
	ErrorCode = 3;
end

if ErrorCode == 0
	
	obj.ID = '06';                         %ID Loop
	obj.Payload = [Byte_1;Byte_2];							%Payload length
	obj.Command = Bytes;
	
	DataEncode(obj);
	DataSend(obj);
end
end
