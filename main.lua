-- run using "E:\Program Files\LOVE\love.exe" "$(CURRENT_DIRECTORY)"

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
		textToPrint = menuOriginY
		-- Selecting data to edit
		if y >= menuOriginY+25 and y <= menuOriginY+37 and x >= 99 and x <= 178 then
			editData = {0, currentTimeTable*masterFileLength+3}
		elseif y >= menuOriginY+38 and y <= menuOriginY+49 and x >= 99 and x <= 178 then
			editData = {0, currentTimeTable*masterFileLength+4}
		elseif y >= menuOriginY+50 and y <= menuOriginY+61 and x >= 99 and x <= 178 then
			editData = {0, currentTimeTable*masterFileLength+5}
		end
		if y >= 51 and y <= menuOriginY and x >= 14 and x <= 165 then
			editData = {currentTimeTable,timeTableFileLength+math.floor((x-14)/38)+timeTableFileLength*math.floor((y-51)/12)}
		elseif y >= 51 and y <= menuOriginY and x >= 0 and x <= 13 then
			editData = {currentTimeTable,timeTableFileLength+timeTableFileLength*math.floor((y-51)/12)}
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
		if y >= menuOriginY+61 and y <= 73 then
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
	end
end


function love.update(dt)
	specialButtonHeld = love.keyboard.isDown( 'lctrl' ) or love.keyboard.isDown( 'lshift' ) or love.keyboard.isDown( 'lalt' ) or love.keyboard.isDown( 'rctrl' ) or love.keyboard.isDown( 'rshift' ) or love.keyboard.isDown( 'ralt' )
	if editData[1] ~= 0 then
		editData[1] = currentTimeTable
	end
	backspaceHandler()
	--textToPrint = love.filesystem.read( 'ttdata/ttmf.dat' )--( 'ttdata/'.. timeTableData[0][6] ..'.dat' )
end


function love.draw()
	drawGraph()
	drawLeftMenu()
	drawBottomMenu(178,28)
	
	--textToPrint = editData[1]..','..editData[2]..','..timeTableData[editData[1]][editData[2]]..','..editData[2]%timeTableFileLength
	textToPrint = editData[2]
	love.graphics.print(5+tonumber("-20"), 140, 346)
	love.graphics.print(textToPrint.."_", 12, 245+28)
	
end
