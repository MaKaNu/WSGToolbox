function SaveRespondTable()
	if verLessThan('matlab', '9.4')
		error(strcat('You are running a Matlab Version less than 2018a. ',...
			'This utility Function is not available below Matlab 2018a'))
	end

	Types = {'cell','cell','int8','cell','cell','cell'};
	Names = {'Type','TypeLength','Num_CMD','Symbol','Name','Unit'};
	RespondTable = CreateRespondTable(Types,Names);
	RespondTable = FillRespondTable(RespondTable);
	cd ..
	save('data\respond.mat','RespondTable')
end
	
	