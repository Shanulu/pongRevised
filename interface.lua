----------------------------------------------------------------------------
-- project:			Pong Revised
-- file: 			interface.lua
-- author:			Michael Groll
-- version:			0.8.0
-- gitHub:			https://github.com/Shanulu/pongRevised
--
-- description:     Handles initializing of buttons and text, drawing and
--					updating thereof.
----------------------------------------------------------------------------
Screen = {}
preGameFont = love.graphics.newFont("Fonts/Digital_tech.otf", 36)
scoreFont = love.graphics.newFont("Fonts/Digital_tech.otf", 14)

function Screen:draw()
--[[ HELP SCREEN --------------------------------------]]

	if gameState == "title" then
		--draw our title screen
		love.graphics.clear()
		love.graphics.setColorMode("modulate")
		love.graphics.setFont(preGameFont)
		love.graphics.setColor(150, 0, 200)    --doesnt work because we used setColorMode("replace") to prevent our buttons from fucking up
		love.graphics.print("Pong 2.0", width/2 - 75, 20)
	elseif gameState == "help" then
		--draw our help screen
		love.graphics.clear()
		love.graphics.setColorMode("modulate")
		love.graphics.setColor( 100, 255, 50)
		love.graphics.setFont(preGameFont)
		love.graphics.printf("Use W and A or Left and Right to move." ..
							"\n\nRandom blocks will spawn and die. The color gives away the time remaining" ..
							"\n\nBalls will spawn from blocks, or if 0 remain, up to a maximum of 5" ..
							"\n\nBalls increase in speed by hitting objects and walls" ..
							"\n\nFirst to 15 wins!" , 20,20, width-30)
	elseif gameState == "options" then
		--draw options screen
		love.graphics.clear()
		love.graphics.setColorMode("modulate")
		love.graphics.setColor( 100, 255, 50)
		love.graphics.setFont(preGameFont)
		love.graphics.print("AI difficulty:", 20, 20)
		love.graphics.print("BGM Music: ", 20, 50)
	elseif gameState == "win" then
		love.graphics.clear()
		love.graphics.setColorMode("modulate")
		love.graphics.setFont(preGameFont)
		love.graphics.print("You won!", width/2 - 100, height/2)
	elseif gameState == "lose" then
		love.graphics.clear()
		love.graphics.setColorMode("modulate")
		love.graphics.setFont(preGameFont)
		love.graphics.print("You lost!", width/2 - 100, height/2)
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
	buttons[#buttons+1] = Button:new("bgmOff", love.graphics.newImage("Art/off_up.png"), love.graphics.newImage("Art/off_dn.png"))
	buttons[8].w = buttons[8].currentImage:getWidth()
	buttons[8].h = buttons[8].currentImage:getHeight()
	buttons[8].x = buttons[5].x
	buttons[8].y = buttons[5].y + buttons[5].h + 10
	buttons[8].state = "options"
	--BGM1
	buttons[#buttons+1] = Button:new("bgm1", love.graphics.newImage("Art/one_up.png"), love.graphics.newImage("Art/one_dn.png"))
	buttons[9].w = buttons[9].currentImage:getWidth()
	buttons[9].h = buttons[9].currentImage:getHeight()
	buttons[9].x = buttons[8].x + buttons[8].w
	buttons[9].y = buttons[8].y
	buttons[9].state = "options"	
	--BGM2
	buttons[#buttons+1] = Button:new("bgm2", love.graphics.newImage("Art/two_up.png"), love.graphics.newImage("Art/two_dn.png"))
	buttons[10].w = buttons[10].currentImage:getWidth()
	buttons[10].h = buttons[10].currentImage:getHeight()
	buttons[10].x = buttons[9].x + buttons[9].w
	buttons[10].y = buttons[9].y
	buttons[10].state = "options"
	--BGM3
	buttons[#buttons+1] = Button:new("bgm3", love.graphics.newImage("Art/three_up.png"), love.graphics.newImage("Art/three_dn.png"))
	buttons[11].w = buttons[11].currentImage:getWidth()
	buttons[11].h = buttons[11].currentImage:getHeight()
	buttons[11].x = buttons[10].x + buttons[10].w
	buttons[11].y = buttons[10].y
	buttons[11].state = "options"
	--BGM4
	buttons[#buttons+1] = Button:new("bgm4", love.graphics.newImage("Art/four_up.png"), love.graphics.newImage("Art/four_dn.png"))
	buttons[12].w = buttons[12].currentImage:getWidth()
	buttons[12].h = buttons[12].currentImage:getHeight()
	buttons[12].x = buttons[11].x + buttons[11].w
	buttons[12].y = buttons[11].y
	buttons[12].state = "options"
	--BGM5
	buttons[#buttons+1] = Button:new("bgm5", love.graphics.newImage("Art/five_up.png"), love.graphics.newImage("Art/five_dn.png"))
	buttons[13].w = buttons[13].currentImage:getWidth()
	buttons[13].h = buttons[13].currentImage:getHeight()
	buttons[13].x = buttons[12].x + buttons[12].w
	buttons[13].y = buttons[12].y
	buttons[13].state = "options"
end

function Button:draw()
	for i, v in ipairs(buttons) do
		if v.state == gameState then
			love.graphics.setColorMode("replace")
			love.graphics.draw(v.currentImage, v.x, v.y)
			v:update()
		end
	end
end

function Button:update()
	local x = love.mouse.getX()
	local y = love.mouse.getY()
	if x and y then --mouse is here
		if x > self.x and x < self.x + self.w and y < self.y + self.h and y > self.y and love.mouse.isDown("l")  then --my mouse is inside my button
			self.currentImage = self.downImage

			if self.name == "easy" then --turn off medium and hard
				buttons[6].currentImage = buttons[6].upImage
				buttons[7].currentImage = buttons[7].upImage
				return
			elseif self.name == "medium" then 
				buttons[5].currentImage = buttons[5].upImage
				buttons[7].currentImage = buttons[7].upImage
				return
			elseif self.name == "hard" then
				buttons[5].currentImage = buttons[5].upImage
				buttons[6].currentImage = buttons[6].upImage
				return
			elseif self.name == "bgmOff" then
				buttons[9].currentImage = buttons[9].upImage 
				buttons[10].currentImage = buttons[10].upImage
				buttons[11].currentImage = buttons[11].upImage
				buttons[12].currentImage = buttons[12].upImage
				buttons[13].currentImage = buttons[13].upImage
				return
			elseif self.name == "bgm1" then 
				buttons[8].currentImage = buttons[8].upImage 
				buttons[10].currentImage = buttons[10].upImage
				buttons[11].currentImage = buttons[11].upImage
				buttons[12].currentImage = buttons[12].upImage
				buttons[13].currentImage = buttons[13].upImage
				return
			elseif self.name == "bgm2" then  --10
				buttons[8].currentImage = buttons[8].upImage
				buttons[9].currentImage = buttons[9].upImage 
				buttons[11].currentImage = buttons[11].upImage
				buttons[12].currentImage = buttons[12].upImage
				buttons[13].currentImage = buttons[13].upImage
				return
			elseif self.name == "bgm3" then
				buttons[8].currentImage = buttons[8].upImage
				buttons[9].currentImage = buttons[9].upImage 
				buttons[10].currentImage = buttons[10].upImage
				buttons[12].currentImage = buttons[12].upImage
				buttons[13].currentImage = buttons[13].upImage
				return
			elseif self.name == "bgm4" then
				buttons[8].currentImage = buttons[8].upImage
				buttons[9].currentImage = buttons[9].upImage 
				buttons[10].currentImage = buttons[10].upImage
				buttons[11].currentImage = buttons[11].upImage
				buttons[13].currentImage = buttons[13].upImage
				return
			elseif self.name == "bgm5" then
				buttons[8].currentImage = buttons[8].upImage
				buttons[9].currentImage = buttons[9].upImage 
				buttons[10].currentImage = buttons[10].upImage
				buttons[11].currentImage = buttons[11].upImage
				buttons[12].currentImage = buttons[12].upImage
				return
			end
		elseif self.name ~= "easy" 
			and self.name ~= "medium" 
			and self.name ~= "hard" 
			and self.name ~= "bgmOff"
			and self.name ~= "bgm1"
			and self.name ~= "bgm2"
			and self.name ~= "bgm3"
			and self.name ~= "bgm4"
			and self.name ~= "bgm5" then
			self.currentImage = self.upImage
		end
	end
end

function love.mousereleased(x, y, button)
	if gameState ~= "live" and button == "l" then
		for i, v in ipairs(buttons) do
			if v.state == gameState then   --make sure our button is of the current gameState
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
					elseif v.name == "bgmOff" then
						love.audio.stop()
					elseif v.name == "bgm1" then
						love.audio.stop()
						music = bgm1
						love.audio.play(music)
					elseif v.name == "bgm2" then
						love.audio.stop()
						music = bgm2
						love.audio.play(music)
					elseif v.name == "bgm3" then
						love.audio.stop()
						music = bgm3
						love.audio.play(music)
					elseif v.name == "bgm4" then
						love.audio.stop()
						music = bgm4
						love.audio.play(music)
					elseif v.name == "bgm5" then
						love.audio.stop()
						music = bgm5
						love.audio.play(music)
					end
				end			
			end	
		end
	end
end
