
local GameOverScreen = new 'graphics.drawable' {}

function GameOverScreen:onDraw()
  local g = love.graphics
  local W, H = g.getDimensions()
  g.setColor(0, 0, 0)
  g.rectangle('fill', 0, 0, W, H)
  g.setColor(1, 0, 0)
  g.print('GAME OVER', W/2, H/2)
end

return GameOverScreen

