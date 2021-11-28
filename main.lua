-- run using "E:\Program Files\LOVE\love.exe" "$(CURRENT_DIRECTORY)"

require "init"
require "keyhandling"
require "drawGUI"
require "drawGraph"

function is24Plus(num)
	if num >= 24 then
		return -24
	elseif num < 0 then
		return 24
	else
		return 0
	end
end

function love.mousepressed(x, y, button)
	if button == 1 then
		if x >= 308 and x <= 321 then
			if y >= windowHeight-14 then
				timeLimits[2] = timeLimits[2] - 1
				timeLimits[2] = timeLimits[2]+is24Plus(timeLimits[2])
			elseif y >= windowHeight-28 then
				timeLimits[1] = timeLimits[1] - 1
				timeLimits[1] = timeLimits[1]+is24Plus(timeLimits[1])
			end
		elseif x >= 322 and x <= 335 then
			if y >= windowHeight-14 then
				timeLimits[2] = timeLimits[2] + 1
				timeLimits[2] = timeLimits[2]+is24Plus(timeLimits[2])
			elseif y >= windowHeight-28 then
				timeLimits[1] = timeLimits[1] + 1
				timeLimits[1] = timeLimits[1]+is24Plus(timeLimits[1])
			end
		end
		
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
	
	
	--textToPrint = timeTableData[currentTimeTable][currentStation*4]
	love.graphics.print(5+tonumber("-20"), 140, 346)
	love.graphics.print(textToPrint.."_", 12, 245+14)
	
end
