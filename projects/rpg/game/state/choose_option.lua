
local ChooseOption = new 'state.base' {}

function ChooseOption:onEnter(battle, options)
  local W, H = love.graphics.getDimensions()
  self.options = options
  self.menu = new 'graphics.menu' {
    position = new(Vec) { W/2, H/3 },
    box = new(Box) { -120, 120, -120, 120 }
  }
  for i,option in ipairs(options) do
    self.menu:add(option, function() self:choose(i) end)
  end
  battle.graphics:add('gui', self.menu)
  battle.graphics:focus(self.menu)
end

function ChooseOption:onLeave()
  self.menu:destroy()
end

function ChooseOption:choose(i)
  self.options.chosen = self.options[i]
  self.stack:pop()
end

function ChooseOption:abort()
  self.stack:pop()
end

return ChooseOption

