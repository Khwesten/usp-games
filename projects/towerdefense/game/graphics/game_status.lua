
local font_loader = require 'graphics.font_loader'


local GameStatus = new 'graphics.drawable' {
  position = new(Vec) { W/2 , H/2 },
  status = 'text',
  font = font_loader:use("bold", 24),
  enemy_kills = 0,
  duration = 0
}

function GameStatus:init()
  self.box = new(Box) {200, -200, -100, H / 6 }
end

function GameStatus:onDraw()
  local g = love.graphics
  local tx = -self.font:getWidth(self.status)/2
  local ty = -self.font:getHeight(self.status)/2
  g.rectangle('fill', self.box:getRectangle())
  g.setColor(.0,.0,.0)
  font_loader:use(self.font)
  g.print(self.status, tx, ty)
  font = font_loader:use("bold", 14)
  -- g.print('Enimigos mortos: '..self.enemy_kills, tx + 10, ty + 30)
  g.print(('Duração da partida: %.2f minutos'):format(self.duration), tx - 50 , ty + 50)
end

return GameStatus
