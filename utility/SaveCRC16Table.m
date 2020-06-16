function SaveCRC16Table()
% Creates a CRC16 Lookup Table as Cell and save it as a .mat file inside
% the data folder.

r = 1; %Cell Row
c = 1; %Cell Column

CRC16Table = cell(32,8);

for i = 0:255
	result = bitshift(i,8);
	for j = 0:7
		xor_flag = bitget(result,16);
		
		result = bitshift(result,1);
		
		if xor_flag
			result = bitxor(result,hex2dec('1021'));
		end
	end
	tmp =dec2hex(result,4);
	
	
% 	fprintf(strcat('0x',tmp(end-3:end)));
	
	%pretty formatting
	if mod(i+1,8)
		CRC16Table{r,c} = tmp(end-3:end); 
		c = c + 1;
	else
		CRC16Table{r,c} = tmp(end-3:end); 
		c = 1;
		r = r + 1;
	end
	
end
cd ..
save('data\CRC16Table.mat','CRC16Table')

end

