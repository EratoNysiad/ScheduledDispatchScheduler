function drawWarning()
	local menuX = math.floor(windowWidth/2)-100
	local menuY = math.floor(windowHeight/2)-50
	love.graphics.setColor( 252/255,100/255,88/255)
	love.graphics.rectangle( "fill", menuX, menuY, 200, 100 )
	love.graphics.setColor( 224/255,0,0)
	love.graphics.rectangle( "fill", menuX+1, menuY+1, 13, 14 )
	love.graphics.rectangle( "fill", menuX+17, menuY+2, 181, 12 )
	love.graphics.rectangle( "fill", menuX+1, menuY+17, 199, 83 )
	love.graphics.setColor( 160/255,0,0)
	love.graphics.line( menuX, menuY+15, menuX+200,menuY+15, menuX+200,menuY)
	love.graphics.line( menuX+15, menuY+15, menuX+15,menuY)
	love.graphics.line( menuX+17, menuY+15, menuX+17,menuY+1, menuX+200,menuY+1)
	love.graphics.line( menuX, menuY+100, menuX+200,menuY+100, menuX+200,menuY)
	love.graphics.print("x", menuX+4, menuY+1)
	--offset +1,1 and add white text
	love.graphics.print("Are you sure?", menuX+51, menuY+2)
	local warningText = ''
	if warningID == 1 then -- Reload
		warningText = "Reloading will undo all changes made since the last save!\nTo cancel, press escape.\nTo confirm, press enter."
	elseif warningID == 2 then -- Delete station
		warningText = "You're about to delete a station. This cannot be undone!\nTo cancel, press escape.\nTo confirm, press enter."
	elseif warningID == 3 then -- Delete timetable
		warningText = "You're about to delete a timetable. This cannot be undone!\nTo cancel, press escape.\nTo confirm, press enter."
	end
	love.graphics.setFont(font)
	love.graphics.printf(warningText, menuX+14, menuY+26, 175, 'center')
	love.graphics.setColor( 1,1,1)
	love.graphics.setFont(fontWhite)
	love.graphics.print("Are you sure?", menuX+50, menuY+1)
	love.graphics.printf(warningText, menuX+13, menuY+25, 175, 'center')
	love.graphics.setFont(font)
end

--Run whenever you want to display a warning
function parseWarnings()
	drawWarning()
	--Escape to cancel, enter to verify
	if love.keyboard.isDown( 'escape' ) then
		warningID = 0
	elseif love.keyboard.isDown( 'return' ) or love.keyboard.isDown( 'kpenter' ) then
		warningVerified = true
	end
	--Do the thing
	if warningVerified then
		if warningID == 1 then -- Reload
			reloadData()
		elseif warningID == 2 then -- Delete station
			removeStation()
		elseif warningID == 3 then -- Delete timetable
			removeTimeTable()
		end
		warningVerified = false
		warningID = 0
	end
end