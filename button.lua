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
	button.state = nil
	
	return button
end

function Button:load()
	--start
	buttons[#buttons+1] = Button:new("start", love.graphics.newImage("Art/start_up.png"), love.graphics.newImage("Art/start_dn.png"))
	buttons[1].w = buttons[1].currentImage:getWidth()
	buttons[1].h = buttons[1].currentImage:getHeight()
	buttons[1].x = width/2 - 100
	buttons[1].y = height/2 - 2*buttons[1].h - 5
	buttons[1].state = "title"
	--options
	buttons[#buttons+1] = Button:new("options", love.graphics.newImage("Art/options_up.png"), love.graphics.newImage("Art/options_dn.png"))
	buttons[2].w = buttons[2].currentImage:getWidth()
	buttons[2].h = buttons[2].currentImage:getHeight()
	buttons[2].x = width/2 - 100
	buttons[2].y = buttons[1].y + buttons[1].h + 5
	buttons[2].state = "title"
	--exit
	buttons[#buttons+1] = Button:new("exit", love.graphics.newImage("Art/exit_up.png"), love.graphics.newImage("Art/exit_dn.png"))
	buttons[3].w = buttons[3].currentImage:getWidth()
	buttons[3].h = buttons[3].currentImage:getHeight()	
	buttons[3].x = width/2  - 100
	buttons[3].y = buttons[2].y + buttons[2].h + 5
	buttons[3].state = "title"
	--help
	buttons[#buttons+1] = Button:new("help", love.graphics.newImage("Art/help_up.png"), love.graphics.newImage("Art/help_dn.png"))
	buttons[4].w = buttons[4].currentImage:getWidth()
	buttons[4].h = buttons[4].currentImage:getHeight()
	buttons[4].x = width/2 - 100
	buttons[4].y = buttons[3].y + buttons[3].h + 5
	buttons[4].state = "title"
	--AI Easy
	buttons[#buttons+1] = Button:new("easy", love.graphics.newImage("Art/easy_up.png"), love.graphics.newImage("Art/easy_dn.png"))
	buttons[5].w = buttons[5].currentImage:getWidth()
	buttons[5].h = buttons[5].currentImage:getHeight()
	buttons[5].x = 150
	buttons[5].y = 20
	buttons[5].state = "options"
	--AI Average
	buttons[#buttons+1] = Button:new("medium", love.graphics.newImage("Art/med_up.png"), love.graphics.newImage("Art/med_dn.png"))
	buttons[6].w = buttons[6].currentImage:getWidth()
	buttons[6].h = buttons[6].currentImage:getHeight()
	buttons[6].x = buttons[5].x + buttons[5].w
	buttons[6].y = 20
	buttons[6].state = "options"
	--AI Impossible
	--BGM OFF
	--BGM ON
	--SOUND OFF
	--SOUND ON
end

function Button:draw()
	for i, v in ipairs(buttons) do
		if v.state == gameState then
			love.graphics.draw(v.currentImage, v.x, v.y)
		end
	end
end

function Button:toggle()
	--toggles my options buttons to be on, while turning the others off
	--needs to be retained to the particular setting
end

function love.mousepressed(x, y, button)
	if gameState ~= "live" and button == "l" then
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
	if gameState ~= "live" and button == "l" then
		for i, v in ipairs(buttons) do
			if v.state == gameState then
				if x > v.x and x < v.x + v.w and y < v.y + v.h and y > v.y then
					if v.name == "start" then
						Paddle:load()
						gameState = "live"
					elseif v.name == "exit" then
						love.event.push('quit')
					elseif v.name == "options" then
						gameState = "options"
					elseif v.name == "help" then
						gameState = "help"
					elseif v.name == "easy" then
						difficulty = 90
					elseif v.name == "medium" then
						difficulty = 105
					elseif v.name == "hard" then
						difficulty = 120
					end
				end
			end
			
			if v.name ~= "easy" and v.name ~= "medium" then
				v.currentImage = v.upImage --return the button to normal so when we return...
			end	
		end
	end
end

