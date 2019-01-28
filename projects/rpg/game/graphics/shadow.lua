
local Shadow = new 'graphics.drawable' {}

function Shadow:onDraw()
  local g = love.graphics
  g.setColor(0, 0, 0, .3)
  g.ellipse('fill', 0, 0, 48, 16)
end

return Shadow

