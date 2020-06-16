%Set Device Tag function

%   Copyright 2019 Fachhochschule Dortmund LIT


function set_device_tag(obj, tag)
if ~ischar(tag)
	warning('Tag should be Character value!')
	return
end

if size(double(tag),2) > 64
	warning('To Many Characters!')
	return
end

Nums = double(tag) >= 48 & double(tag) <= 57;
HighL = double(tag) >= 65 & double(tag) <= 90;
LowL = double(tag) >= 97 & double(tag) <= 122;

if not(sum([sum(Nums) sum(HighL) sum(LowL)]) == size(double(tag),2))
	warning('Tag should have just 0-9, a-z, or A-Z.')
	return
end

DataLength = size(double(tag),2);

%Calculate the Data Length in Hex
hex_length = dec2hex(DataLength,4);

Byte_1 = hex_length(1,3:4);
Byte_2 = hex_length(1,1:2);

ErrorCode = 0;

if ErrorCode == 0
	obj.ID = '51';                              %ID set device tag
	obj.Payload = [Byte_1; Byte_2];                 %Payload length temp_state
	obj.Command = dec2hex(double(tag));                           %No Command
	
	DataEncode(obj);
	DataSend(obj);

end
end
