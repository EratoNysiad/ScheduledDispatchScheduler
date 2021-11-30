--Initialise timeTableData[0]
function isLineOOB(num)
	if num == 0 then
		return numTimeTables
	elseif num > numTimeTables then
		return 1
	else
		return num
	end
end

function createMasterFile()
	local masterFileRaw, masterFileSize = love.filesystem.read( 'ttdata/ttmf.dat' )
	local masterFile = {''} --LuA dOeSnT rEqUiRe InItIaLiSaTiOn. Fuck you, it does. Or at least here
	local tableX = 0
	if masterFileRaw == nil then
		love.filesystem.write( 'ttdata/ttmf.dat', "File,Name,Colour,Start,Repeat,End\nTT1,First line,1,515,30,2300\nTT2,Name of line 2,4,1308,60,1000\nTT3,King line the 3rd,5,500,30,2300" )
		masterFileRaw, masterFileSize = love.filesystem.read( 'ttdata/ttmf.dat' )
	end
	
	for i=1, masterFileSize do
		local currentCharacter = masterFileRaw:sub(i,i)
		if currentCharacter ~= nil then
			if currentCharacter == ',' or currentCharacter == '\n' then
				tableX = tableX + 1
			elseif masterFile[tableX] == nil then
				masterFile[tableX] = currentCharacter
			else
				masterFile[tableX] = masterFile[tableX] .. currentCharacter
			end
		else
			textToPrint = "oh god oh fuck"
			return
		end
	end
	timeTableData[0] = masterFile
	numTimeTables = (tableX + 1)/masterFileLength -1
	currentTimeTable = isLineOOB(currentTimeTable)
end

function loadTimeTable(i)
	local ttFileRaw, ttFileSize = love.filesystem.read( 'ttdata/'.. timeTableData[0][i*masterFileLength] ..'.dat' )
	local ttFile = {} --LuA dOeSnT rEqUiRe InItIaLiSaTiOn. Fuck you, it does. Or at least here
	local tableX = 0
	if ttFileRaw == nil then
		local printData
		if i == 1 then
			printData = "Code,Dist,Time,Wait,rTime,rWait\nICK,0,0,0,0,0\nTYY,6,6,2,0,0\nAMG,24,24,10,0,0\nJNHM,12,12,0,0,0\nHMJ,3,3,2,0,0"
		elseif i == 3 then
			printData = "Code,Dist,Time,Wait,rTime,rWait\nICK,0,0,0,0,0\nTYY,6,6,2,0,0\nAMG,24,24,10,0,0\nJNHM,12,12,0,0,0\nHMJ,3,3,2,0,0"
		else
			printData = "Code,Dist,Time,Wait,rTime,rWait\nDTYY,0,0,0,0,0\nTYY,-6,6,2,0,0\nAMG,24,24,10,0,0\nJNHM,12,12,0,0,0\nHMJ,3,3,2,0,0"
		end
		love.filesystem.write( 'ttdata/'.. timeTableData[0][i*masterFileLength] ..'.dat', printData )
		ttFileRaw, ttFileSize = love.filesystem.read( 'ttdata/'.. timeTableData[0][i*masterFileLength] ..'.dat' )
	end
	for j=1, ttFileSize do
		local currentCharacter = ttFileRaw:sub(j,j)
		if currentCharacter ~= nil then
			if currentCharacter == ',' or currentCharacter == '\n' then
				tableX = tableX + 1
			elseif ttFile[tableX] == nil then
				ttFile[tableX] = currentCharacter
			else
				ttFile[tableX] = ttFile[tableX] .. currentCharacter
			end
		else
			textToPrint = "oh god oh fuck"
			return
		end
	end
	timeTableData[i] = ttFile
	numStops[i] = (tableX + 1)/timeTableFileLength -1
	
	stationLimits = {1,numStops[currentTimeTable]}
end

function reloadData()
	love.filesystem.createDirectory( 'ttdata/' )
	createMasterFile()
	for i=1, numTimeTables do
		loadTimeTable(i)
	end
	editData = {0,0}
	currentStation=0
end