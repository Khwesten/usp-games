
local AI = new(Object) {}

function AI:init()
  local W,H = love.graphics.getDimensions()
  self.target = new(Vec) {
    love.math.random()*2*W - W/2, H+100
  }
end

function AI:setEntity(entity)
  self.entity = entity
  self.direction = self.target - entity.pos
end

function AI:think()
  self.entity:setDirection(self.direction)
end

return AI

