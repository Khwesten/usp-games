
local TowerSprite = new 'graphics.sprite' {
  spec = nil
}

function TowerSprite:init()
  assert(self.spec)
  self.filename = self.spec.sprite
  self:loadImage()
  local w,h = self.image:getDimensions()
  local hotspot = self:getHotspot()
  self.box = new(Box) { -hotspot.x, w, -hotspot.y, h }
  self.currentHealth = self.spec.currentHealth
  self.maxHealth = self.spec.maxHealth
end

function TowerSprite:shoot()
  local bullet = new 'graphics.bullet_sprite' {
    spec = require(self.spec.bullet),
    grid = self.grid
  }
  self.graphics:add('fx', bullet)
  bullet.position = self.position
end

return TowerSprite

