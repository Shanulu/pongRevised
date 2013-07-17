--[[ball.lua    Created by: Michael Groll
A ball class for Pong

functions: new, draw, delete, update, collide

--]]
--a table to store our balls
balls = {}
--set up our ball class
Ball = {}
Ball.__index = Ball

function Ball:new(x, y, r, h, v)
	local ball = setmetatable( {}, Ball )
	--variables
	ball.x = x or width/2
	ball.y = y or height/2
	ball.r = r or 10 --radius
	ball.h = h or math.random(-200, 200) --horizontal velocity
	ball.v = v or math.random(-200, 200) --vertical velocity
	ball.color = { 255*math.random(), 255*math.random(), 255*math.random() }
	ball.steps = nil --used in AI calculations
	ball.order = math.random() --needed in our sort function
	ball.sound = love.audio.newSource("Sounds/blop.ogg", "static")
	
	return ball
end

function Ball:update(dt)
	--Check our top edge
	if self.y <= 0 then
		--AWARD SCORE TO BOTTOM
		Paddle:score(2)
		--MODIFY PADDLE WIDTH
		self:delete()
	end
	--check our bottom edge
	if self.y >= height then
		--AWARD SCORE TO TOP
		Paddle:score(1)
		--MODIFY PADDLE WIDTH
		self:delete()
	end
	--check our sides
	if self.x <= 0 + self.r or self.x >= width - self.r then
		love.audio.play(self.sound)
		if math.abs(self.h) >= 250 then     --check to see if its over our max speed of 250
			if math.abs(self.h) == self.h then   --is it positive?
				self.h = 250
				self.h = self.h * -1
			else
				self.h = -250
				self.h = self.h * -1
			end
		else
			self.h = self.h * -1.25
		end		
	end	
	
	--check for collision with paddles
	for i = 1, #paddles do
		if paddles[i] then
			if self:collide(paddles[i]) then
				if math.abs(self.v) >= 450 then					
					self.v = self.v * -1
				else
					self.v = self.v * -1.25
				end					
				love.audio.play(self.sound)
			end
		end
	end
	
	--CHECK FOR COLLISION WITH POWERUPS--]]
	self.x = self.x + dt * self.h
	self.y = self.y + dt * self.v
end

function Ball:draw()
	love.graphics.setColor(self.color)
	love.graphics.circle("fill", self.x, self.y, self.r, 100) 
end

function Ball:collide(rectangle)
	if self.v > 0 then
		--going down
		if self.x + self.r >= rectangle.x --right side of ball to left side of rectangle
		and self.x - self.r <= rectangle.x + rectangle.w --left side of ball to right side of rectangle
		and self.y + self.r >= rectangle.y  --bottom of ball to top of rectangle
		and self.y + self.r <= rectangle.y + rectangle.h then 
			return true
		end
	end
	
	if self.v < 0 then
		--going up
		if self.x + self.r >= rectangle.x --right side of ball to left side of rectangle
		and self.x - self.r <= rectangle.x + rectangle.w --left side of ball to right side of rectangle
		and self.y - self.r <= rectangle.y + rectangle.h  --top of ball to bottom of rectangle
		and self.y - self.r >= rectangle.y then 
			return true
		end
	end
	return false
end

function Ball:delete()
	for i = 1, #balls do
		if balls[i] == self then
			balls[i] = deleted
		end
	end
	customSort(balls)
end
	