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
  self.currentHealth = self.spec.maxHealth
  self.maxHealth = self.spec.maxHealth
end

function EnemySprite:update(dt)
  i = math.floor ((self.position.y + 0.5) / self.grid.tilesize ) - 2
  j = math.floor ((self.position.x + 0.5) / self.grid.tilesize ) - 5

  empty_position = self.grid:isEmpty(i, j)
  if game_status.status ~= "GAME OVER!" then
    if self.position.x <= 410 then
      self:gameOver()
    else
      if empty_position then
        self.position.x = self.position.x - (self.spec.speed * dt)
      else
        self:applyDamage()
      end
    end
  end
end


function EnemySprite:applyDamage( )
  tower = self.grid:getEntity(i, j)
  local not_pos = new(Vec) {self.position.x,
                              self.position.y - 2}
  local notification = new 'graphics.notification' {
    position = not_pos,
    text = "-"..self.spec.power.." life"
  }

  tower.currentHealth = tower.currentHealth - self.spec.power
  self.currentHealth = self.currentHealth - tower.spec.power
  self.graphics:add('fx', notification)
  self.position.x = self.position.x + 30
  if tower.currentHealth <= 0 then
    tower.grid:removeEntity(i, j)
    tower:destroy()
  end
  if self.currentHealth <= 0 then
    self:killEnemy()
  end
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

function EnemySprite:killEnemy( )
  self.gameplay.counter.change = self.spec.value
  self:destroy()
end

function EnemySprite:updateColumn()
  if aux == 60 then
    self.grid_column = self.grid_column - 1
    aux = 1
  else
    aux = aux + 1
  end
end

return EnemySprite
