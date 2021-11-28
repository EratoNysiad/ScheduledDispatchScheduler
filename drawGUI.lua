function drawLeftMenu()
	love.graphics.setColor( 168/255,168/255,168/255)
	love.graphics.rectangle( "fill", 0, 0, 178, windowHeight )
	love.graphics.setColor( 131/255,131/255,131/255)
	love.graphics.rectangle( "fill", 1, 1, 87, 21 )
	love.graphics.rectangle( "fill", 90, 1, 87, 21 )
	love.graphics.setColor( 100/255,100/255,100/255)
	love.graphics.line( 0, 22, 178, 22, 178,0)
	love.graphics.line( 89, 22, 89,0)
	
	
	
	
	
	
	
	
	
	love.graphics.setColor( 1,1,1)
	love.graphics.draw( spriteSaveButton, 3, 3)
	love.graphics.setColor( 0,0,0)
	love.graphics.print("Save", 24, 5)
	love.graphics.print("Reload", 93, 5)
	
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
	love.graphics.print("<", menuOriginX+355, menuOriginY+1)
	love.graphics.print("<", menuOriginX+355, menuOriginY+15)
	love.graphics.print(">", menuOriginX+369, menuOriginY+1)
	love.graphics.print(">", menuOriginX+369, menuOriginY+15)
end