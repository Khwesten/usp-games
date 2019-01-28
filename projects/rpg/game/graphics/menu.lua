
local font_loader = require 'graphics.font_loader'

local Menu = new 'graphics.drawable' {
  box = new(Box) {-10, 10, -30, 30},
  options = nil,
  cursor = 0,
}

function Menu:init()
  self.options = {}
  self.bg_color = {.05, .05, .2}
  self.border_color = {1, 1, 1}
  self.text_color = {1, 1, 1}
  self.font = font_loader:get('regular', 25)
end

function Menu:add(name, callback)
  table.insert(self.options,{text = name, callback = callback})
  if self.cursor <= 0 then self.cursor = 1 end
end

function Menu:onDraw()
  local g = love.graphics

  --Desenha fundo do menu
  g.setColor(self.bg_color)
  g.rectangle('fill', self.box:getRectangle())
  g.setLineWidth(6)
  g.setColor(self.border_color)
  g.rectangle('line', self.box:getRectangle())

  --Desenha opções
  if #self.options > 0 then
    g.setFont(self.font)
    local step = self.box:getHeight()/(#self.options + 1)
    local y = self.box.top + step
    local margin = self.box.left + 20
    for i, option in ipairs(self.options) do
      local th = self.font:getHeight()
      g.print(option.text, margin, y - th/2)
      --Desenhar cursor
      if i == self.cursor then
        local padding = 10
        g.setLineWidth(4)
        g.rectangle('line', margin - padding,
                    y - self.font:getHeight()/2 - padding,
                    self.box:getWidth() - 20, th + 2*padding)
      end
      y = y + step
    end
  end
end

function Menu:onKeyPressed(key)
  if key == 'up' and #self.options > 0 then
    self.cursor = (self.cursor - 2)%#self.options + 1
  elseif key == 'down' and #self.options > 0 then
      self.cursor = self.cursor%#self.options + 1
  elseif key == 'return' and #self.options > 0 then
      self.options[self.cursor].callback()
  end
end

return Menu
