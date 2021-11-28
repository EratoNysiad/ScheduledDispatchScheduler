function drawGraph()
	--Figure out graph dimensions
	local graphX, graphY 
	graphX = windowWidth - 260
	graphY = windowHeight - 60
	love.graphics.setColor( 0,0,0)
	local stationPos = {}
	stationPos[0] = 0
	for i=1, numStops[currentTimeTable] do
		stationPos[i] = stationPos[i-1] + tonumber(timeTableData[currentTimeTable][i*4+1])
	end
	local minDist = math.min(unpack(stationPos))
	for i=1, numStops[currentTimeTable] do
		stationPos[i] = stationPos[i]-minDist--fixes lowest at 0
	end
	local maxDist = math.max(unpack(stationPos))
	for i=1, numStops[currentTimeTable] do
		stationPos[i] = math.ceil(stationPos[i]*(graphY-1)/maxDist)--scales it so highest is at graphY
	end
	local deltaTime = timeLimits[2]-timeLimits[1]
	if deltaTime <= 0 then
		deltaTime = 24 + deltaTime
	end
	for i=0, deltaTime do
		local printTime = (timeLimits[1]+i)%24
		if printTime == 0 or printTime == 12 then
			love.graphics.setColor( 81/255,81/255,81/255)
		else
			love.graphics.setColor( 48/255,48/255,48/255)
		end
		love.graphics.line( 251+math.ceil(i*graphX/deltaTime), 10, 251+math.ceil(i*graphX/deltaTime), 10+graphY )
	end
	for i=1, numStops[currentTimeTable] do
		love.graphics.setColor( 48/255,48/255,48/255)
		love.graphics.line( 252, 10+stationPos[i], 252+graphX, 10+stationPos[i] )
	end
	--Draw lines
	love.graphics.setColor( lineColour[tonumber(masterFile[currentTimeTable*6+2])] )
	love.graphics.setLineWidth( 2 )
	local startTime = math.floor(tonumber(masterFile[currentTimeTable*6+3])/100)*60+tonumber(masterFile[currentTimeTable*6+3])%100
	local repeatTime = math.floor(tonumber(masterFile[currentTimeTable*6+4])/100)*60+tonumber(masterFile[currentTimeTable*6+4])%100
	local maxTime = math.floor(tonumber(masterFile[currentTimeTable*6+5])/100)*60+tonumber(masterFile[currentTimeTable*6+5])%100
	local timeWidth = graphX/(deltaTime*60)
	
	for j=-1, 1 do
		local currentStartTime = startTime - 1440*j
		for k=0, 200 do
			local currentTime
			if repeatTime == 0 then
				currentTime = currentStartTime
			else
				currentTime = currentStartTime+repeatTime*k
				if maxTime < startTime then
					if currentTime%1440 > maxTime and currentTime%1440 < startTime then
						break
					end
				else
					if currentTime%1440 > maxTime or currentTime%1440 < startTime then
						break
					end
				end
				
			end
			currentTime = currentTime - timeLimits[1]*60
			for i=1, numStops[currentTimeTable]-1 do
				local prevTime = currentTime
				currentTime = currentTime + tonumber(timeTableData[currentTimeTable][(i+1)*4+2])
				love.graphics.line( 251+(prevTime*timeWidth), 10+stationPos[i], 251+(currentTime*timeWidth), 10+stationPos[i+1] )
				prevTime = currentTime
				currentTime = currentTime + tonumber(timeTableData[currentTimeTable][(i+1)*4+3])
				love.graphics.line( 251+(prevTime*timeWidth), 10+stationPos[i+1], 251+(currentTime*timeWidth), 10+stationPos[i+1] )
			end		
			if repeatTime == 0 then
				break
			end
			
		end
	end
		
	love.graphics.setLineWidth( 1 )
	
	--Cover up everything out of bounds
	love.graphics.setColor( 152/255, 132/255, 92/255)
	love.graphics.rectangle( "fill", 0, 0, 250, windowHeight )
	love.graphics.rectangle( "fill", 250, 0, windowWidth-250, 10 )
	love.graphics.rectangle( "fill", 250, windowHeight-50, windowWidth-250, 50 )
	love.graphics.rectangle( "fill", windowWidth-10, 10, windowWidth-10, windowHeight-50 )
	--Draw station names (do last)
	for i=1, numStops[currentTimeTable] do
		love.graphics.setColor( 0,0,0)
		love.graphics.line( 250, 10+stationPos[i], 247, 10+stationPos[i] )
		love.graphics.printf(timeTableData[currentTimeTable][i*4], 96, 4+stationPos[i], 150, "right")
	end
	for i=0, deltaTime do
		love.graphics.setColor( 0,0,0)
		local printTime = (timeLimits[1]+i)%24
		love.graphics.printf(printTime, 241+math.ceil(i*graphX/deltaTime), 8+graphY, 20, "center")
		love.graphics.printf(printTime, 241+math.ceil(i*graphX/deltaTime), -1, 20, "center")
	end
	
	
	love.graphics.setColor( lineColour[tonumber(masterFile[currentTimeTable*6+2])] )

end
