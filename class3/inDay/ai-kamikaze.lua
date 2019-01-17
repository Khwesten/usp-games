
local AI = new(Object) {}

function AI:init()
end

function AI:setEntity(entity)
  self.entity = entity
end

function AI:think()
  local target = { love.math.random()*2*W - W/2, H+100 }

  if _player.spec.health > 0 then
    target = { _player.pos.x, _player.pos.y }
  end

  self.target = new(Vec) (target)

  self.direction = self.target - self.entity.pos

  self.entity:setDirection(self.direction)
end

return AI
