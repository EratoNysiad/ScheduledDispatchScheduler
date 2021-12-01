function love.textinput(t)
	local allowEdit = true
	if t == '-' and editData[1] ~= 0 and editData[2]%timeTableFileLength == 1 then--set distance negative
		timeTableData[editData[1]][editData[2]] = - timeTableData[editData[1]][editData[2]]
	else
		if tonumber(t) == nil then --not a number
			if editData[1] == 0 and editData[2]%masterFileLength >= 3 then
				allowEdit = false
			elseif editData[1] ~= 0 and editData[2]%timeTableFileLength >= 1 then
				allowEdit = false
			end
		end
		if allowEdit then
			if timeTableData[editData[1]][editData[2]] == 0 or timeTableData[editData[1]][editData[2]] == tostring(0) then
				timeTableData[editData[1]][editData[2]] = t
			else
				timeTableData[editData[1]][editData[2]] = timeTableData[editData[1]][editData[2]] .. t
			end
		end
	end
end

function backspaceHandler()
	backspacePressed = love.keyboard.isDown("backspace")
	backspaceTimer = love.timer.getTime()
	if backspacePressed then
		local currentLength = tostring(timeTableData[editData[1]][editData[2]]):len()
		local firstChar = tostring(timeTableData[editData[1]][editData[2]]):sub(1,1)
		if currentLength == 1 or (currentLength == 2 and firstChar == '-') then
			if not backspaceStillPressed or backspaceTimer - backspaceStartTime > backspaceCounter*0.12 then
				timeTableData[editData[1]][editData[2]] = 0
			end
		else
			--Upon first press, just use it once
			if not backspaceStillPressed then
				timeTableData[editData[1]][editData[2]] = tostring(timeTableData[editData[1]][editData[2]]):sub(1,-2)
				backspaceStartTime = love.timer.getTime()
				backspaceStillPressed = true
				backspaceCounter = 5
			elseif backspaceTimer - backspaceStartTime > backspaceCounter*0.12 then
				timeTableData[editData[1]][editData[2]] = timeTableData[editData[1]][editData[2]]:sub(1,-2)
				backspaceCounter = backspaceCounter + 1
			end
		end
    else
		backspaceCounter = 0
		backspaceStartTime = backspaceTimer
		backspaceStillPressed = false
	end
end