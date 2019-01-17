
local AI = new(Object) {}

function AI:init()
end

function AI:setEntity(entity)
  self.entity = entity
end

function AI:think()
  self.target = new(Vec) {
    _player.pos.x, _player.pos.y
  }

  self.direction = self.target - self.entity.pos

  self.entity:setDirection(self.direction)
end

return AI
