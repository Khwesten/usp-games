local EnemySprite = new 'graphics.sprite' {
  spec = nil
}

local frame = 1
local aux = 1

function EnemySprite:init()
  assert(self.spec)
  self.filename = self.spec.sprite
  self:loadImage()
  local w,h = self.image:getDimensions()
  local hotspot = self:getHotspot()
  self.box = new(Box) { -hotspot.x, w, -hotspot.y, h }
end

function EnemySprite:update(dt)
  self:updateFrame()
  empty_position = self.grid:isEmpty(self.grid_row, self.grid_column - 1)
  if game_status.status ~= "GAME OVER!" then
    if self.position.x <= 410 then
      self:gameOver()
    else
      if empty_position then
        if aux == 60 then
          self.grid_column = self.grid_column - 1
          aux = 1
        else
          aux = aux + 1
        end
        self.position.x = self.position.x - (self.spec.speed * dt)
      else
        self:applyDamage()
      end
    end
  end
end

function EnemySprite:applyDamage( )
  enemy = self.grid:getEntity(self.grid_row, self.grid_column - 1)
  local not_pos = new(Vec) {self.position.x,
                              self.position.y - 1}
  local notification = new 'graphics.notification' {
    position = not_pos,
    text = "-"..self.power.." damage"
  }
  self.graphics:add('fx', notification)
end

function EnemySprite:updateFrame( )
  self.filename = "cruncher/frame_"..frame
  if frame == 6 then
      frame = 1
    else
      frame = frame + 1
    end
end

function EnemySprite:gameOver( )
  game_status.status = "GAME OVER!"
  game_status.duration = (love.timer.getTime() - start) / 60
  self.graphics:add('gamestatus', game_status)
end

return EnemySprite

