function love.load()
	-- initialise game
	love.window.setMode(720,480, {resizable=true, minwidth=558, minheight=290}) --GBA*3 screensize by default
	windowWidth, windowHeight = love.window.getMode()
	love.window.setTitle( "ScheduledDispatchScheduler 1.6" ) --set name
	--Set font
	font = love.graphics.newImageFont("font.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:;<=>?_!\"#$%&'()*+,-./")
	fontWhite = love.graphics.newImageFont("fontWhite.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:;<=>?_!\"#$%&'()*+,-./")
	love.graphics.setFont(font)
	--Set colours
	lineColour = {}
	---Red
	lineColour[1] = {255/255,100/255,100/255}
	lineColour[2] = {255/255,75/255,75/255}
	lineColour[3] = {255/255,50/255,50/255}
	lineColour[4] = {235/255,25/255,25/255}
	lineColour[5] = {200/255,12/255,12/255}
	lineColour[6] = {165/255,0/255,0/255}
	---Orange
	lineColour[7] = {255/255,185/255,90/255}
	lineColour[8] = {255/255,170/255,50/255}
	lineColour[9] = {255/255,155/255,0/255}
	lineColour[10] = {235/255,140/255,0/255}
	lineColour[11] = {210/255,125/255,0/255}
	lineColour[12] = {190/255,110/255,0/255}
	---Yellow
	lineColour[13] = {255/255,225/255,110/255}
	lineColour[14] = {255/255,220/255,65/255}
	lineColour[15] = {255/255,210/255,0/255}
	lineColour[16] = {230/255,190/255,0/255}
	lineColour[17] = {210/255,175/255,0/255}
	lineColour[18] = {200/255,160/255,0/255}
	---Green
	lineColour[19] = {140/255,205/255,100/255}
	lineColour[20] = {125/255,190/255,80/255}
	lineColour[21] = {110/255,175/255,60/255}
	lineColour[22] = {90/255,155/255,40/255}
	lineColour[23] = {75/255,140/255,30/255}
	lineColour[24] = {60/255,125/255,20/255}
	---Teal
	lineColour[25] = {150/255,185/255,200/255}
	lineColour[26] = {115/255,170/255,190/255}
	lineColour[27] = {100/255,155/255,175/255}
	lineColour[28] = {85/255,140/255,160/255}
	lineColour[29] = {70/255,125/255,140/255}
	lineColour[30] = {55/255,110/255,130/255}
	---Blue
	lineColour[31] = {85/255,150/255,215/255}
	lineColour[32] = {70/255,135/255,200/255}
	lineColour[33] = {55/255,120/255,190/255}
	lineColour[34] = {50/255,105/255,165/255}
	lineColour[35] = {45/255,95/255,150/255}
	lineColour[36] = {40/255,85/255,135/255}
	---Purple
	lineColour[37] = {185/255,165/255,255/255}
	lineColour[38] = {160/255,135/255,255/255}
	lineColour[39] = {140/255,100/255,255/255}
	lineColour[40] = {120/255,90/255,220/255}
	lineColour[41] = {110/255,80/255,200/255}
	lineColour[42] = {90/255,70/255,160/255}
	---Grey
	lineColour[43] = {250/255,250/255,250/255}
	lineColour[44] = {205/255,205/255,205/255}
	lineColour[45] = {165/255,165/255,165/255}
	lineColour[46] = {135/255,135/255,135/255}
	lineColour[47] = {110/255,110/255,110/255}
	lineColour[48] = {90/255,90/255,90/255}
	lineColourNames = {"Red 1", "Red 2", "Red 3", "Red 4", "Red 5", "Red 6", "Orange 1", "Orange 2", "Orange 3", "Orange 4", "Orange 5", "Orange 6", "Yellow 1", "Yellow 2", "Yellow 3", "Yellow 4", "Yellow 5", "Yellow 6", "Green 1", "Green 2", "Green 3", "Green 4", "Green 5", "Green 6", "Teal 1", "Teal 2", "Teal 3", "Teal 4", "Teal 5", "Teal 6", "Blue 1", "Blue 2", "Blue 3", "Blue 4", "Blue 5", "Blue 6", "Purple 1", "Purple 2", "Purple 3", "Purple 4", "Purple 5", "Purple 6", "Grey 1", "Grey 2", "Grey 3", "Grey 4", "Grey 5", "Grey 6"}
	
	spriteSaveButton = love.graphics.newImage("saveIcon.png")
	spriteLoadButton = love.graphics.newImage("loadIcon.png")
	spriteWarnIcon = love.graphics.newImage("warningIcon.png")
	spriteGrey1 = love.graphics.newImage("greyFirst.png")
	spriteGreyR = love.graphics.newImage("greyReverse.png")
	spriteScrollBar = love.graphics.newImage("scrollBar.png")
	
	textToPrint= ""
	
	love.graphics.setLineWidth( 1 )
	love.graphics.setLineStyle("rough")
	specialButtonHeld = false
	backspaceStillPressed = false
	addremoveStillPressed = false
	startTime = love.timer.getTime()
	backspaceStartTime = 0
	
	dir = love.filesystem.getAppdataDirectory()
	maxX = 6
	timeTableData = {}
	numStops = {}
	
	warningID = 0
	warningVerified = false
	currentTimeTable = 1
	currentStation = 1
	timeTableFileLength = 6
	masterFileLength = 7
	reloadData()
	
	tablePos = 0
	timeLimits = {12,15}
	spaceLimits = {0,0}
end