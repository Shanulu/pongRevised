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
		self:flipHorizontal()
	end	
	
	--CHECK FOR COLLISION WITH PADDLES
	for i = 1, #paddles do
		if paddles[i] then
			if self:collide(paddles[i], dt) == 1 then
				self:checkDistance(paddles[i], dt)
				love.audio.play(self.sound)
				self:flipVertical()
				break
			elseif self:collide(paddles[i], dt) == 2 then
				self:checkDistance(paddles[i], dt)
				love.audio.play(self.sound)
				self:flipHorizontal()
				break
			end
		end
	end
	
	--CHECK FOR COLLISION WITH POWERUPS
	for i = 1, #blocks do
		if blocks[i] then
			if self:collide(blocks[i], dt) == 1 then
				blocks[i].duration = blocks[i].duration - dt
				self:flipVertical()
				break
			elseif self:collide(blocks[i], dt) == 2 then
				blocks[i].duration = blocks[i].duration - dt
				self:flipHorizontal()
				break
			end			
		end
	end
	self.x = self.x + dt * self.h
	self.y = self.y + dt * self.v
end

function Ball:draw()
	love.graphics.setColor(self.color)
	love.graphics.circle("fill", self.x, self.y, self.r, 100) 
end

function Ball:collide(rectangle, dt)
	--local vector = math.sqrt(self.h^2 + self.v^2)*dt  --this will always evaluate to positive o_O
	if self.v < 0 then
		--going up
		if self.y - self.r + self.v*dt >= rectangle.y
		and self.y - self.r + self.v*dt <= rectangle.y + rectangle.h
		and self.x - self.r + self.h*dt <= rectangle.x + rectangle.w
		and self.x + self.r + self.h*dt >= rectangle.x then
			return 1
		end
	end
	
	if self.v > 0 then
		--going down
		if self.y + self.r + self.v*dt >= rectangle.y
		and self.y + self.r + self.v*dt <= rectangle.y + rectangle.h
		and self.x - self.r + self.h*dt <= rectangle.x + rectangle.w
		and self.x + self.r + self.h*dt >= rectangle.x then
			return 1
		end
	end
	
	if self.h > 0 then
		--going right
		if self.x + self.r + self.h*dt >= rectangle.x
		and self.x + self.r + self.h*dt <= rectangle.x + rectangle.w
		and self.y - self.r + self.v*dt <= rectangle.y + rectangle.h
		and self.y + self.r + self.v*dt >= rectangle.y then
			return 2
		end
	end
	
	if self.h < 0 then
		--going left
		if self.x - self.r + self.h*dt >= rectangle.x
		and self.x - self.r + self.h*dt <= rectangle.x + rectangle.w
		and self.y - self.r + self.v*dt <= rectangle.y + rectangle.h
		and self.y + self.r + self.v*dt >= rectangle.y then
			return 2
		end
	end
			
	return 0
end

function Ball:delete()
	for i = 1, #balls do
		if balls[i] == self then
			balls[i] = deleted
		end
	end
	customSort(balls)
end

function Ball:flipVertical()
	if math.abs(self.v) == self.v then
		-- positive
		if self.v * 1.25 >= 450 then
			self.v = 450
			self.v = self.v * -1
		else
			self.v = self.v * -1.25
		end
	else
		--negative
		if self.v * 1.25 <= -450 then
			self.v = -450
			self.v = self.v * -1
		else
			self.v = self.v * -1.25
		end
	end
end

function Ball:flipHorizontal()
	if math.abs(self.h) == self.h then
		-- positive
		if self.h * 1.25 >= 225 then
			self.h = 225
			self.h = self.h * -1
		else
			self.h = self.h * -1.25
		end
	else
		--negative
		if self.h * 1.25 <= -225 then
			self.h = -225
			self.h = self.h * -1
		else
			self.h = self.h * -1.25
		end
	end
end

function Ball:checkDistance(paddle, dt)
	local section = paddle.w / 5
	local horizontal = self.h
	--    [_1_|_2_|_3_|_4_|_5_]
	--i need to check if the ball is close to the center, the further away the more we will alter the horizontal velocity
	if self.x >= paddle.x + 2*section and paddle.x <= paddle.x + paddle.w - 2*section then 
		horizontal = self.h * 1.15 --this covers 3
	elseif self.x >= paddle.x + section and paddle.x <= paddle.x + paddle.w - section then 
		horizontal = self.h * 1.30 --this covers 2-4
	elseif self.x >= paddle.x and self.x <= paddle.x + paddle.w then 
		horizontal = self.h * 1.45 --this covers 1-5, the whole paddle
	end
	
	self.h = horizontal
	
	if math.abs(self.h) == self.h then
		if math.abs(self.h) >= 225 then
			self.h = 225
		else
			self.h = -225
		end
	end
end

	