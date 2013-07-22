-- My third complete re-write of pong. 
require 'ball' --contains our ball class
require 'paddle' --contains our paddle class
require 'button' --contains our buttons
require 'blocks'
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
	preGameFont = love.graphics.newFont("Fonts/Digital_tech.otf", 40)
	scoreFont = love.graphics.newFont("Fonts/Digital_tech.otf", 14)
	--[[-- VARIABLES --------]]
	deleted = { order = math.huge } --a table used to for comparing later
	height = love.graphics.getHeight()
	width = love.graphics.getWidth()
	gameState = "title"		--title, pregame, options, live, pause, endgame
	--BGM
	BGM = love.audio.newSource("Sounds/bgm.ogg")
	BGM:setLooping(true)
	love.audio.play(BGM)
	--Loading
	Button:load()
	Paddle:load()
	--timer for pregame
	preGame = 5
end

function love.draw()
	--[[ TITLE SCREEN ---------------------------------------]]
	if gameState == "title" then
		Button:draw()
	--[[ LIVE GAME ------------------------------------------]]	
	elseif gameState == "live" then
		--draw the balls
		if #balls == 0 then
			balls[#balls+1] = Ball:new()
		end
		
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
		--draw the blocks
		for i = 1, #blocks do
			if blocks[i].draw then
				blocks[i]:draw()
			end
		end
		--draw Pregame counter if necessary
		if preGame > 0 then
			love.graphics.setColor( 255, 255, 0)
			love.graphics.setFont(preGameFont)
			love.graphics.print("Game Starting in - " .. preGame, 100, height/2)
		end	
	--[[ OPTIONS SCREEN -----------------------------------]]
	elseif gameState == "options" then
		--draw options screen
		love.graphics.clear()
	end
end

function love.update(dt)
	if gameState == "live" and preGame <= 0 then
		if math.random(1, 100) <= 2 then
			if #blocks < 3 then
				blocks[#blocks+1] = Block:new()
			end
		end
		
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
		
		for i = 1, #blocks do
			if blocks[i] then
				blocks[i]:update(dt)
			end
		end
	elseif gameState == "live" and preGame > 0 then
		preGame = preGame - dt
		if preGame <= 0 then preGame = 0 end
	end
end

function love.keypressed(key)
	if key == "escape" and gameState == "options" then
		gameState = "title"
	elseif key == "escape" and gameState == "title" then
		love.event.push('quit')
	end	
end

function love.mousepressed(x, y, button)
	if gameState == "title" and button == "l" then
		for i, v in ipairs(buttons) do
			if x > v.x and x < v.x + v.w and y < v.y + v.h and y > v.y then
				v.currentImage = v.downImage
			else
				v.currentImage = v.upImage
			end
		end	
	end
end
	
function love.mousereleased(x, y, button)
	if gameState == "title" and button == "l" then
		for i, v in ipairs(buttons) do
			if x > v.x and x < v.x + v.w and y < v.y + v.h and y > v.y then
				if v.name == "start" then
					gameState = "live"
				elseif v.name == "exit" then
					love.event.push('quit')
				elseif v.name == "options" then
					gameState = "options"
					v.currentImage = v.upImage --return the button to normal so when we return...
				end
			else
			v.currentImage = v.upImage
			end
		end
	end
end

function love.quit()
end