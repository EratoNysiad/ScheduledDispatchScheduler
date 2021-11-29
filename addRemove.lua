function addStation()
	addremoveStillPressed = false
	for i=numStops[currentTimeTable], currentStation, -1 do
		for j=0, timeTableFileLength-1 do
			timeTableData[currentTimeTable][(i+1)*timeTableFileLength+j] = timeTableData[currentTimeTable][i*timeTableFileLength+j]
		end
	end
	numStops[currentTimeTable] = numStops[currentTimeTable] + 1
	if specialButtonHeld then
		editData[2] = editData[2] + timeTableFileLength
	end
end

function removeStation()
	addremoveStillPressed = false
	for i=currentStation, numStops[currentTimeTable]-1 do
		for j=0, timeTableFileLength-1 do
			timeTableData[currentTimeTable][(i)*timeTableFileLength+j] = timeTableData[currentTimeTable][(i+1)*timeTableFileLength+j]
		end
	end
	numStops[currentTimeTable] = numStops[currentTimeTable] - 1
	if editData[2] > numStops[currentTimeTable]*timeTableFileLength then
		editData[2] = editData[2] - timeTableFileLength
	end
end 