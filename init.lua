--Initialise masterFile
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

function love.load()
	-- initialise game
	love.window.setMode(720,480, {resizable=true, minwidth=558, minheight=300}) --GBA*3 screensize by default
	love.window.setTitle( "ScheduledDispatchScheduler" ) --set name
	--Set font
	font = love.graphics.newImageFont("font.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:;<=>?_!\"#$%&'()*+,-./")
	love.graphics.setFont(font)
	--Set colours
	lineColour = {}
	lineColour[1] = {55/255,119/255,187/255}
	lineColour[2] = {119/255,163/255,135/255}
	lineColour[3] = {220/255,131/255,143/255}
	lineColour[4] = {252/255,212/255,0}
	lineColour[5] = {252/255,51/255,51/255}
	lineColour[6] = {115/255,171/255,191/255}
	lineColour[7] = {107/255,175/255,63/255}
	lineColour[8] = {127/255,147/255,91/255}
	lineColour[9] = {87/255,167/255,240/255}
	lineColour[10] = {212/255,147/255,111/255}
	lineColour[11] = {131/255,131/255,163/255}
	lineColour[12] = {139/255,103/255,252/255}
	lineColour[13] = {252/255,252/255,99/255}
	lineColour[14] = {183/255,159/255,119/255}
	lineColour[15] = {147/255,147/255,147/255}
	lineColour[15] = {216/255,216/255,216/255}
	
	spriteSaveButton = love.graphics.newImage("saveIcon.png")
	
	textToPrint= "test"
	
	love.graphics.setLineWidth( 1 )
	love.graphics.setLineStyle("rough")
	
	backspaceStillPressed = false
	startTime = love.timer.getTime()
	backspaceStartTime = 0
	
	dir = love.filesystem.getRealDirectory('ttmf.dat')
	maxX = 6
	timeTableData = {}
	numStops = {}
	
	
	createMasterFile()
	for i=1, numTimeTables do
		loadTimeTable(i)
	end
	currentStation = 1
	currentTimeTable=2
	timeLimits = {5,20}
end