function saveMasterFile()
	local masterFileData = ""
	for i=1, (numTimeTables+1)*masterFileLength do
		local currentBit = timeTableData[0][i-1]
		if currentBit == nil then
			textToPrint = i
		else
			masterFileData = masterFileData..currentBit
			if timeTableData[0][i]~=nil or i~=(numTimeTables+1)*masterFileLength-1 then
				if i%masterFileLength == 0 then
					masterFileData = masterFileData .. '\n'
				else
					masterFileData = masterFileData .. ','
				end
			end
		end
	end
	love.filesystem.write( 'ttdata/ttmf.dat', masterFileData )
end

function saveTimeTable(k)
	local ttFileData = ""
	for i=1, (numStops[k]+1)*timeTableFileLength do
		local currentBit = timeTableData[k][i-1]
		if currentBit == nil then
			textToPrint = i
		else
			ttFileData = ttFileData..currentBit
			if timeTableData[k][i]~=nil then
				if i%timeTableFileLength == 0 then
					ttFileData = ttFileData .. '\n'
				else
					ttFileData = ttFileData .. ','
				end
			end
		end
	end
	love.filesystem.write( 'ttdata/'..timeTableData[0][k*masterFileLength]..'.dat', ttFileData )
end

function  saveToFile()
	saveMasterFile()
	for i=1, numTimeTables do
		saveTimeTable(i)
	end
end