Player = Class{}

function Player:init(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
    self.dx = 0
end


function Player:render()
	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Player:update(dt)
	if self.dx > 0 then
		self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
	else
		self.x = math.max(0, self.x + self.dx * dt)
	end
end

function Player:collides(object)
    if self.x > object.x + object.width or object.x > self.x + self.width then 
        return false 
    end
    if self.y > object.y + object.height or object.y > self.y + self.height then
        return false
    end
    return true
end
