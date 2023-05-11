Object = Class{}


function Object:init(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.dy = 0
	
	
end

function Object:render()
	love.graphics.setColor(255/255, 0/255, 0/255, 255/255)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Object:reset()

	self.x = math.random(1, VIRTUAL_WIDTH - self.width)
	self.y = 0
	self.dy = 0
	
end

function Object:update(dt)
	self.y = self.y + self.dy * dt
	
end