
local BG_COLOR = { .4, .4, .4 }

local Bar = new 'graphics.drawable' {
  radius = 64,
  value = 1,
  start_angle = 0,
  size_angle = math.pi,
  color = nil
}

function Bar:init()
  self.color = self.color or { .2, .2, .8 }
end

function Bar:onDraw()
  local g = love.graphics
  g.setLineWidth(8)
  g.setColor(BG_COLOR)
  g.arc('line', 'open', 0, 0, self.radius, self.start_angle,
        self.start_angle + self.size_angle)
  g.setColor(self.color)
  g.arc('line', 'open', 0, 0, self.radius, self.start_angle,
        self.start_angle + self.value * self.size_angle)
end

return Bar

