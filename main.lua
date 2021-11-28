-- run using "E:\Program Files\LOVE\love.exe" "$(CURRENT_DIRECTORY)"

require "loadHandling"
require "saveHandling"
require "init"
require "keyhandling"
require "drawGUI"
require "drawGraph"

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
		if y >= 159 and y <= 171 then
			if x >= 154 and x <= 165 then
				masterFile[currentTimeTable*6+2] = masterFile[currentTimeTable*6+2] - 1
				masterFile[currentTimeTable*6+2] = tonumber(checkRollover(masterFile[currentTimeTable*6+2]-1,16)+1)
			elseif x >= 166 and x <= 178 then
				masterFile[currentTimeTable*6+2] = masterFile[currentTimeTable*6+2] + 1
				masterFile[currentTimeTable*6+2] = tonumber(checkRollover(masterFile[currentTimeTable*6+2]-1,16)+1)
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
		if y <= 22 and x >= 89 and x <= 178 then
			reloadData()
		end
		if y <= 22 and x <= 88 then
			saveToFile()
		end
	end
end


function love.update(dt)
	backspaceHandler()
	--textToPrint = love.filesystem.read( 'ttdata/ttmf.dat' )--( 'ttdata/'.. masterFile[6] ..'.dat' )
end


function love.draw()
	drawGraph()
	drawLeftMenu()
	drawBottomMenu(178,28)
	
	textToPrint=numTimeTables
	love.graphics.print(5+tonumber("-20"), 140, 346)
	love.graphics.print(textToPrint.."_", 12, 245+28)
	
end
