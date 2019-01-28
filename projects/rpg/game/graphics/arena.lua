
local Arena = new 'graphics.drawable' {}

function Arena:onDraw()
  local g = love.graphics
  local W, H = g.getDimensions()
  g.setColor(.15, .2, .15)
  g.polygon('fill', 360, 100, W - 360, 100, W - 40, 580, 40, 580)
  g.setColor(.1, .08, .1)
  g.rectangle('fill', 40, 580, W - 80, 80)
end

return Arena

