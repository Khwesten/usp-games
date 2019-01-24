local Game = new(Object) {}

function Game:init()
  self.ais = {}
  self.entities = {}
  self.debug_mode = true
end

function Game:add_entity(entity, ai)
  self.entities[entity.id] = entity

  if ai then
    self.ais[entity.id] = ai
  end
end

function Game:remove_entity(entity)
  if self.ais[entity.id] then
    self.ais[entity.id] = nil
  end

  self.entities[entity.id] = nil
end

function Game:entities_size()
  local count = 0

  for _,value in next, self.entities do
    count = count + 1
  end

  return count
end

function Game:entities_on_screen()
  return #self.entities
end

return Game
