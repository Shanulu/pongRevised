#pongRevised  
This is my final pass at pong before implementing physics into it.  
My goals for this are:  
*keep main.lua as short as possible by putting most of the code in separate files  
*proper UI with graphics
*difficulty levels
*sound
*random blocks/powerups
*universal circle -> rectangle collision detection
*add proper gamestates: live, pause, title, win, lose

#known issues
*sometimes the ball gets stuck in the wall?

##Update 7/16/2013
*added scoring and paddle width modification  
*added start button and exit button  
*added increased vertical velocity when balls hit paddle, max 450  
*added increased horizontal velocity when balls hit wall, max 250
*added gameStates "live" and "title"  
*added button.lua


##Update 7/15/2013  
Git repository created.  
ball.lua and paddle.lua in working condition.