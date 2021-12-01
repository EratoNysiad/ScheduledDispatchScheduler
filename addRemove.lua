function addStation()
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

function addTimeTable()
	for i=numTimeTables, currentTimeTable, -1 do
		for j=0, masterFileLength-1 do
			timeTableData[0][(i+1)*masterFileLength+j] = timeTableData[0][i*masterFileLength+j]
		end
	end
	timeTableData[0][(currentTimeTable+1)*masterFileLength+1] = timeTableData[0][(currentTimeTable+1)*masterFileLength+1].." new"
	--Pick a new filename
	local candidateName
	for j=1, numTimeTables*30 do
		candidateName = 'TT'..j
		local candidateFound = false
		for i=1, numTimeTables+1 do
			if timeTableData[0][i*masterFileLength] == candidateName then
				break
			elseif i == numTimeTables+1 then
				candidateFound = true
			end
		end
		if candidateFound then
			timeTableData[0][(currentTimeTable+1)*masterFileLength] = candidateName
			break
		end
	end
	for i=numTimeTables, currentTimeTable, -1 do
		timeTableData[i+1] = timeTableData[i]
		numStops[i+1] = numStops[i]
	end
	numTimeTables = numTimeTables + 1
	currentTimeTable = currentTimeTable + 1
end

function removeTimeTable()
	if currentTimeTable ~= numTimeTables then
		for i=currentTimeTable, numTimeTables-1 do
			for j=0, masterFileLength-1 do
				timeTableData[0][(i)*masterFileLength+j] = timeTableData[0][(i+1)*masterFileLength+j]
			end
		end	
		timeTableData[0][(numTimeTables)*masterFileLength] = nil
		for i=currentTimeTable, numTimeTables-1 do
			timeTableData[i] = timeTableData[i+1]
			numStops[i] = numStops[i+1]
		end
	end
	numTimeTables = numTimeTables - 1
	currentTimeTable = currentTimeTable - 1
end