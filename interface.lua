--[[ interface.lua    ----------------------------  Created by: Michael Groll   
created to handle my drawing calls for title/options/help screens and
to handle my button loading and drawing and mouse callbacks in regards to those
---------------------------------------------------------------------------]]

Screen = {}

function Screen:draw()
--[[ HELP SCREEN --------------------------------------]]
	--draw our title screen
	if gameState == "title" then
		love.graphics.clear()
		love.graphics.setFont(preGameFont)
		--love.graphics.setColor(150, 0, 200)    --doesnt work because we used setColorMode("replace") to prevent our buttons from fucking up
		love.graphics.print("Pong 2.0", width/2 - 50, 20)
	elseif gameState == "help" then
		--draw our help screen
		love.graphics.clear()
		--love.graphics.setColor( 100, 255, 50)
		love.graphics.setFont(preGameFont)
		love.graphics.printf("Use W and A or Left and Right to move." ..
							"\n\nRandom blocks will spawn and die. The color gives away the time remaining" ..
							"\n\nBalls will spawn from blocks, or if 0 remain, up to a maximum of 5" ..
							"\n\nBalls increase in speed by hitting objects and walls" , 20,20, width-30)
	elseif gameState == "options" then
		--draw options screen
		love.graphics.clear()
		--love.graphics.setColor( 100, 255, 50)
		love.graphics.setFont(preGameFont)
		love.graphics.print("AI difficulty:", 20, 20)
		love.graphics.print("BGM Volume: ", 20, 50)
	elseif gameState == "paused" then
		love.graphics.setFont(preGameFont)
		love.graphics.print("Paused. Press P to resume.", 30, height/2)
	end
	--draw our buttons
	Button:draw()
end
		
--[[------ BUTTON -----------------------------------------------------------------------------------------------------------------------]]

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
	buttons[5].x = 250
	buttons[5].y = 25
	buttons[5].state = "options"
	--AI Medium
	buttons[#buttons+1] = Button:new("medium", love.graphics.newImage("Art/med_up.png"), love.graphics.newImage("Art/med_dn.png"))
	buttons[6].w = buttons[6].currentImage:getWidth()
	buttons[6].h = buttons[6].currentImage:getHeight()
	buttons[6].x = buttons[5].x + buttons[5].w
	buttons[6].y = 25
	buttons[6].state = "options"
	--AI Hard
	buttons[#buttons+1] = Button:new("hard", love.graphics.newImage("Art/hard_up.png"), love.graphics.newImage("Art/hard_dn.png"))
	buttons[7].w = buttons[7].currentImage:getWidth()
	buttons[7].h = buttons[7].currentImage:getHeight()
	buttons[7].x = buttons[6].x + buttons[6].w
	buttons[7].y = 25
	buttons[7].state = "options"
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
			
			if v.name ~= "easy" and v.name ~= "medium" and v.name ~= "hard" then
				v.currentImage = v.upImage --return the button to normal so when we return...
			end	
		end
	end
end

