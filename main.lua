-- run using "E:\Program Files\LOVE\love.exe" "$(CURRENT_DIRECTORY)"
-- laptop: run using "C:\Program Files\LOVE\love.exe" "$(CURRENT_DIRECTORY)"

require "loadHandling"
require "saveHandling"
require "addRemove"
require "warningUI"
require "init"
require "keyHandling"
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

function spaceCheck(i)
	if i == 2 then -- change max
		if spaceLimits[2] ~= 0 and spaceLimits[2] == spaceLimits[1] then
			if spaceLimits[2] ~= numStops[currentTimeTable] then --next is not max
				spaceLimits[2] = spaceLimits[2] + 1
			else
				spaceLimits[2] = 0
			end
		end
	else -- change min
		if spaceLimits[1] ~= 0 and spaceLimits[2] == spaceLimits[1] then
			spaceLimits[1] = spaceLimits[1] - 1
		elseif spaceLimits[1] < 0 then
			spaceLimits[1] = 0
		elseif spaceLimits[1] == numStops[currentTimeTable] then
			spaceLimits[1] = 0
		end
	end
end

function love.resize(w, h)
	windowWidth = w
	windowHeight = h
	local maxVal
	if timeTableData[0][currentTimeTable*masterFileLength+6] == 1 then --table is shifted down
		maxVal=windowHeight-120-51-12*(numStops[currentTimeTable]*2-1)
	elseif timeTableData[0][currentTimeTable*masterFileLength+6] ~= 1 then --table is shifted down
		maxVal=windowHeight-120-51-12*(numStops[currentTimeTable])
	end
	if maxVal > 0 then -- no need for scrolling
		tablePos = 0
	else
		tablePos = math.min(tablePos,0)
		tablePos = math.max(tablePos,maxVal)
	end
	textToPrint = maxVal..','..tablePos
end

function love.wheelmoved(x, y)
	local maxVal
	if timeTableData[0][currentTimeTable*masterFileLength+6] == 1 then --table is shifted down
		maxVal=windowHeight-120-51-12*(numStops[currentTimeTable]*2-1)
	elseif timeTableData[0][currentTimeTable*masterFileLength+6] ~= 1 then --table is shifted down
		maxVal=windowHeight-120-51-12*(numStops[currentTimeTable])
	end
	if maxVal > 0 then -- no need for scrolling
		tablePos = 0
	else
		tablePos = math.min(tablePos+y*3,0)
		tablePos = math.max(tablePos,maxVal)
	end
	textToPrint = maxVal..','..tablePos
end

function love.mousepressed(x, y, button)
	if button == 1 then
		if warningID == 0 then
			local menuOriginY = math.min(50+12*numStops[currentTimeTable],windowHeight-120)
			local menuOriginYMinor = menuOriginY
			if timeTableData[0][currentTimeTable*masterFileLength+6] == 1 then
				menuOriginY = math.min(50+12*(numStops[currentTimeTable]*2-1),windowHeight-120)
			end
			if x >= 99 and x <= 178 then
				if y >= menuOriginY+25 and y <= menuOriginY+36 then
					editData = {0, currentTimeTable*masterFileLength+3}
				elseif y >= menuOriginY+37 and y <= menuOriginY+48 then
					editData = {0, currentTimeTable*masterFileLength+4}
				elseif y >= menuOriginY+49 and y <= menuOriginY+60 then
					editData = {0, currentTimeTable*masterFileLength+5}
				end
			end
			if y >= 51 and y <= 50+12*numStops[currentTimeTable]+tablePos and x >= 14 and x <= 165 then
				editData = {currentTimeTable,timeTableFileLength+math.floor((x-14)/38)+timeTableFileLength*math.floor((y-tablePos-51)/12)}
			elseif y >= 51 and y <= 50+12*numStops[currentTimeTable]+tablePos and x >= 0 and x <= 13 then
				editData = {currentTimeTable,timeTableFileLength+timeTableFileLength*math.floor((y-tablePos-52)/12)}
			end
			if y >= 50+12*numStops[currentTimeTable]+tablePos and y <= menuOriginY and x >= 90 and x <= 165 then
				editData = {currentTimeTable,timeTableFileLength+math.floor((x-14)/38)+2+timeTableFileLength*(-2+2*numStops[currentTimeTable]-math.floor((y-tablePos-51)/12))}
			end
			if y >= 23 and y <= 39 and x <= 151 then
				editData = {0, currentTimeTable*masterFileLength+1}
			end
			-- Scroll bar
			if x >= 166 and x <= 178 then
				local numStations = numStops[currentTimeTable]
				local numStationsF = numStations
				if timeTableData[0][currentTimeTable*masterFileLength+6] == 1 then
					numStationsF = numStations*2-1
					menuOriginY = math.min(50+12*numStationsF,windowHeight-120)
				end
				if y >= 51 and y <= 63 then
					love.wheelmoved(0, 8)
				elseif y >= math.min(64+12*(numStationsF-2),menuOriginY-10)-1 and y <= math.min(64+12*(numStationsF-2),menuOriginY-10)+11 then
					love.wheelmoved(0, -8)
				end
			end
			-- Change Time Axis
			if x >= 308 and x <= 321 then
				if y >= windowHeight-14 then
					timeLimits[2] = timeLimits[2] - 1
					timeLimits[2] = checkRollover(timeLimits[2],24)
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
			-- Change Space Axis
			if x >= 530 and x <= 543 then
				if y >= windowHeight-14 then
					if spaceLimits[2] ~= 0 then --its not max
						spaceLimits[2] = spaceLimits[2] - 1
					else
						spaceLimits[2] = numStops[currentTimeTable]
					end
					spaceCheck(2)
				elseif y >= windowHeight-28 then
					spaceLimits[1] = spaceLimits[1] - 1
					spaceCheck(1)
				end
			elseif x >= 544 and x <= 557 then
				if y >= windowHeight-14 then
					if spaceLimits[2] ~= numStops[currentTimeTable] and spaceLimits[2] ~= 0 then --next is not max
						spaceLimits[2] = spaceLimits[2] + 1
					else
						spaceLimits[2] = 0
					end
					spaceCheck(2)
				elseif y >= windowHeight-28 then
					spaceLimits[1] = spaceLimits[1] + 1
					spaceCheck(1)
				end
			end
			-- Change Timetable Colour
			if y >= menuOriginY+61 and y <= menuOriginY+73 then
				if x >= 154 and x <= 165 then
					timeTableData[0][currentTimeTable*masterFileLength+2] = timeTableData[0][currentTimeTable*masterFileLength+2] - 1
					timeTableData[0][currentTimeTable*masterFileLength+2] = tonumber(checkRollover(timeTableData[0][currentTimeTable*masterFileLength+2]-1,48)+1)
				elseif x >= 166 and x <= 178 then
					timeTableData[0][currentTimeTable*masterFileLength+2] = timeTableData[0][currentTimeTable*masterFileLength+2] + 1
					timeTableData[0][currentTimeTable*masterFileLength+2] = tonumber(checkRollover(timeTableData[0][currentTimeTable*masterFileLength+2]-1,48)+1)
				end
			end
			-- Change Timetable
			if y >= 23 and y <= 39 then
				if x >= 150 and x <= 163 then
					currentTimeTable = currentTimeTable - 1
					currentTimeTable = isLineOOB(currentTimeTable)
					if (spaceLimits[2] > numStops[currentTimeTable]) then
						spaceLimits[2] = 0
					end
					if (spaceLimits[1] > numStops[currentTimeTable]) then
						spaceLimits[1] = 0
					end
				elseif x >= 164 and x <= 178 then
					currentTimeTable = currentTimeTable + 1			
					currentTimeTable = isLineOOB(currentTimeTable)
					if (spaceLimits[2] > numStops[currentTimeTable]) then
						spaceLimits[2] = 0
					end
					if (spaceLimits[1] > numStops[currentTimeTable]) then
						spaceLimits[1] = 0
					end
				end
			end
			-- Save/load
			if y <= 22 and x >= 89 and x <= 178 then
				warningID = 1
				if (spaceLimits[2] > numStops[currentTimeTable]) then
					spaceLimits[2] = 0
				end
				if (spaceLimits[1] > numStops[currentTimeTable]) then
					spaceLimits[1] = 0
				end
				--reloadData()
			elseif y <= 22 and x <= 88 then
				saveToFile()
			end
			-- Add/Remove
			if x <= 178 then
				if y >= menuOriginY+1 and y <= menuOriginY+12 then
					addStation()
				elseif y >= menuOriginY+13 and y <= menuOriginY+24 then
					warningID = 2
				end
			end
			if y >= menuOriginY+85 and y <= menuOriginY+96 and x <= 178 then
				addTimeTable()
			end
			if y >= menuOriginY+97 and y <= menuOriginY+108 and x <= 178 then
				warningID = 3
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
		else -- Warning UI		
			local menuX = math.floor(windowWidth/2)-100
			local menuY = math.floor(windowHeight/2)-50
			if y >= menuY and y <= menuY+16 and x >= menuX and x <= menuX+15 then
				warningID = 0
			end
		end
	end
end


function love.update(dt)
	specialButtonHeld = love.keyboard.isDown( 'lctrl' ) or love.keyboard.isDown( 'lshift' ) or love.keyboard.isDown( 'lalt' ) or love.keyboard.isDown( 'rctrl' ) or love.keyboard.isDown( 'rshift' ) or love.keyboard.isDown( 'ralt' )
	--Correct invalid edit settings
	if editData[1] ~= 0 then
		editData[1] = currentTimeTable
	elseif math.floor(editData[2]/masterFileLength) ~= currentTimeTable then
		editData[2] = editData[2]%masterFileLength + currentTimeTable*masterFileLength
	end
	--Make sure backspace works properly
	backspaceHandler()
end

function love.keypressed( key, scancode, isrepeat )
	if scancode == 'up' then
		if editData[2]%timeTableFileLength <= 3 then
			if editData[2]-timeTableFileLength > timeTableFileLength-1 then
				editData[2] = editData[2] - timeTableFileLength
			end
		else
			if editData[2]+timeTableFileLength < timeTableFileLength*(0+numStops[currentTimeTable]) then
				editData[2] = editData[2] + timeTableFileLength
			else
				editData[2] = editData[2] + 4
			end
		end
	elseif scancode == 'down' then
		if editData[2]%timeTableFileLength <= 3 then
			if editData[2]+timeTableFileLength < timeTableFileLength*(1+numStops[currentTimeTable]) then
				editData[2] = editData[2] + timeTableFileLength
			elseif editData[2]%timeTableFileLength >= 2 then
				editData[2] = editData[2] - 4
			end
		else
			if editData[2]-timeTableFileLength > timeTableFileLength then
				editData[2] = editData[2] - timeTableFileLength
			end
		end
	elseif scancode == 'left' then
		if editData[2]%timeTableFileLength ~= 0 and editData[2]%timeTableFileLength ~= 4 then
			editData[2] = editData[2] - 1
		end
	elseif scancode == 'right' then
		if editData[2]%timeTableFileLength ~= 3 and editData[2]%timeTableFileLength ~= 5 then
			editData[2] = editData[2] + 1
		end
	end
end

function love.draw()
	drawGraph()
	drawLeftMenu()
	drawBottomMenu(178,28)
	--Deal with warnings
	if warningID ~= 0 then
		parseWarnings()
	end
	
	textToPrint = editData[1]..','..editData[2]..','..timeTableData[editData[1]][editData[2]]..','..editData[2]%timeTableFileLength
	--textToPrint = timeTableData[0][currentTimeTable*masterFileLength+6]
	--textToPrint = numTimeTables
	--textToPrint = ''
	--for i=1, numTimeTables do
	--	textToPrint = textToPrint .. "," .. numStops[i]
	--end
	--textToPrint = spaceLimits[2]
	--love.graphics.print(textToPrint.."_", 180, windowHeight-40)
	
end
