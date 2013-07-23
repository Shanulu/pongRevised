--[[button.lua    Created by: Michael Groll
button for pong

functions: load, new, draw
--------------------------------------------]]

buttons = {}

Button = {}
Button.__index = Button

function Button:new(name, image, image2)
	local button = setmetatable({}, Button)
	
	button.name = name
	button.currentImage = image
	button.upImage = image
	button.downImage = nil or image2
	button.x = 0 
	button.y = 0
	button.w = nil
	button.h = nil
	button.pressed = false
	
	return button
end

function Button:load()
	--start
	buttons[#buttons+1] = Button:new("start", love.graphics.newImage("Art/start_up.png"), love.graphics.newImage("Art/start_dn.png"))
	buttons[1].w = buttons[1].currentImage:getWidth()
	buttons[1].h = buttons[1].currentImage:getHeight()
	buttons[1].x = width/2 - 100
	buttons[1].y = height/2 - 2*buttons[1].h - 5
	--options
	buttons[#buttons+1] = Button:new("options", love.graphics.newImage("Art/options_up.png"), love.graphics.newImage("Art/options_dn.png"))
	buttons[2].w = buttons[2].currentImage:getWidth()
	buttons[2].h = buttons[2].currentImage:getHeight()
	buttons[2].x = width/2 - 100
	buttons[2].y = buttons[1].y + buttons[1].h + 5
	--exit
	buttons[#buttons+1] = Button:new("exit", love.graphics.newImage("Art/exit_up.png"), love.graphics.newImage("Art/exit_dn.png"))
	buttons[3].w = buttons[3].currentImage:getWidth()
	buttons[3].h = buttons[3].currentImage:getHeight()	
	buttons[3].x = width/2  - 100
	buttons[3].y = buttons[2].y + buttons[2].h + 5
	--help
	buttons[#buttons+1] = Button:new("help", love.graphics.newImage("Art/help_up.png"), love.graphics.newImage("Art/help_dn.png"))
	buttons[4].w = buttons[4].currentImage:getWidth()
	buttons[4].h = buttons[4].currentImage:getHeight()
	buttons[4].x = width/2 - 100
	buttons[4].y = buttons[3].y + buttons[3].h + 5
	

end

function Button:draw()
	for i, v in ipairs(buttons) do
		if v then
			love.graphics.draw(v.currentImage, v.x, v.y)
		end
	end
end
