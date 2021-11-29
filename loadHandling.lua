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
	createMasterFile()
	for i=1, numTimeTables do
		loadTimeTable(i)
	end
end