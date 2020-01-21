function RespondTable = FillRespondTable(RespondTable)
			%Fill Respond of Command ID 06h
			RespondTable{'ID_06','Type'}{:} = {
				'INTEGER'};
			RespondTable{'ID_06','TypeLength'}{:} = {5}; %NEED TO BE FIXED
			NUM_CMD = size(RespondTable{'ID_06','Type'}{:},2);
			RespondTable{'ID_06','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_06','Symbol'}{:} = {
				'LOOPDATA'};
			RespondTable{'ID_06','Name'}{:} = {
				'Your Entry: '};
			RespondTable{'ID_06','Unit'}{:} = {''};
			
			%Fill Respond of Command ID 31h
			RespondTable{'ID_31','Type'}{:} = {
				'FLOAT'};
			RespondTable{'ID_31','TypeLength'}{:} = {4}; 
			NUM_CMD = size(RespondTable{'ID_31','Type'}{:},2);
			RespondTable{'ID_31','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_31','Symbol'}{:} = {
				'ACC'};
			RespondTable{'ID_31','Name'}{:} = {
				'Acceleration: '};
			RespondTable{'ID_31','Unit'}{:} = {' mm/s^2'};
			
			%Fill Respond of Command ID 33h
			RespondTable{'ID_33','Type'}{:} = {
				'FLOAT'};
			RespondTable{'ID_33','TypeLength'}{:} = {4}; 
			NUM_CMD = size(RespondTable{'ID_33','Type'}{:},2);
			RespondTable{'ID_33','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_33','Symbol'}{:} = {
				'FORCE'};
			RespondTable{'ID_33','Name'}{:} = {'Force: '};
			RespondTable{'ID_33','Unit'}{:} = {' N'};
			
			%Fill Respond of Command ID 35h
			RespondTable{'ID_35','Type'}{:} = {
				'FLOAT', 'FLOAT'};
			RespondTable{'ID_35','TypeLength'}{:} = {4, 4}; 
			NUM_CMD = size(RespondTable{'ID_35','Type'}{:},2);
			RespondTable{'ID_35','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_35','Symbol'}{:} = {
				'LIMIT_MINUS','LIMIT_PLUS'};
			RespondTable{'ID_35','Name'}{:} = {
				'Inner Limit: ', 'Outer Limit: '};
			RespondTable{'ID_35','Unit'}{:} = {' mm', ' mm'};
			
			%Fill Respond of Command ID 40h
			RespondTable{'ID_40','Type'}{:} = {
				'BITVEC'};
			RespondTable{'ID_40','TypeLength'}{:} = {4}; 
			NUM_CMD = size(RespondTable{'ID_40','Type'}{:},2);
			RespondTable{'ID_40','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_40','Symbol'}{:} = {
				'SSTATE'};
			RespondTable{'ID_40','Name'}{:} = {
				'System status: '};
			RespondTable{'ID_40','Unit'}{:} = {''};
			
			%Fill Respond of Command ID 41h
			RespondTable{'ID_41','Type'}{:} = {
				'ENUM'};
			RespondTable{'ID_41','TypeLength'}{:} = {1}; 
			NUM_CMD = size(RespondTable{'ID_41','Type'}{:},2);
			RespondTable{'ID_41','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_41','Symbol'}{:} = {
				'GSTATE'};
			RespondTable{'ID_41','Name'}{:} = {
				'Gripper status: '};
			RespondTable{'ID_41','Unit'}{:} = {''};
		
			%Fill Respond of Command ID 42h
			RespondTable{'ID_42','Type'}{:} = {
				'INTEGER', 'INTEGER', 'INTEGER'};
			RespondTable{'ID_42','TypeLength'}{:} = {4, 2, 2}; 
			NUM_CMD = size(RespondTable{'ID_42','Type'}{:},2);
			RespondTable{'ID_42','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_42','Symbol'}{:} = {
				'TOTAL', 'NO_PART', 'LOST_PART'};
			RespondTable{'ID_42','Name'}{:} = {
				'Number grasps: ','Number no part Found: ',...
				'Number lost parts: '};
			RespondTable{'ID_42','Unit'}{:} = {'', '', ''};

			%Fill Respond of Command ID 43h
			RespondTable{'ID_43','Type'}{:} = {
				'FLOAT'};
			RespondTable{'ID_43','TypeLength'}{:} = {4}; 
			NUM_CMD = size(RespondTable{'ID_41','Type'}{:},2);
			RespondTable{'ID_43','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_43','Symbol'}{:} = {
				'WIDTH'};
			RespondTable{'ID_43','Name'}{:} = {
				'Opening width: '};
			RespondTable{'ID_43','Unit'}{:} = {' mm'};
			
			%Fill Respond of Command ID 44h
			RespondTable{'ID_44','Type'}{:} = {
				'FLOAT'};
			RespondTable{'ID_44','TypeLength'}{:} = {4}; 
			NUM_CMD = size(RespondTable{'ID_44','Type'}{:},2);
			RespondTable{'ID_44','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_44','Symbol'}{:} = {
				'SPEED'};
			RespondTable{'ID_44','Name'}{:} = {
				'Finger velocity: '};
			RespondTable{'ID_44','Unit'}{:} = {' mm/s'};

			%Fill Respond of Command ID 45h
			RespondTable{'ID_45','Type'}{:} = {
				'FLOAT'};
			RespondTable{'ID_45','TypeLength'}{:} = {4}; 
			NUM_CMD = size(RespondTable{'ID_45','Type'}{:},2);
			RespondTable{'ID_45','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_45','Symbol'}{:} = {
				'FINGERFORCE'};
			RespondTable{'ID_45','Name'}{:} = {
				'Finger force: '};
			RespondTable{'ID_45','Unit'}{:} = {' N'};
			
			%Fill Respond of Command ID 46h
			RespondTable{'ID_46','Type'}{:} = {
				'INTEGER'};
			RespondTable{'ID_46','TypeLength'}{:} = {2}; 
			NUM_CMD = size(RespondTable{'ID_46','Type'}{:},2);
			RespondTable{'ID_46','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_46','Symbol'}{:} = {
				'TEMP'};
			RespondTable{'ID_46','Name'}{:} = {
				'Temperature: '};
			RespondTable{'ID_46','Unit'}{:} = {' °C'};
			
			%Fill Respond of Command ID 50h
			RespondTable{'ID_50','Type'}{:} = {
				'ENUM', 'INTEGER','INTEGER', 'INTEGER'};
			RespondTable{'ID_50','TypeLength'}{:} = {1, 1, 2, 4}; 
			NUM_CMD = size(RespondTable{'ID_46','Type'}{:},2);
			RespondTable{'ID_50','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_50','Symbol'}{:} = {
				'TYPE', 'HWREV','FW_VERSION', 'SN'};
			RespondTable{'ID_50','Name'}{:} = {
				'Device type: ','Hardware revision: ',...
				'Firmware version: ', 'Serialnumber: '};
			RespondTable{'ID_50','Unit'}{:} = {'','','',''};
			
			%Fill Respond of Command ID 52h
			RespondTable{'ID_52','Type'}{:} = {
				'STRING'};
			RespondTable{'ID_52','TypeLength'}{:} = {4}; %NEED TO BE FIXED
			NUM_CMD = size(RespondTable{'ID_52','Type'}{:},2);
			RespondTable{'ID_52','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_52','Symbol'}{:} = {
				'TAG'};
			RespondTable{'ID_52','Name'}{:} = {
				'Device tag: '};
			RespondTable{'ID_52','Unit'}{:} = {''};
			
			%Fill Respond of Command ID 53h
			RespondTable{'ID_53','Type'}{:} = {
				'FLOAT','FLOAT','FLOAT','FLOAT',...
				'FLOAT','FLOAT','FLOAT','FLOAT'};
			RespondTable{'ID_53','TypeLength'}{:} = {
				4,4,4,4,4,4,4,4};
			NUM_CMD = size(RespondTable{'ID_53','Type'}{:},2);
			RespondTable{'ID_53','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_53','Symbol'}{:} = {
				'TOTALSTROKE', 'MIN_SPEED', 'MAX_SPEED','MIN_ACC',...
				'MAX_ACC', 'MIN_FORCE','NOM_FORCE', 'OVR_FORCE' };
			RespondTable{'ID_53','Name'}{:} = {
				'Total width: ', 'Minimum velocity: ', 'Maximum velocity: ',...
				'Minimum acceleration: ','Maximum acceleration: ',...
				'Minimum force: ', 'Nominal force: ', 'Overdrive Force: '};
			RespondTable{'ID_53','Unit'}{:} = {
				' mm', ' mm/s', ' mm/s', ' mm/sÂ²',....
				' mm/s^2', ' N', ' N', ' N'};
		
			%Fill Respond of Command ID 60h
			RespondTable{'ID_60','Type'}{:} = {
				'ENUM', 'INTEGER'};
			RespondTable{'ID_60','TypeLength'}{:} = {1,2};
			NUM_CMD = size(RespondTable{'ID_60','Type'}{:},2);
			RespondTable{'ID_60','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_60','Symbol'}{:} = {
				'FINGERTYPE1', 'SIZE1'};
			RespondTable{'ID_60','Name'}{:} = {
				'Finger 1 type: ', 'Data Size: '};
			RespondTable{'ID_60','Unit'}{:} = {'', ''};
			
			%Fill Respond of Command ID 61h
			RespondTable{'ID_61','Type'}{:} = {
				'BITVEKTOR'};
			RespondTable{'ID_61','TypeLength'}{:} = {2};
			NUM_CMD = size(RespondTable{'ID_61','Type'}{:},2);
			RespondTable{'ID_61','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_61','Symbol'}{:} = {
				'FLAGS1'};
			RespondTable{'ID_61','Name'}{:} = {
				'Finger 1 Flags: '};
			RespondTable{'ID_61','Unit'}{:} = {''};
			
			%Fill Respond of Command ID 63h
			RespondTable{'ID_63','Type'}{:} = {
				'STRING'};
			RespondTable{'ID_63','TypeLength'}{:} = {4}; %NEED TO BE FIXED
			NUM_CMD = size(RespondTable{'ID_63','Type'}{:},2);
			RespondTable{'ID_63','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_63','Symbol'}{:} = {
				'FINGER1'};
			RespondTable{'ID_63','Name'}{:} = {
				'specific '};
			RespondTable{'ID_63','Unit'}{:} = {''};
		
			%Fill Respond of Command ID 70h
			RespondTable{'ID_70','Type'}{:} = {
				'ENUM', 'INTEGER'};
			RespondTable{'ID_70','TypeLength'}{:} = {1,2};
			NUM_CMD = size(RespondTable{'ID_70','Type'}{:},2);
			RespondTable{'ID_70','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_70','Symbol'}{:} = {
				'FINGERTYPE2', 'SIZE2'};
			RespondTable{'ID_70','Name'}{:} = {
				'Finger 2 type: ', 'Data Size: '};
			RespondTable{'ID_70','Unit'}{:} = {'', ''};
			
			%Fill Respond of Command ID 71h
			RespondTable{'ID_71','Type'}{:} = {
				'BITVEKTOR'};
			RespondTable{'ID_71','TypeLength'}{:} = {2};
			NUM_CMD = size(RespondTable{'ID_71','Type'}{:},2);
			RespondTable{'ID_71','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_71','Symbol'}{:} = {
				'FLAGS2'};
			RespondTable{'ID_71','Name'}{:} = {
				'Finger 2 Flags: '};
			RespondTable{'ID_71','Unit'}{:} = {''};
			
			%Fill Respond of Command ID 73h
			RespondTable{'ID_73','Type'}{:} = {
				'STRING'};
			RespondTable{'ID_73','TypeLength'}{:} = {4}; %NEED TO BE FIXED
			NUM_CMD = size(RespondTable{'ID_73','Type'}{:},2);
			RespondTable{'ID_73','Num_CMD'} = NUM_CMD;
			RespondTable{'ID_73','Symbol'}{:} = {
				'FINGER2'};
			RespondTable{'ID_73','Name'}{:} = {
				'specific '};
			RespondTable{'ID_73','Unit'}{:} = {''};

		end