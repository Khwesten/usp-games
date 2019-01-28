
local ChooseTarget = new 'state.base' {}

function ChooseTarget:onEnter(battle, targets)
  self.targets = targets
  local target_drawables = {}
  for i,target in ipairs(targets) do
    target_drawables[i] = target.avatar
  end
  self.cursor = new 'graphics.char_cursor' {
    characters = target_drawables,
    confirm = function(i) self:choose(i) end,
    cancel = function() self:abort() end
  }
  battle.graphics:add('cursor', self.cursor)
  battle.graphics:focus(self.cursor)
end

function ChooseTarget:onLeave()
  self.cursor:destroy()
end

function ChooseTarget:choose(i)
  self.targets.chosen = self.targets[i]
  self.stack:pop()
end

function ChooseTarget:abort()
  self.stack:pop()
end

return ChooseTarget

