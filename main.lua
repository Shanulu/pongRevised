-- My third complete re-write of pong. 
require 'ball' --contains our ball class
require 'paddle' --contains our paddle class
require 'button' --contains our interface

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
	
	--Loading
	Button:load()
	Paddle:load()
end

function love.draw()
	if gameState == "title" then
		Button:draw()
	end
	
	if gameState == "live" then
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
		if #balls >= 5 then
			return
		else
			balls[#balls+1] = Ball:new()
		end
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
					love.quit()
				end
			else
			v.currentImage = v.upImage
			end
		end
	end
end

function love.quit()
end