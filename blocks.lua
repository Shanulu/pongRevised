--[[ blocks.lua    Created By: Michael Groll
creates random blocks in my Pong game.

functions: 

-------------------------------------------]]

blocks = {}

Block = {}
Block.__index = Block

function Block:new() 
	local block = setmetatable( {}, Block )
	
	block.x = math.random(90, width - 90)
	block.y = math.random(25, width - 25)
	block.w = math.random(10, 40)
	block.h = math.random(10, 40)
	block.color = {0, 255, 0}
	block.durationOrg = math.random(10, 10)
	block.duration = block.durationOrg
	block.order = math.random()
	
	return block
end

function Block:delete()
	for i = 1, #blocks do
		if blocks[i] == self then
			if #balls < 5 then
				balls[#balls+1] = Ball:new(self.x + self.w/2, self.y + self.h/2)
			end
			blocks[i] = deleted
		end
	end
	customSort(blocks)
end

function Block:draw()
	if self.duration <= .1 * self.durationOrg then self.color = {255, 0, 0}
	elseif self.duration <= .2 * self.durationOrg then self.color = {227, 31, 0}
	elseif self.duration <= .3 * self.durationOrg then	self.color = {199, 59, 0}
	elseif self.duration <= .4 * self.durationOrg then	self.color = {171, 87, 0}
	elseif self.duration <= .5 * self.durationOrg then	self.color = {143, 115, 0}
	elseif self.duration <= .6 * self.durationOrg then	self.color = {115, 143, 0}
	elseif self.duration <= .7 * self.durationOrg then	self.color = {87, 171, 0}	
	elseif self.duration <= .8 * self.durationOrg then self.color = {59, 199, 0}
	elseif self.duration <= .9 * self.durationOrg then self.color = {31, 227, 0}
	elseif self.duration <= self.durationOrg then self.color = {0, 255, 0}
	end
	love.graphics.setColor(self.color)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function Block:update(dt)
	self.duration = self.duration - dt
	if self.duration <= 0 then
		self:delete()
	end
end
