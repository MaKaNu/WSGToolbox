%Loop function

%   Copyright 2019 Fachhochschule Dortmund LIT


function loop(obj,testdata)
DataLength = length(testdata);

%Initial Error Check
ErrorCode = 0;
if isfield(obj.msg_table.msg_tbl, 'ID_06')
	if ~(obj.msg_table.msg_tbl.ID_06.STATUS == 0)
		obj.decode_status('06')
		ErrorCode = 1;
	end
end

if not(size(testdata,1)==1) || ~ischar(testdata)
	error(strcat('ERROR: Testdata has to be 1xN char.',...
		' Error-Code #06002'))
	ErrorCode = 2;
end
try
	hex2dec(testdata)
catch
	error('testdata should have just 0-9, a-f, or A-F.')
end

if ErrorCode == 0 && DataLength<=512
	%Transform the Data to single Bytes
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
	%Calculate the Data Length in Hex
	DataLength = dec2hex(ceil(DataLength/2));
	switch length(DataLength)
		case 1
			Byte_1 = strcat('0',DataLength);
			Byte_2 = '00';
		case 2
			Byte_1 = DataLength;
			Byte_2 = '00';
		case 3
			Byte_1 = DataLength(2:3);
			Byte_2 = strcat('0',DataLength(1));
		case 4
			Byte_1 = DataLength(3:4);
			Byte_2 = DataLength(1:2);
	end
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
