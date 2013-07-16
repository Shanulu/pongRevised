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
	
	--[[PADDLE SETUP -----]]
	--x, y, width, height, speed(max)
	paddles[#paddles+1] = Paddle:new(width/2 - 55, 10, 55, 10, 200)
	paddles[#paddles+1] = Paddle:new(width/2 - 55, height - 20, 55, 10, 200)
	
	--[[SOUNDS SETUP ----]]
	ballSound1 = love.audio.newSource("Sounds/blop.ogg", "static")
	
	
end

function love.draw()
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
			

function love.update(dt)
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

function love.keypressed(key)
	if key == "w"  then
		balls[#balls+1] = Ball:new()
	end
	
end

