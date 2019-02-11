
local BG_COLOR = { .4, .4, .4 }

local StaminaBar = new 'graphics.drawable' {
  x = 0
}

function StaminaBar:init()
  self.value = self.value or 1
  self.color = { 1, 0.6, 0 }
end

function StaminaBar:onDraw()
  local g = love.graphics

  g.setColor(BG_COLOR)
  g.rectangle('fill', self.x, 0, 5, 50)

  g.setColor(self.color)
  g.rectangle('fill', self.x, 0, 5, 50  * self.value)
end

return StaminaBar
