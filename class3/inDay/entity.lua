local Entity = new(Object) {
  spec = nil,
  cooldown = 0
}

function Entity.load(name)
  return new(Entity) {
    spec = new 'spec' (require('database.' .. name))
  }
end

function Entity:init()
  local memory_space = tostring(self)

  self.id = memory_space:gsub(': ', '')
  self.pos = self.pos or new(Vec) { 0, 0 }
  self.dir = new(Vec) { 0, 0 }
  self.type = self.spec.type
end

function Entity:setDirection(dir)
  self.dir = dir:normalized()
end

function Entity:update(entities, dt)
  self.pos:translate(self.dir * self.spec.speed * dt)
  self.cooldown = self.cooldown + dt

  local cooldown_between_shots = self.spec.bullet_cooldown / self.spec.firerate

  while self.cooldown > cooldown_between_shots do
    self.cooldown = self.cooldown - cooldown_between_shots

    local new_entity = Entity.load(self.spec.bullet)
    --botão para atirar e resetar
    if love.keyboard.isDown('space') and self.id == _player.id then
      new_entity.pos:set(self.pos.x, self.pos.y + self.spec.bullet_start)
      new_entity:setDirection(new(Vec) (self.spec.bullet_direction))
      add_entity(new_entity)
    elseif self.id ~= _player.id then
      new_entity.pos:set(self.pos.x, self.pos.y + self.spec.bullet_start)
      new_entity:setDirection(new(Vec) (self.spec.bullet_direction))
      add_entity(new_entity)
    end
  end

  for _,entity in next, entities do
    if self:check_collision(entity) then
      if entity.spec.hide_on_die and entity.spec.health <= 0 then
        remove_entity(entity)
      end

      if self.type == 'bullet' and not entity.type == 'bullet'
        then remove_entity(self)
      end
    end

    if entity:out_of_screen() then
      remove_entity(entity)
    end
  end
end

function Entity:out_of_screen()
  return self.pos.x > 400 or self.pos.x < 0 or self.pos.y > 600 or self.pos.y < 0
end

function Entity:screen_limit(direction)
  if direction == 'left' and self.pos.x < 15 then
    return true
  elseif direction == 'right' and self.pos.x > (W - 15) then
    return true
  elseif direction == 'down' and self.pos.y > (H - 15) then
    return true
  elseif direction == 'up' and self.pos.y < 15 then
    return true
  end

  return false
end

function Entity:check_collision(entity)
  if entity == nil or self.id == entity.id then
    return false
  end

  local x1 = self.pos.x
  local y1 = self.pos.y
  local r1 = self.spec.area_collision.params[4]

  local x2 = entity.pos.x
  local y2 = entity.pos.y
  local r2 = entity.spec.area_collision.params[4]

  local collided = (x1 - x2)^2 + (y2 - y1)^2 <= (r2 + r1)^2

  if collided then
    self.spec.health = self.spec.health - entity.spec.damage
    entity.spec.health = entity.spec.health - self.spec.damage

    return true
  end

  return false
end

function Entity:draw()
  local view = self.spec.view
  local area_collision = self.spec.area_collision
  local g = love.graphics

  g.push()
  g.translate(self.pos:get())
  g.setColor(view.color)
  g[view.type](unpack(view.params))
  g.pop()

  g.push()
  g.translate(self.pos:get())
  g.setColor(area_collision.color)
  g[area_collision.type](unpack(area_collision.params))
  g.pop()
end

return Entity

