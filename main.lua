----------------------------------------------------------------------------
-- project:			Pong Revised
-- file: 			main.lua
-- author:			Michael Groll
-- version:			0.8.0
-- gitHub:			https://github.com/Shanulu/pongRevised
--
-- description:     Love2D's base file, contains most of the initializing,
--					drawing, and updating of the Pong components. Also
--					contains some of the keyboard inputs as well as my
--					customSort function.
----------------------------------------------------------------------------
require 'ball' --contains our ball class and collision deteciton
require 'paddle' --contains our paddle class
require 'interface' --contains our screen and buttons
require 'blocks' --contains our blocks

function love.load()
	love.graphics.setBackgroundColor(0, 0, 0) --Black
	
	-- variables
	deleted = { order = math.huge } --a table used to for comparing later
	height = love.graphics.getHeight() --commonly used
	width = love.graphics.getWidth() 
	gameState = "title"		--title, pregame, options, live, pause, endgame
	difficulty = 100  --ai max speed movement
	preGame = 5 	--timer for pregame
	
	--Sound and Music
	bgm1 = love.audio.newSource("Sounds/bgm1.ogg")
	bgm2 = love.audio.newSource("Sounds/bgm2.mp3")
	bgm3 = love.audio.newSource("Sounds/bgm3.mp3")
	bgm4 = love.audio.newSource("Sounds/bgm4.mp3")
	bgm5 = love.audio.newSource("Sounds/bgm5.mp3")
	music = bgm1
	music:setLooping(true)
	love.audio.play(music) 


	--external loads
	Button:load()
	--we call Paddle:load() in interface.lua, so we can set difficulty
end

function love.draw()
	--live or paused we still want to draw.
	if gameState == "live" or gameState == "paused" then
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
			love.graphics.print("Game Starting in " .. math.floor(preGame), 130, height/2 + 30)
		end	
		--if we are paused show it!
		if gameState == "paused" then
			love.graphics.setFont(preGameFont)
			love.graphics.print("Paused. Any key to resume.", 80, height/2 + 30)
		end
	--if we aren't live then we are something else!
	elseif gameState ~= "live" then
		Screen:draw()
	end
end

function love.update(dt)
	--if we are live, update, if we aren't, we wont do anything!
	if gameState == "live" and preGame <= 0 then
		--spawn random blocks
		if math.random(1, 100) <= 2 then
			if #blocks < 3 then
				blocks[#blocks+1] = Block:new()
			end
		end
		--update balls
		for i = 1, #balls do
			if balls[i] then
				balls[i]:update(dt)
			end
		end
		--update paddles
		for i = 1, #paddles do
			if paddles[i] then
				paddles[i]:update(dt)
			end
		end
		--update blocks
		for i = 1, #blocks do
			if blocks[i] then
				blocks[i]:update(dt)
			end
		end
		--evaulate win condition
		if paddles[1].score == 15 then
			--player wins
			gameState = "win"			
		elseif paddles[2].score == 15 then
			--computer wins
			gameState = "lose"
		end
	elseif gameState == "live" and preGame > 0 then
		preGame = preGame - dt
		if preGame <= 0 then preGame = 0 end
	end
end

function love.keypressed(key)
	--escape in all gameStates
	if key == "escape" then
		if gameState == "options" then
			gameState = "title"
		elseif gameState == "title" then
			love.event.push('quit')
		elseif gameState == "help" then
			gameState = "title"
		elseif gameState == "paused" then
			gameState = "live"
		else  --every other gameState: live, win, loss 
			love.event.push('quit')
		end			
	end
	--p in the live gameState only
	if key == "p" and preGame <= 0 then
		if gameState == "paused" then 
			gameState = "live"
		else
			gameState = "paused"
		end
	end
	
	if key ~= "p" and gameState == "paused" then
		gameState = "live"
	end
end

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