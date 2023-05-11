push = require 'push'
Class = require 'class'

require 'Object'
require 'Player'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PLAYER_SPEED = 120
OBJECT_SPEED = 200

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setTitle("game")

    math.randomseed(os.time())
	
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = true,
		vsync = true
	}) 

    medium_font = love.graphics.newFont("font.ttf", 20)
	small_font = love.graphics.newFont("font.ttf", 13)

    player = Player (0, VIRTUAL_HEIGHT-70, 70, 70)
    object = Object (100, 100, 10, 10)

    playerScore = 0
    -- 'start' (sanam tamashi daiwyeba)
    -- 'play'  (tamashi mimdinareobs)
    -- 'win'   (tamashi mogebulia)
    -- 'fail'  (tamashshi waago)
    gameState = 'start'
end

function love.resize(w, h)
	push:resize(w, h)
end

function love.update(dt)
    if gameState == 'play' then


        object.dy = OBJECT_SPEED
        if love.keyboard.isDown("d") then
            player.dx = PLAYER_SPEED
        elseif love.keyboard.isDown("a") then
            player.dx = - PLAYER_SPEED
        else
            player.dx = 0
        end
        object:update(dt)
        player:update(dt)
    
        if player:collides(object)  then
           gameState = 'fail'
        end

        if object.x <= 0 then
            object.x = 0
        elseif object.x >= VIRTUAL_WIDTH - object.width then
            object.x = VIRTUAL_WIDTH - object.width
        end

        
    

        if object.y > VIRTUAL_HEIGHT then
            playerScore = playerScore + 1
            
            if playerScore == 10 then
                gameState = 'win'
            else
                object:reset()
            end
        end
            
    end
end
function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	elseif key == 'enter' or key == 'return' then
		if gameState == 'start' then
			gameState = 'play'
        elseif gameState == 'win' or 'fail'then
			gameState = 'play'

            object:reset()
			playerScore = 0
		end
	end
end

function love.draw()
    push:apply("start")
    love.graphics.clear(62/255, 229/255, 43/255, 255/255)
    
    if gameState == 'start' then
		love.graphics.setFont(small_font)
		love.graphics.printf('Welcome!', 0, 10, VIRTUAL_WIDTH, 'center')
		love.graphics.printf('Press Enter to begin!', 0, 25, VIRTUAL_WIDTH, 'center')
	elseif gameState == 'win' then
		love.graphics.setFont(medium_font)
		love.graphics.printf('Congratulations you win', 0, 25, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(small_font)
        love.graphics.printf('Press Enter to begin again', 0, 55, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'fail'then
        love.graphics.setFont(small_font)
        love.graphics.printf('You lost', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to begin again', 0, 25, VIRTUAL_WIDTH, 'center')
	end

	displayScore()
    player:render()
    object:render()
    displayFPS()
    push:apply("end")
end

function displayScore()

	love.graphics.setFont(medium_font)
	love.graphics.print(tostring(playerScore), VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2)

end
function displayFPS()
	love.graphics.setFont(medium_font)
	love.graphics.setColor(0/255, 255/255, 0/255, 255/255)
	love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
	love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
end