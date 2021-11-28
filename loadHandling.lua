--Initialise masterFile
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
	masterFile = {''} --LuA dOeSnT rEqUiRe InItIaLiSaTiOn. Fuck you, it does. Or at least here
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
	numTimeTables = (tableX + 1)/6 -1
	currentTimeTable = isLineOOB(currentTimeTable)
end

function loadTimeTable(i)
	local ttFileRaw, ttFileSize = love.filesystem.read( 'ttdata/'.. masterFile[i*6] ..'.dat' )
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
	numStops[i] = (tableX + 1)/4 -1
	
	stationLimits = {1,numStops[currentTimeTable]}
end

function reloadData()
	createMasterFile()
	for i=1, numTimeTables do
		loadTimeTable(i)
	end
end