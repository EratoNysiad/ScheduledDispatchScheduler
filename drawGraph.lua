function stationInMain(stationName)
	for i=1, numStops[currentTimeTable] do
		if stationName == timeTableData[currentTimeTable][i*timeTableFileLength] then
			return i
		end
	end
	return 0
end

function drawGraph()
	--Figure out graph dimensions
	local graphX, graphY 
	graphX = windowWidth - 260
	graphY = windowHeight - 60
	love.graphics.setColor( 0,0,0)
	local stationPos = {}
	stationPos[0] = 0
	for i=1, numStops[currentTimeTable] do
		stationPos[i] = stationPos[i-1] + tonumber(timeTableData[currentTimeTable][i*timeTableFileLength+1])
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
	local timeWidth = graphX/(deltaTime*60)
	for i=0, deltaTime do
		local printTime = (timeLimits[1]+i)%24
		if printTime == 0 or printTime == 12 then
			love.graphics.setColor( 81/255,81/255,81/255)
		else
			love.graphics.setColor( 48/255,48/255,48/255)
		end
		love.graphics.line( 251+math.ceil(i*graphX/deltaTime), 10, 251+math.ceil(i*graphX/deltaTime), 10+graphY )
		if timeWidth >= 2 then
			love.graphics.line( 251+math.ceil((i+0.5)*graphX/deltaTime), 10, 251+math.ceil((i+0.5)*graphX/deltaTime), 10+graphY )
		end
	end
	for i=1, numStops[currentTimeTable] do
		love.graphics.setColor( 48/255,48/255,48/255)
		love.graphics.line( 252, 10+stationPos[i], 252+graphX, 10+stationPos[i] )
	end
	--Draw lines
	love.graphics.setLineWidth( 2 )
	for n=1, numTimeTables do
		local startTime = math.floor(tonumber(timeTableData[0][n*masterFileLength+3])/100)*60+tonumber(timeTableData[0][n*masterFileLength+3])%100
		local repeatTime = math.floor(tonumber(timeTableData[0][n*masterFileLength+4])/100)*60+tonumber(timeTableData[0][n*masterFileLength+4])%100
		local maxTime = math.floor(tonumber(timeTableData[0][n*masterFileLength+5])/100)*60+tonumber(timeTableData[0][n*masterFileLength+5])%100
	
		love.graphics.setColor( lineColour[tonumber(timeTableData[0][n*masterFileLength+2])] )
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
				--Draw lines
				if n == currentTimeTable then
					for i=1, numStops[n]-1 do
						local prevTime = currentTime
						currentTime = currentTime + tonumber(timeTableData[n][(i+1)*timeTableFileLength+2])
						love.graphics.line( 251+(prevTime*timeWidth), 10+stationPos[i], 251+(currentTime*timeWidth), 10+stationPos[i+1] )
						prevTime = currentTime
						currentTime = currentTime + tonumber(timeTableData[n][(i+1)*timeTableFileLength+3])
						love.graphics.line( 251+(prevTime*timeWidth), 10+stationPos[i+1], 251+(currentTime*timeWidth), 10+stationPos[i+1] )
					end		
					if repeatTime == 0 then
						break
					end
				else
					for i=1, numStops[n]-1 do
						local thisStation = stationInMain(timeTableData[n][i*timeTableFileLength])
						local nextStation = stationInMain(timeTableData[n][(i+1)*timeTableFileLength])
						local prevTime = currentTime
						currentTime = currentTime + tonumber(timeTableData[n][(i+1)*timeTableFileLength+2])
						if thisStation ~= 0 and nextStation ~= 0 then
							love.graphics.line( 251+(prevTime*timeWidth), 10+stationPos[thisStation], 251+(currentTime*timeWidth), 10+stationPos[nextStation] )
						end
						prevTime = currentTime
						currentTime = currentTime + tonumber(timeTableData[n][(i+1)*timeTableFileLength+3])
						if thisStation ~= 0 and nextStation ~= 0 then
							love.graphics.line( 251+(prevTime*timeWidth), 10+stationPos[nextStation], 251+(currentTime*timeWidth), 10+stationPos[nextStation] )
						end
					end		
					if repeatTime == 0 then
						break
					end
				end
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
		love.graphics.printf(timeTableData[currentTimeTable][i*timeTableFileLength], 96, 4+stationPos[i], 150, "right")
	end
	for i=0, deltaTime do
		love.graphics.setColor( 0,0,0)
		local printTime = (timeLimits[1]+i)%24
		love.graphics.printf(printTime, 241+math.ceil(i*graphX/deltaTime), 8+graphY, 20, "center")
		love.graphics.printf(printTime, 241+math.ceil(i*graphX/deltaTime), -1, 20, "center")
	end
	
	
	love.graphics.setColor( lineColour[tonumber(timeTableData[0][currentTimeTable*masterFileLength+2])] )

end
