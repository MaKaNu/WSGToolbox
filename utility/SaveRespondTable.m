function SaveRespondTable()
	Types = {'cell','cell','int8','cell','cell','cell'};
	Names = {'Type','TypeLength','Num_CMD','Symbol','Name','Unit'};
	RespondTable = CreateRespondTable(Types,Names);
	RespondTable = FillRespondTable(RespondTable);
	cd ..
	save('data\respond.mat','RespondTable')
end
	
	