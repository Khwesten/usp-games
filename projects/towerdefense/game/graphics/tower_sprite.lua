
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
  self.currentHealth = self.spec.maxHealth
  self.maxHealth = self.spec.maxHealth
  self.firerate = self.spec.firerate
  self.shootingTimer = 0
end

function TowerSprite:update(dt)
	self.shootingTimer = self.shootingTimer + dt
	while self.shootingTimer > 1 / self.firerate do
		self.shootingTimer = self.shootingTimer - 1 / self.firerate
		self:shoot()
	end
end

function TowerSprite:shoot()
  local bullet = new 'graphics.bullet_sprite' {
    spec = require(self.spec.bullet),
    grid = self.grid
  }
  self.graphics:add('fx', bullet)
  pos = new(Vec) { self.position.x + 60, self.position.y }
  bullet.position = pos
end

function TowerSprite:destroyTower()
	self:destroy()
end

return TowerSprite

