--[[ blocks.lua    Created By: Michael Groll
creates random blocks in my Pong game.

functions: 

-------------------------------------------]]

blocks = {}

Block = {}
Block.__index = Block

function Block:new() --of the window
	local block = setmetatable( {}, Block )
	
	block.x = math.random(50, width - 50)
	block.y = math.random(50, width - 50)
	block.w = math.random(10, 40)
	block.h = math.random(10, 40)
	block.color = {255*math.random(), 255*math.random(), 255*math.random()}
	block.duration = math.random(30, 150)
	block.order = math.random()
	
	return block
end

function Block:delete()
	for i = 1, #blocks do
		if blocks[i] == self then
			blocks[i] = deleted
		end
	end
	customSort(blocks)
end

function Block:draw()
	love.graphics.setColor(self.color)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function Block:update(dt)
	for i, v in ipairs(blocks) do
		v.duration = v.duration - dt
		if v.duration <= 0 then
			self:delete()
		end
	end
end
