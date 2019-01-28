
local ExecuteAction = new 'state.base' {
  delay = 0
}

function ExecuteAction:onEnter(battle, action)
  local name, params = action.name, action.params
  if name == 'attack' then
    local target = params.target
    battle.graphics:add('fx', new 'graphics.notification' {
      position = new(Vec) { target.avatar.position:get() },
      color = { .9, .9, .2 },
      text = "-999"
    })
    self.delay = 1.0
  elseif name == 'item' then
    battle.graphics:add('fx', new 'graphics.notification' {
      position = new(Vec) { params.target.position:get() },
      color = { .2, .9, .9 },
      text = params.item
    })
  end
end

function ExecuteAction:onUpdate(dt)
  self.delay = self.delay - dt
  if self.delay <= 0 then
    self.stack:pop()
  end
end

return ExecuteAction

