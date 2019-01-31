
local EnemySprite = new 'graphics.sprite' {
  spec = nil
}

function EnemySprite:init()
  assert(self.spec)
  self.filename = self.spec.sprite
  self:loadImage()
  local w,h = self.image:getDimensions()
  local hotspot = self:getHotspot()
  self.box = new(Box) { -hotspot.x, w, -hotspot.y, h }
end

function EnemySprite:update(dt)
  self.position.x = self.position.x - 1
end

return EnemySprite

