#pongRevised  
This is my final pass at pong before implementing physics into it.  
My goals for this are:  
*keep main.lua as short as possible by putting most of the code in separate files  
*proper UI with graphics  
*difficulty levels  
*sound  
*random blocks/powerups  
*universal circle -> rectangle collision detection  
*add proper gamestates: live, pause, title, win, lose, pregame

##Known Issues(always revised with each update)
*sometimes the ball gets stuck in the sides of the window  
*collision is still shitty  
*i had to disable the check for both horizontal and vertical collision within  
the same scope as I was often getting diagonal bounces.....

##Update 7/17/2013
*added button.lua, blocks.lua  
*added background music thanks to "thisismyusername" creator of '1-minute' @ opengameart.org  
*revised collision detection

##Update 7/16/2013
*added scoring and paddle width modification  
*added start button and exit button  
*added increased vertical velocity when balls hit paddle, max 450  
*added increased horizontal velocity when balls hit wall, max 250
*added gameStates "live" and "title"  

##Update 7/15/2013  
Git repository created.  
ball.lua and paddle.lua in working condition.