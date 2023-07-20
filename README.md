# SNEAKY SNAKE
#### Video Demo:  <https://youtu.be/cJK-bNn851I>
#### Description: The author's version of the 1976 arcade video game "Blockade" written in Lua with LÖVE

For CS50's final project I decided to make my own version of the video game "Blockade", more commonly know as "Snake". Why this game? Because it's the definition of a true classic (and also because it isn't extremely complicated, I know my limitations). Why a video game? Because I absolutely love them, and have since I was a little child and my parents bought me a Game Boy Advance SP with a copy of Pokémon Sapphire.

So what does it do? Well, the player controls a snake that can move in four directions and whose scope is to eat the pieces of food that are randomly placed in the game window. The snake starts with a length of three squares, and every time it eats a pellet, grows one square, and a new pellet is place in a different random position. If the snake touches any edge of the window, or crashes into itself, it's game over.

To accomplish this, some code is written in the file "main.lua". Why main? Because the "LÖVE" framework used to run the game needs the file to be named main to recognise it and run it's code. It is divided into four main functions. Let's see them one by one:

love.load()

The function that runs every time the game starts. It takes care of loading all the content that will be needed for the game. In this case, it sets the timer to 0, the snake's direction to "up", the game_over variable to false, the score to 0, gets the total and the half height of the window to set the size of the game blocks relative to those, then it sets the three starting snake squares, the pellet's position with the function drawPellet(), and it checks whether the pellet is touching the snake (in which case, it sets the position again) or not with the function checkPellet().

love.update(dt)

This function takes care of all the updates that will occur when the game is running. It is designed to run once every fifth of a second while the variable game_over is false, and to stop for 3 seconds and reload the game when it is true. In the former case, it checks the direction of the snake (the direction variable, set in love.load()) and inserts a new green square (a snake part) in that direction, while removing the last part of the snake, to make the illusion of movement possible. If the next position to which the snake is moving is occupied by the snake itself, it means it crashed into itself and it's game over (which means the game is reset after 3 seconds). The same goes for when the snake touches the edge of the game window. If the snake eats a pellet, this one is reset and the score is increased by one.

love.draw()

This function first draws the game window rectangle, with a dark grey colour so as to tell it apart from the background. Then the snake is drawn as three green squares, and the pellet as a yellow one. Then it checks if the game_over variable is true, in which case it prints "Game Over" and the final score to the screen for the player to know.

love.keypressed(key)

This function just checks what buttons are being pressed by the player, and changes the direction variable in love.load() accordingly, allowing love.update(dt) to make the necessary updates to the snake's direction.
