function love.load()
	-- initialise game
	love.window.setMode(720,480, {resizable=true, minwidth=558, minheight=300}) --GBA*3 screensize by default
	love.window.setTitle( "ScheduledDispatchScheduler" ) --set name
	--Set font
	font = love.graphics.newImageFont("font.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:;<=>?_!\"#$%&'()*+,-./")
	love.graphics.setFont(font)
	--Set colours
	lineColour = {}
	lineColour[1] = {55/255,119/255,187/255}
	lineColour[2] = {119/255,163/255,135/255}
	lineColour[3] = {220/255,131/255,143/255}
	lineColour[4] = {252/255,212/255,0}
	lineColour[5] = {252/255,51/255,51/255}
	lineColour[6] = {115/255,171/255,191/255}
	lineColour[7] = {107/255,175/255,63/255}
	lineColour[8] = {127/255,147/255,91/255}
	lineColour[9] = {87/255,167/255,240/255}
	lineColour[10] = {212/255,147/255,111/255}
	lineColour[11] = {131/255,131/255,163/255}
	lineColour[12] = {139/255,103/255,252/255}
	lineColour[13] = {252/255,252/255,99/255}
	lineColour[14] = {183/255,159/255,119/255}
	lineColour[15] = {147/255,147/255,147/255}
	lineColour[16] = {216/255,216/255,216/255}
	lineColourNames = {"Dark Blue", "Pale Green", "Pink", "Yellow", "Red", "Light Blue", "Green", "Dark Green", "Blue", "Cream", "Mauve", "Purple", "Orange", "Brown", "Grey", "White"}
	
	spriteSaveButton = love.graphics.newImage("saveIcon.png")
	spriteLoadButton = love.graphics.newImage("loadIcon.png")
	
	textToPrint= ""
	
	love.graphics.setLineWidth( 1 )
	love.graphics.setLineStyle("rough")
	
	backspaceStillPressed = false
	startTime = love.timer.getTime()
	backspaceStartTime = 0
	
	dir = love.filesystem.getAppdataDirectory()
	maxX = 6
	timeTableData = {}
	numStops = {}
	editData = {0,0}
	
	currentTimeTable=2
	timeTableFileLength = 6
	masterFileLength = 6
	reloadData()
	
	timeLimits = {5,7}
end