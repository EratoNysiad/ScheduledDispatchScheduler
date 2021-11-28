function love.textinput(t)
    textToPrint = textToPrint .. t
end

function backspaceHandler()
	backspacePressed = love.keyboard.isDown("backspace")
	backspaceTimer = love.timer.getTime()
	if backspacePressed then
		--Upon first press, just use it once
		if not backspaceStillPressed then
			textToPrint = textToPrint:sub(1,-2)
			backspaceStartTime = love.timer.getTime()
			backspaceStillPressed = true
			backspaceCounter = 5
		elseif backspaceTimer - backspaceStartTime > backspaceCounter*0.12 then
			textToPrint = textToPrint:sub(1,-2)
			backspaceCounter = backspaceCounter + 1
		end
    else
		backspaceCounter = 0
		backspaceStartTime = backspaceTimer
		backspaceStillPressed = false
	end

	windowWidth, windowHeight = love.window.getMode()

end