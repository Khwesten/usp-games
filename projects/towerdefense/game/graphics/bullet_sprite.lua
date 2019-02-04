
local BulletSprite = new 'graphics.sprite' {
  spec = nil
}

function BulletSprite:init()
  assert(self.spec)
  self.filename = self.spec.sprite
  self:loadImage()
  local w,h = self.image:getDimensions()
  local hotspot = self:getHotspot()
  self.box = new(Box) { -hotspot.x, w, -hotspot.y, h }
end

function BulletSprite:update(dt)
  self.position.x = self.position.x + 1
  if self.position.x >= 1114 then
  	self:destroy()
  end
end

return BulletSprite

