-- My third complete re-write of pong. 
require 'ball' --contains our ball class
require 'paddle' --contains our paddle class
--require 'interface' --contains our interface

--this function here will delete any entries that we have marked by putting the deleted tables at the end
--using the sort via order, in which deleted has math.huge assigned.
function customSort(t) --takes a table, must have a .order variable
	-- sort by the order, deleted will always be math.huge and be at the end!
	table.sort(t, function(a,b) return a.order < b.order end)
	local last = #t
	while t[last] == deleted do
		t[last] = nil
		last = last - 1
	end
end


function love.load()
	love.graphics.setBackgroundColor(0, 0, 0) --Black
	--[[-- VARIABLES --------]]
	deleted = { order = math.huge } --a table used to for comparing later
	height = love.graphics.getHeight()
	width = love.graphics.getWidth()
	gameState = "title"
	
	--START BUTTON 		
	startButtonDown = love.graphics.newImage("Art/start_dn.png")
	startButtonUp = love.graphics.newImage("Art/start_up.png")
	startButtonWidth = startButtonUp:getWidth()
	startButtonHeight = startButtonUp:getHeight()
	startButtonX = width/2 - startButtonWidth/2
	startButtonY = height/2 - startButtonHeight*1.5
	startButtonPressed = false
	startButton = startButtonUp

	
				
	
	--Loading
	Paddle:load()
end

function love.draw()
	if gameState == "title" then
		love.graphics.draw(startButton, startButtonX, startButtonY)
		if startButtonPressed then
			gameState = "live"
		end
	end
	
	if gameState == "live" then
		--draw the balls
		for i = 1, #balls do
			if balls[i].draw then
				balls[i]:draw()
			end
		end
		--draw the paddles
		for i = 1, #paddles do
			if paddles[i].draw then
				paddles[i]:draw()
			end
		end
	end
end

function love.update(dt)
	if gameState == "live" then
		for i = 1, #balls do
			if balls[i] then
				balls[i]:update(dt)
			end
		end
	
		for i = 1, #paddles do
			if paddles[i] then
				paddles[i]:update(dt)
			end
		end
	end
end

function love.keypressed(key)
	if key == "w"  then
		balls[#balls+1] = Ball:new()
	end
	
end

function love.mousepressed(x, y, button)
	if gameState == "title" and button == "l" then
		if x > startButtonX and x < startButtonX + startButtonWidth and
		y < startButtonY + startButtonHeight and y > startButtonY then
				startButton = startButtonDown
		end	
	end
end
	
function love.mousereleased(x, y, button)
	if gameState == "title" and button == "l" then
		if x > startButtonX and
		x < startButtonX + startButtonWidth and
		y < startButtonY + startButtonHeight and
		y > startButtonY then
			gameState = "live"
		else
			startButton = startButtonUp
		end
	end
end


