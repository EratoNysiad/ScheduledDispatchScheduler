function drawLeftMenu()
	local numStations = numStops[currentTimeTable]
	local numStationsF = numStations
	local menuOriginY = 50+12*numStations
	local menuOriginYH = 48+12*(numStations-4)
	if timeTableData[0][currentTimeTable*masterFileLength+6] == 1 then
		numStationsF = numStations*2-1
		menuOriginY = math.min(50+12*numStationsF,windowHeight-120)
	end
	--First: Draw the table
	--textToPrint = menuOriginY ..','..menuOriginYH
	--Table
	love.graphics.setColor( 168/255,168/255,168/255)
	love.graphics.rectangle( "fill", 0, 0, 178, windowHeight )
	love.graphics.setColor( 131/255,131/255,131/255)
	love.graphics.rectangle( "fill", 1, 52, 164, 12*numStationsF-2 )
	love.graphics.setColor( 148/255,148/255,148/255)
	love.graphics.line( 53, 52, 53, 50+12*numStationsF)
	love.graphics.line( 91, 52, 91, 50+12*numStationsF)
	love.graphics.line( 129, 52, 129, 50+12*numStationsF)
	love.graphics.setColor( 1,1,1)
	love.graphics.draw( spriteGrey1, 53, 52+tablePos)
	for i=1, numStations do
		love.graphics.setColor( 0,0,0)
		if editData[1] == currentTimeTable and math.floor(editData[2]/timeTableFileLength) == i then
			if editData[2] == i*timeTableFileLength then
				love.graphics.print(timeTableData[currentTimeTable][i*timeTableFileLength]..'_', 2, 39+i*12+tablePos)
			else
				love.graphics.print(timeTableData[currentTimeTable][i*timeTableFileLength], 2, 39+i*12+tablePos)
			end
			if editData[2] == i*timeTableFileLength+1 then
				love.graphics.print(timeTableData[currentTimeTable][i*timeTableFileLength+1]..'_', 54, 39+i*12+tablePos)
			else
				love.graphics.print(timeTableData[currentTimeTable][i*timeTableFileLength+1], 54, 39+i*12+tablePos)
			end
			if editData[2] == i*timeTableFileLength+2 then
				love.graphics.print(timeTableData[currentTimeTable][i*timeTableFileLength+2]..'_', 92, 39+i*12+tablePos)
			else
				love.graphics.print(timeTableData[currentTimeTable][i*timeTableFileLength+2], 92, 39+i*12+tablePos)
			end
			if editData[2] == i*timeTableFileLength+3 then
				love.graphics.print(timeTableData[currentTimeTable][i*timeTableFileLength+3]..'_', 130, 39+i*12+tablePos)
			else
				love.graphics.print(timeTableData[currentTimeTable][i*timeTableFileLength+3], 130, 39+i*12+tablePos)
			end
		else
			love.graphics.print(timeTableData[currentTimeTable][i*timeTableFileLength], 2, 39+i*12+tablePos)
			love.graphics.print(timeTableData[currentTimeTable][i*timeTableFileLength+1], 54, 39+i*12+tablePos)
			love.graphics.print(timeTableData[currentTimeTable][i*timeTableFileLength+2], 92, 39+i*12+tablePos)
			love.graphics.print(timeTableData[currentTimeTable][i*timeTableFileLength+3], 130, 39+i*12+tablePos)
		end
		if i~=numStations or timeTableData[0][currentTimeTable*masterFileLength+6] == 1 then
			love.graphics.setColor( 148/255,148/255,148/255)
			love.graphics.line( 1, 51+12*i+tablePos, 165, 51+12*i+tablePos)
			love.graphics.setColor( 115/255,115/255,115/255)
			love.graphics.line( 1, 50+12*i+tablePos, 165, 50+12*i+tablePos)
		end
		if i~=stationInMain(timeTableData[currentTimeTable][i*timeTableFileLength]) then
			love.graphics.setColor( 1,1,1)
			love.graphics.draw( spriteWarnIcon, 41, 41+i*12+tablePos)
		end
	end
	--If reverse toggled
	if timeTableData[0][currentTimeTable*masterFileLength+6] == 1 then
		for i=1, numStations-1 do
			local stationNum = numStations-i
			if editData[1] == currentTimeTable and math.floor(editData[2]/timeTableFileLength) == stationNum then
				love.graphics.setColor( 1,1,1)
				love.graphics.draw( spriteGreyR, 1, 40+i*12+menuOriginYH+tablePos)
				love.graphics.setColor( 0,0,0)
				love.graphics.print(timeTableData[currentTimeTable][stationNum*timeTableFileLength], 2, 39+i*12+menuOriginYH+tablePos)
				love.graphics.print(timeTableData[currentTimeTable][(stationNum+1)*timeTableFileLength+1], 54, 39+i*12+menuOriginYH+tablePos)
				if editData[2] == stationNum*timeTableFileLength+4 then
					love.graphics.print(timeTableData[currentTimeTable][stationNum*timeTableFileLength+4]..'_', 92, 39+i*12+menuOriginYH+tablePos)
				else
					love.graphics.print(timeTableData[currentTimeTable][stationNum*timeTableFileLength+4], 92, 39+i*12+menuOriginYH+tablePos)
				end
				if editData[2] == stationNum*timeTableFileLength+5 then
					love.graphics.print(timeTableData[currentTimeTable][stationNum*timeTableFileLength+5]..'_', 130, 39+i*12+menuOriginYH+tablePos)
				else
					love.graphics.print(timeTableData[currentTimeTable][stationNum*timeTableFileLength+5], 130, 39+i*12+menuOriginYH+tablePos)
				end
			else
				love.graphics.setColor( 1,1,1)
				love.graphics.draw( spriteGreyR, 1, 40+i*12+menuOriginYH+tablePos)
				love.graphics.print(timeTableData[currentTimeTable][stationNum*timeTableFileLength], 2, 39+i*12+menuOriginYH+tablePos)
				love.graphics.print(timeTableData[currentTimeTable][(stationNum+1)*timeTableFileLength+1], 54, 39+i*12+menuOriginYH+tablePos)
				love.graphics.print(timeTableData[currentTimeTable][stationNum*timeTableFileLength+4], 92, 39+i*12+menuOriginYH+tablePos)
				love.graphics.print(timeTableData[currentTimeTable][stationNum*timeTableFileLength+5], 130, 39+i*12+menuOriginYH+tablePos)
			end
			if i~=numStations-1 then
				love.graphics.setColor( 148/255,148/255,148/255)
				love.graphics.line( 1, 51+12*i+menuOriginYH+tablePos, 165, 51+12*i+menuOriginYH+tablePos)
				love.graphics.setColor( 115/255,115/255,115/255)
				love.graphics.line( 1, 50+12*i+menuOriginYH+tablePos, 165, 50+12*i+menuOriginYH+tablePos)
			end
		end
	end
	love.graphics.setColor( 115/255,115/255,115/255)
	love.graphics.line( 52, 52, 52, menuOriginY)
	love.graphics.line( 90, 52, 90, menuOriginY)
	love.graphics.line( 128, 52, 128, menuOriginY)
	
	--Scroll bar
	love.graphics.setColor( 1,1,1)
	for i=0, math.ceil(windowHeight/500) do
		love.graphics.draw( spriteScrollBar, 166, i*500)
	end
	local barPos = 0
	if tablePos ~= 0 then
		local maxTablePosVal = windowHeight-120-51-12*numStationsF
		local diffHeight = math.floor((menuOriginY-76)*(windowHeight-195)/((numStationsF-2)*12))+2-windowHeight+195
		barPos = -math.ceil(tablePos*diffHeight/maxTablePosVal-1)
	end
	love.graphics.setColor( 168/255,168/255,168/255)
	love.graphics.rectangle( "fill", 166, 51, 11, 11 )
	love.graphics.rectangle( "fill", 166, math.min(64+12*(numStationsF-2),menuOriginY-10)-1, 11, 11 )
	love.graphics.rectangle( "fill", 166, barPos+63, 11, math.min(12*(numStationsF-2)-2,math.floor((menuOriginY-76)*(windowHeight-195)/((numStationsF-2)*12)))+1)
	love.graphics.setColor( 131/255,131/255,131/255)
	--math.floor((menuOriginY-76)*(windowHeight-195)/((numStationsF-1)*12))
	love.graphics.rectangle( "fill", 167, 52, 10, 10 )
	love.graphics.rectangle( "fill", 167, barPos+64, 10, math.min(12*(numStationsF-2)-2,math.floor((menuOriginY-76)*(windowHeight-195)/((numStationsF-2)*12))))
	love.graphics.rectangle( "fill", 167, math.min(64+12*(numStationsF-2),menuOriginY-10), 10, 10 )
	love.graphics.setColor( 100/255,100/255,100/255)
	love.graphics.line( 166, barPos+math.min(62+12*(numStationsF-2),math.floor((menuOriginY-76)*(windowHeight-195)/((numStationsF-2)*12))+64), 178, barPos+math.min(62+12*(numStationsF-2),math.floor((menuOriginY-76)*(windowHeight-195)/((numStationsF-2)*12))+64))
	
	
	--Draw boxes
	love.graphics.setColor( 168/255,168/255,168/255)
	love.graphics.rectangle( "fill", 0, 0, 178, 51 )
	love.graphics.rectangle( "fill", 0, menuOriginY, 178, windowHeight )
	love.graphics.setColor( 131/255,131/255,131/255)
	love.graphics.rectangle( "fill", 1, 1, 87, 21 )
	love.graphics.rectangle( "fill", 90, 1, 87, 21 )
	love.graphics.rectangle( "fill", 151, 24, 12, 14 )
	love.graphics.rectangle( "fill", 165, 24, 12, 14 )
	love.graphics.rectangle( "fill", 1, 40, 50, 10 )
	love.graphics.rectangle( "fill", 53, 40, 36, 10 )
	love.graphics.rectangle( "fill", 91, 40, 36, 10 )
	love.graphics.rectangle( "fill", 167, 40, 10, 10 )
	love.graphics.rectangle( "fill", 129, 40, 36, 10 )
	--bar
	--cont
	love.graphics.rectangle( "fill", 1, menuOriginY+2, 178, 10 )
	love.graphics.rectangle( "fill", 1, menuOriginY+14, 178, 10 )
	love.graphics.rectangle( "fill", 1, menuOriginY+26, 97, 10 )
	love.graphics.rectangle( "fill", 100, menuOriginY+26, 77, 10 )
	love.graphics.rectangle( "fill", 1, menuOriginY+38, 97, 10 )
	love.graphics.rectangle( "fill", 100, menuOriginY+38, 77, 10 )
	love.graphics.rectangle( "fill", 1, menuOriginY+50, 97, 10 )
	love.graphics.rectangle( "fill", 100, menuOriginY+50, 77, 10 )
	love.graphics.rectangle( "fill", 1, menuOriginY+62, 48, 10 )
	love.graphics.rectangle( "fill", 51, menuOriginY+62, 72, 10 )
	love.graphics.rectangle( "fill", 155, menuOriginY+62, 10, 10 )
	love.graphics.rectangle( "fill", 167, menuOriginY+62, 10, 10 )
	love.graphics.rectangle( "fill", 1, menuOriginY+74, 178, 10 )
	love.graphics.rectangle( "fill", 1, menuOriginY+86, 178, 10 )
	love.graphics.rectangle( "fill", 1, menuOriginY+98, 178, 10 )
	love.graphics.rectangle( "fill", 1, menuOriginY+110, 178, 10 )
	love.graphics.setColor( 100/255,100/255,100/255)
	love.graphics.line( 0, 22, 178, 22)
	love.graphics.line( 0, 38, 178, 38)
	love.graphics.line( 164, 38, 164, 22)
	love.graphics.line( 150, 38, 150, 22)
	love.graphics.line( 2, 38, 2, 24, 150, 24)
	love.graphics.line( 0, 50, 178, 50)
	love.graphics.line( 52, 50, 52, 39)
	love.graphics.line( 90, 50, 90, 39)
	love.graphics.line( 128, 50, 128, 39)
	love.graphics.line( 166, 50, 166, 39)
	love.graphics.line( 166, 62, 178, 62)
	love.graphics.line( 89, 22, 89,0)
	love.graphics.line( 166, math.min(62+12*(numStationsF-1),menuOriginY), 178, math.min(62+12*(numStationsF-1),menuOriginY))
	love.graphics.line( 0, windowHeight-1, 178, windowHeight-1, 178,0)
	love.graphics.line( 0, menuOriginY, 166, menuOriginY, 166, 39)
	love.graphics.line( 0, menuOriginY+12, 178, menuOriginY+12)
	love.graphics.line( 0, menuOriginY+24, 178, menuOriginY+24)
	love.graphics.line( 0, menuOriginY+36, 178, menuOriginY+36)
	love.graphics.line( 0, menuOriginY+48, 178, menuOriginY+48)
	love.graphics.line( 0, menuOriginY+60, 178, menuOriginY+60)
	love.graphics.line( 99, menuOriginY+24, 99, menuOriginY+60)
	love.graphics.line( 0, menuOriginY+72, 178, menuOriginY+72)
	love.graphics.line( 50, menuOriginY+60, 50, menuOriginY+72)
	love.graphics.line( 124, menuOriginY+60, 124, menuOriginY+72)
	love.graphics.line( 126, menuOriginY+72, 126, menuOriginY+62, 154, menuOriginY+62)
	love.graphics.line( 154, menuOriginY+60, 154, menuOriginY+72)
	love.graphics.line( 166, menuOriginY+60, 166, menuOriginY+72)
	love.graphics.line( 0, menuOriginY+84, 178, menuOriginY+84)
	love.graphics.line( 0, menuOriginY+96, 178, menuOriginY+96)
	love.graphics.line( 0, menuOriginY+108, 178, menuOriginY+108)
	love.graphics.line( 0, menuOriginY+120, 178, menuOriginY+120)
	--Line name box
	love.graphics.setColor( lineColour[tonumber(timeTableData[0][currentTimeTable*masterFileLength+2])] )
	love.graphics.rectangle( "fill", 3, 25, 145, 12 )
	love.graphics.rectangle( "fill", 126, menuOriginY+63, 26, 8 )
	
	
	
	--Draw sprites and text
	love.graphics.setColor( 1,1,1)
	love.graphics.draw( spriteSaveButton, 3, 2)
	love.graphics.draw( spriteLoadButton, 92, 1)
	love.graphics.setColor( 0,0,0)
	love.graphics.print("Save", 24, 5)
	love.graphics.print("Reload", 115, 5)
	if editData[1] == 0 and editData[2] == currentTimeTable*masterFileLength+1 then
		love.graphics.print(timeTableData[0][currentTimeTable*masterFileLength+1]..'_', 4, 25)
	else
		love.graphics.print(timeTableData[0][currentTimeTable*masterFileLength+1], 4, 25)
	end
	love.graphics.print(">", 167, 25)
	love.graphics.print("<", 153, 25)
	love.graphics.print("Station", 2, 39)
	love.graphics.print("Dist", 54, 39)
	love.graphics.print("Time", 92, 39)
	love.graphics.print("Wait", 130, 39)
	love.graphics.print("%", 168, 52)
	love.graphics.print("$", 168, math.min(49+12*(numStationsF-1),menuOriginY-13))
	
	--Set the currentStation
	currentStation = math.floor(editData[2]/timeTableFileLength)
	if timeTableData[currentTimeTable][currentStation*timeTableFileLength] == nil or timeTableData[currentTimeTable][currentStation*timeTableFileLength] == "Code" or editData[1] == 0 then
		currentStation = numStations
	end
	if specialButtonHeld then
		love.graphics.print("Add station after "..timeTableData[currentTimeTable][currentStation*timeTableFileLength], 2, menuOriginY+1)
	else
		love.graphics.print("Add station before "..timeTableData[currentTimeTable][currentStation*timeTableFileLength], 2, menuOriginY+1)
	end
	love.graphics.print("Remove station "..timeTableData[currentTimeTable][currentStation*timeTableFileLength], 2, menuOriginY+13)
	love.graphics.print("First train:", 2, menuOriginY+25)
	love.graphics.print("Repeat every:", 2, menuOriginY+37)
	love.graphics.print("No later than:", 2, menuOriginY+49)
	if editData[1] == 0 then
		if editData[2] == currentTimeTable*masterFileLength+3 then
			love.graphics.print(timeTableData[0][currentTimeTable*masterFileLength+3]..'_', 101, menuOriginY+25)
		else
			love.graphics.print(timeTableData[0][currentTimeTable*masterFileLength+3], 101, menuOriginY+25)
		end
		if editData[2] == currentTimeTable*masterFileLength+4 then
			love.graphics.print(timeTableData[0][currentTimeTable*masterFileLength+4]..'_', 101, menuOriginY+37)
		else
			love.graphics.print(timeTableData[0][currentTimeTable*masterFileLength+4], 101, menuOriginY+37)
		end
		if editData[2] == currentTimeTable*masterFileLength+5 then
			love.graphics.print(timeTableData[0][currentTimeTable*masterFileLength+5]..'_', 101, menuOriginY+49)
		else
			love.graphics.print(timeTableData[0][currentTimeTable*masterFileLength+5], 101, menuOriginY+49)
		end
	else
		love.graphics.print(timeTableData[0][currentTimeTable*masterFileLength+3], 101, menuOriginY+25)
		love.graphics.print(timeTableData[0][currentTimeTable*masterFileLength+4], 101, menuOriginY+37)
		love.graphics.print(timeTableData[0][currentTimeTable*masterFileLength+5], 101, menuOriginY+49)
	end
	love.graphics.print("Colour:", 2, menuOriginY+61)
	love.graphics.print(lineColourNames[tonumber(timeTableData[0][currentTimeTable*masterFileLength+2])], 52, menuOriginY+61)
	love.graphics.print(">", 168, menuOriginY+61)
	love.graphics.print("<", 156, menuOriginY+61)
	love.graphics.print("Toggle turnaround", 2, menuOriginY+73)
	love.graphics.print("Add new timetable", 2, menuOriginY+85)
	love.graphics.print("Remove timetable", 2, menuOriginY+97)
	love.graphics.print("Open save folder", 2, menuOriginY+109)
	
	--Fill the blank space
	love.graphics.setColor( 131/255,131/255,131/255)
	love.graphics.rectangle( "fill", 1, menuOriginY+122, 176, windowHeight-menuOriginY-123 )
	
end

function drawBottomMenu(x,y)
	local menuOriginX = x
	local menuOriginY = windowHeight-y
	--Draw boxes
	love.graphics.setColor( 168/255,168/255,168/255)
	love.graphics.rectangle( "fill", menuOriginX, menuOriginY, windowWidth-menuOriginX, y )
	love.graphics.setColor( 131/255,131/255,131/255)
	love.graphics.rectangle( "fill", menuOriginX+1, menuOriginY+1, 111, 12 )
	love.graphics.rectangle( "fill", menuOriginX+1, menuOriginY+15, 111, 12 )
	love.graphics.rectangle( "fill", menuOriginX+114, menuOriginY+1, 15, 12 )
	love.graphics.rectangle( "fill", menuOriginX+114, menuOriginY+15, 15, 12 )
	love.graphics.rectangle( "fill", menuOriginX+131, menuOriginY+1, 12, 12 )
	love.graphics.rectangle( "fill", menuOriginX+131, menuOriginY+15, 12, 12 )
	love.graphics.rectangle( "fill", menuOriginX+145, menuOriginY+1, 12, 12 )
	love.graphics.rectangle( "fill", menuOriginX+145, menuOriginY+15, 12, 12 )
	love.graphics.rectangle( "fill", menuOriginX+159, menuOriginY+1, 140, 12 )
	love.graphics.rectangle( "fill", menuOriginX+159, menuOriginY+15, 140, 12 )
	love.graphics.rectangle( "fill", menuOriginX+301, menuOriginY+1, 50, 12 )
	love.graphics.rectangle( "fill", menuOriginX+301, menuOriginY+15, 50, 12 )
	love.graphics.rectangle( "fill", menuOriginX+353, menuOriginY+1, 12, 12 )
	love.graphics.rectangle( "fill", menuOriginX+353, menuOriginY+15, 12, 12 )
	love.graphics.rectangle( "fill", menuOriginX+367, menuOriginY+1, 12, 12 )
	love.graphics.rectangle( "fill", menuOriginX+367, menuOriginY+15, 12, 12 )
	love.graphics.rectangle( "fill", menuOriginX+381, menuOriginY+1, windowWidth-menuOriginX-382, 26 )
	love.graphics.setColor( 100/255,100/255,100/255)
	love.graphics.line( menuOriginX, menuOriginY+27, windowWidth, menuOriginY+27, windowWidth, menuOriginY)
	love.graphics.line( menuOriginX, menuOriginY+13, menuOriginX+380, menuOriginY+13)
	love.graphics.line( menuOriginX+113, menuOriginY, menuOriginX+113, menuOriginY+27)
	love.graphics.line( menuOriginX+130, menuOriginY, menuOriginX+130, menuOriginY+27)
	love.graphics.line( menuOriginX+144, menuOriginY, menuOriginX+144, menuOriginY+27)
	love.graphics.line( menuOriginX+158, menuOriginY, menuOriginX+158, menuOriginY+27)
	love.graphics.line( menuOriginX+300, menuOriginY, menuOriginX+300, menuOriginY+27)
	love.graphics.line( menuOriginX+352, menuOriginY, menuOriginX+352, menuOriginY+27)
	love.graphics.line( menuOriginX+366, menuOriginY, menuOriginX+366, menuOriginY+27)
	love.graphics.line( menuOriginX+380, menuOriginY, menuOriginX+380, menuOriginY+27)
	love.graphics.setColor( 212/255,188/255,148/255)
	love.graphics.line( menuOriginX+1, menuOriginY-1, menuOriginX,0, windowWidth, 0)
	love.graphics.setColor( 104/255,80/255,44/255)
	love.graphics.line( menuOriginX, menuOriginY-1, windowWidth, menuOriginY-1, windowWidth, 0)
	--Draw text
	love.graphics.setColor( 0,0,0)
	love.graphics.print("Time axis start:", menuOriginX+2, menuOriginY+1)
	love.graphics.print("Time axis end:", menuOriginX+2, menuOriginY+15)
	love.graphics.print(timeLimits[1], menuOriginX+115, menuOriginY+1)
	love.graphics.print(timeLimits[2], menuOriginX+115, menuOriginY+15)
	love.graphics.print("<", menuOriginX+133, menuOriginY+1)
	love.graphics.print("<", menuOriginX+133, menuOriginY+15)
	love.graphics.print(">", menuOriginX+147, menuOriginY+1)
	love.graphics.print(">", menuOriginX+147, menuOriginY+15)
	
	love.graphics.print("Distance axis start:", menuOriginX+160, menuOriginY+1)
	love.graphics.print("Distance axis end:", menuOriginX+160, menuOriginY+15)
	if spaceLimits[1] == 0 then
		love.graphics.print("Min", menuOriginX+303, menuOriginY+1)
	else
		love.graphics.print(timeTableData[currentTimeTable][spaceLimits[1]*timeTableFileLength], menuOriginX+303, menuOriginY+1)
	end
	if spaceLimits[2] == 0 then
		love.graphics.print("Max", menuOriginX+303, menuOriginY+15)
	else
		love.graphics.print(timeTableData[currentTimeTable][spaceLimits[2]*timeTableFileLength], menuOriginX+303, menuOriginY+15)
	end
	love.graphics.print("<", menuOriginX+355, menuOriginY+1)
	love.graphics.print("<", menuOriginX+355, menuOriginY+15)
	love.graphics.print(">", menuOriginX+369, menuOriginY+1)
	love.graphics.print(">", menuOriginX+369, menuOriginY+15)
end