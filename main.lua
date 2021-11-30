-- run using "E:\Program Files\LOVE\love.exe" "$(CURRENT_DIRECTORY)"
-- laptop: run using "C:\Program Files\LOVE\love.exe" "$(CURRENT_DIRECTORY)"

require "loadHandling"
require "saveHandling"
require "addRemove"
require "init"
require "keyhandling"
require "drawGraph"
require "drawGUI"

function checkRollover(num,maxNum)
	if num >= maxNum then
		return 0
	elseif num < 0 then
		return maxNum-1
	else
		return num
	end
end

function love.mousepressed(x, y, button)
	if button == 1 then
		local menuOriginY = 50+12*numStops[currentTimeTable]
		local menuOriginYMinor = 50+12*numStops[currentTimeTable]
		if timeTableData[0][currentTimeTable*masterFileLength+6] == 1 then
			menuOriginY = 50+12*(numStops[currentTimeTable]*2-1)
		end
		textToPrint = menuOriginY
		-- Selecting data to edit
		if x >= 99 and x <= 178 then
			if y >= menuOriginY+25 and y <= menuOriginY+36 then
				editData = {0, currentTimeTable*masterFileLength+3}
			elseif y >= menuOriginY+37 and y <= menuOriginY+48 then
				editData = {0, currentTimeTable*masterFileLength+4}
			elseif y >= menuOriginY+49 and y <= menuOriginY+60 then
				editData = {0, currentTimeTable*masterFileLength+5}
			end
		end
		if y >= 51 and y <= menuOriginYMinor and x >= 14 and x <= 165 then
			editData = {currentTimeTable,timeTableFileLength+math.floor((x-14)/38)+timeTableFileLength*math.floor((y-52)/12)}
		elseif y >= 51 and y <= menuOriginYMinor and x >= 0 and x <= 13 then
			editData = {currentTimeTable,timeTableFileLength+timeTableFileLength*math.floor((y-52)/12)}
		end
		if y >= menuOriginYMinor and y <= menuOriginY and x >= 90 and x <= 165 then
			editData = {currentTimeTable,timeTableFileLength+math.floor((x-14)/38)+timeTableFileLength*(numStops[currentTimeTable]-math.floor((y-menuOriginYMinor-1)/12)-2)+2}
		end
		if y >= 23 and y <= 39 and x <= 151 then
			editData = {0, currentTimeTable*masterFileLength+1}
		end
		-- Change Time Axis
		if x >= 308 and x <= 321 then
			if y >= windowHeight-14 then
				timeLimits[2] = timeLimits[2] - 1
				timeLimits[2] = checkRollover(timeLimits[2],24)--timeLimits[2]+is24Plus(timeLimits[2])
			elseif y >= windowHeight-28 then
				timeLimits[1] = timeLimits[1] - 1
				timeLimits[1] = checkRollover(timeLimits[1],24)
			end
		elseif x >= 322 and x <= 335 then
			if y >= windowHeight-14 then
				timeLimits[2] = timeLimits[2] + 1
				timeLimits[2] = checkRollover(timeLimits[2],24)
			elseif y >= windowHeight-28 then
				timeLimits[1] = timeLimits[1] + 1
				timeLimits[1] = checkRollover(timeLimits[1],24)
			end
		end
		-- Change Timetable Colour
		if y >= menuOriginY+61 and y <= menuOriginY+73 then
			if x >= 154 and x <= 165 then
				timeTableData[0][currentTimeTable*masterFileLength+2] = timeTableData[0][currentTimeTable*masterFileLength+2] - 1
				timeTableData[0][currentTimeTable*masterFileLength+2] = tonumber(checkRollover(timeTableData[0][currentTimeTable*masterFileLength+2]-1,16)+1)
			elseif x >= 166 and x <= 178 then
				timeTableData[0][currentTimeTable*masterFileLength+2] = timeTableData[0][currentTimeTable*masterFileLength+2] + 1
				timeTableData[0][currentTimeTable*masterFileLength+2] = tonumber(checkRollover(timeTableData[0][currentTimeTable*masterFileLength+2]-1,16)+1)
			end
		end
		-- Change Timetable
		if y >= 23 and y <= 39 then
			if x >= 150 and x <= 163 then
				currentTimeTable = currentTimeTable - 1
				currentTimeTable = isLineOOB(currentTimeTable)
			elseif x >= 164 and x <= 178 then
				currentTimeTable = currentTimeTable + 1			
				currentTimeTable = isLineOOB(currentTimeTable)
			end
		end
		-- Save/load
		if y <= 22 and x >= 89 and x <= 178 then
			reloadData()
		elseif y <= 22 and x <= 88 then
			saveToFile()
		end
		-- Add/Remove
		if x <= 178 then
			if y >= menuOriginY+1 and y <= menuOriginY+12 then
				addStation()
			elseif y >= menuOriginY+13 and y <= menuOriginY+24 then
				removeStation()
			end
		end
		if y >= menuOriginY+85 and y <= menuOriginY+96 and x <= 178 then
			addTimeTable()
		end
		if y >= menuOriginY+97 and y <= menuOriginY+108 and x <= 178 then
			removeTimeTable()
		end
		--Turnaround toggle
		if x <= 178 then
			if y >= menuOriginY+73 and y <= menuOriginY+84 then
				timeTableData[0][currentTimeTable*masterFileLength+6] = timeTableData[0][currentTimeTable*masterFileLength+6]*-1
			end
		end
		-- Open save folder
		if y >= menuOriginY+109 and y <= menuOriginY+121 and x <= 178 then
			love.system.openURL("file://"..love.filesystem.getSaveDirectory().."/ttdata/")
		end
	end
end


function love.update(dt)
	specialButtonHeld = love.keyboard.isDown( 'lctrl' ) or love.keyboard.isDown( 'lshift' ) or love.keyboard.isDown( 'lalt' ) or love.keyboard.isDown( 'rctrl' ) or love.keyboard.isDown( 'rshift' ) or love.keyboard.isDown( 'ralt' )
	if editData[1] ~= 0 then
		editData[1] = currentTimeTable
	elseif math.floor(editData[2]/timeTableFileLength) ~= currentTimeTable then
		editData[2] = editData[2]%timeTableFileLength + currentTimeTable*timeTableFileLength
	end
	backspaceHandler()
	--textToPrint = love.filesystem.read( 'ttdata/ttmf.dat' )--( 'ttdata/'.. timeTableData[0][6] ..'.dat' )
end


function love.draw()
	drawGraph()
	drawLeftMenu()
	drawBottomMenu(178,28)
	
	textToPrint = editData[1]..','..editData[2]..','..timeTableData[editData[1]][editData[2]]..','..editData[2]%timeTableFileLength
	love.graphics.print(textToPrint.."_", 20, 345+28)
	
end
