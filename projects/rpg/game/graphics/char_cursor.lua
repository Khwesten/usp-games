
local CharCursor = new 'graphics.drawable' {
  characters = nil,
  current = 1,
  confirm = function() end,
  cancel = function() end
}

function CharCursor:init()
  self.characters = self.characters or {}
  self.current = 1
end

function CharCursor:update(dt)
  self.position:set(self.characters[self.current].position:get())
end

function CharCursor:onKeyPressed(key)
  if key == 'right' or key == 'down' then
    self.current = math.min(self.current + 1, #self.characters)
  elseif key == 'left' or key == 'up' then
    self.current = math.max(self.current - 1, 1)
  elseif key == 'return' then
    self.confirm(self.current)
  elseif key == 'escape' then
    self.cancel(self.current)
  end
end

function CharCursor:onDraw()
  local g = love.graphics
  g.setColor(1, 1, 1)
  g.setLineWidth(4)
  g.ellipse('line', 0, 48, 64, 32)
end

return CharCursor

