#pongRevised  
This is my final pass at pong before implementing physics into it.  
My goals for this are:  
* keep main.lua as short as possible by putting most of the code in separate files  
* proper UI with graphics  
* difficulty levels  
* sound  
* random blocks/powerups?   
* universal circle -> rectangle collision detection  
* add gamestates: live, pause, title, win, lose, options

##Current Settings
* Player max move speed = 200  
* AI max move speed = 100  
* Ball max horizontal velocity = 225  
* Ball max vertical velocity = 400  
* Maximum balls = 5  
* Maximum blocks = 3

##To-Do List  
* Fix button toggle function for options buttons  
* Create art for remaining buttons  
* Revise how balls obtain their random velocity
* Create win condition, win or loss state, and corresponding screens  
* (optional)Devise a plan to handle gameStates cleanly

##Known Issues(always revised with each update)
* sometimes the ball gets stuck in the sides of the window  
* collision is still shitty  
* returning to title screen from options or help causes a green hue
* random velocities can be zero or approaching 0  
* options buttons turn "off" when clicking outside their bounds

###7/23/2013
* added help gamestate and page  
* added pause functionality  
* added ai difficulty selector, easy, medium, hard  
* added interface.lua, integrated button.lua and created Screen:draw()  
* added temporary win condition, quit on score of 15
* adjusted buttons to have a corresponding gameState  
* adjusted ball max vertical velocity to 400  
* fixed horizontal velocity change based on distance from paddle center  
* fixed math error with paddle width modification

###7/21/2013 
* added options and help button  
* added custom font  
* added pregame countdown  
* adjusted max blocks to 3  

###7/19/2013
* added horizontal velocity increase depending on distance from paddle center  
* fixed the exit function

###7/18/2013
* added green to red coloration depending on block duration remaining  
* fixed the background music to loop  

###7/17/2013
* added button.lua, blocks.lua  
* added background music thanks to "thisismyusername" creator of '1-minute' @ opengameart.org  
* adjusted collision detection

###7/16/2013
* added scoring and paddle width modification  
* added start button and exit button  
* added increased vertical velocity when balls hit paddle, max 450  
* added increased horizontal velocity when balls hit wall, max 250  
* added gameStates "live" and "title"  

###7/15/2013
* Git repository created  
* ball.lua and paddle.lua in working condition