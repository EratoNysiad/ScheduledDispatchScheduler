function love.textinput(t)
	local allowEdit = true
	if tonumber(t) == nil then --not a number
		if editData[1] == 0 and editData[2]%6 >= 3 then
			allowEdit = false
		elseif editData[1] ~= 0 and editData[2]%4 >= 3 then
			allowEdit = false
		end
	end
	if allowEdit then
		if timeTableData[editData[1]][editData[2]] == 0 then
			timeTableData[editData[1]][editData[2]] = t
		else
			timeTableData[editData[1]][editData[2]] = timeTableData[editData[1]][editData[2]] .. t
		end
	end
end

function backspaceHandler()
	backspacePressed = love.keyboard.isDown("backspace")
	backspaceTimer = love.timer.getTime()
	--textToPrint = tostring(tostring(timeTableData[editData[1]][editData[2]]):len())
	if backspacePressed then
		local currentLength = tostring(timeTableData[editData[1]][editData[2]]):len()
		if currentLength == 1 then
			timeTableData[editData[1]][editData[2]] = 0
		else
			--Upon first press, just use it once
			if not backspaceStillPressed then
				timeTableData[editData[1]][editData[2]] = timeTableData[editData[1]][editData[2]]:sub(1,-2)
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
	windowWidth, windowHeight = love.window.getMode()

end