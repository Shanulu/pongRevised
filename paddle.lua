--[[paddle.lua   Created by: Michael Groll
paddle class for pong

functions: update, draw, new, findTarget, score, load

-------------------------------------------]]

paddles = {}
Paddle = {}
Paddle.__index = Paddle

function Paddle:new(x, y, w, h, s)
	local paddle = setmetatable( {}, Paddle )
	
	paddle.x = x
	paddle.y = y
	paddle.w = w --width
	paddle.h = h --height
	paddle.s = s --speed, max
	paddle.score = 0
	
	return paddle
end

function Paddle:update(dt)
	paddles[2]:findTarget(dt)
	if love.keyboard.isDown("a") and paddles[1].x > 0 then
		paddles[1].x = paddles[1].x - dt * paddles[1].s

	end
	
	if love.keyboard.isDown("d") and paddles[1].x < width then
		paddles[1].x = paddles[1].x + dt * paddles[1].s
	end
	
	if self.x <= 0 then
		self.x = 0
	end
	
	if self.x >= width - self.w then
		self.x = width - self.w
	end
end

function Paddle:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
	
	love.graphics.print("Score: " .. paddles[1].score, 20, 25)
	love.graphics.print("Score: " .. paddles[2].score, width - 75, height - 40)
end

function Paddle:score(n)
	--go through our paddles tables
	for i, v in ipairs(paddles) do
		--find if it equals the paddle we want, 1/top or 2/bottom
		if i == n then
			v.w = v.w + 3
			v.score = v.score + 1
			if v.w >= width/6 then
				v.w = width/6
			end
		--if its the other paddle make it smaller!
		elseif i ~= n then
			v.w = v.w - 3
			if v.w <= 18 then
				v.w = 18
			end
		end
	end
end
	
function Paddle:findTarget(dt)
	local potentialTarget
	local minSteps = math.huge
	
	for i, b in ipairs(balls) do
		--iterate through our ballList
		if b.v > 0 then
			--set steps = to the deltaY/velocity to estimate time to bottom
			local steps = (height - b.y)/b.v
			--if the steps are less than the previous than it becomes our new target
			if steps < minSteps then
				minSteps = steps
				potentialTarget = b
			end
		end
	end
	
	local currentTarget
	if potentialTarget then
		--makes sure we have a potential target, we then set it to its x value
		currentTarget = potentialTarget.x
	else
		--if not we just aim at the center of the screen
		currentTarget = width/2
	end
	--set our deltaX
	deltaX = currentTarget - self.x - self.w/2
	--we now have an X value that is either to our left or right
	--we need to move to it at max speed or slower.
	if deltaX > 0 then
		self.x = self.x + self.s * dt
	end
	
	if deltaX < 0 then
		self.x = self.x - self.s * dt
	end
end

function Paddle:load()
	--[[PADDLE SETUP -----]]
	--x, y, width, height, speed(max)
	paddles[#paddles+1] = Paddle:new(width/2 - 55, 10, 55, 10, 200)
	paddles[#paddles+1] = Paddle:new(width/2 - 55, height - 20, 55, 10, 113) --add functionality to set AI speed, 113 = normal, 150 = impossible
end