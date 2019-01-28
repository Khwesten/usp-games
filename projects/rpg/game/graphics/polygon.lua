
local Polygon = new 'graphics.drawable' {
  mode = 'fill',
  vertices = nil
}

function Polygon:init()
  self.vertices = self.vertices or {}
end

function Polygon:onDraw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.polygon(self.mode, self.vertices)
end

return Polygon

