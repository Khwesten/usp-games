local EnemySprite = new 'graphics.sprite' {
  spec = nil
}

local frame = 1

function EnemySprite:init()
  assert(self.spec)
  self.filename = self.spec.sprite
  self:loadImage()
  local w,h = self.image:getDimensions()
  local hotspot = self:getHotspot()
  self.box = new(Box) { -hotspot.x, w, -hotspot.y, h }
end

function EnemySprite:update(dt)
  self.filename = "cruncher/frame_"..frame
  if game_status.text ~= "GAME OVER!" then
    if self.position.x == 410 then
      game_status.text = "GAME OVER!"
      self.graphics:add('gui', game_status)
    else
      self.position.x = self.position.x - 1
    end
  end
  if frame == 6 then
    frame = 1
  else
    frame = frame + 1
  end
end

return EnemySprite

