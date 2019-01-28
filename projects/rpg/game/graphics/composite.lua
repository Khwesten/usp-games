
local Composite = new 'graphics.drawable' {
}

function Composite:init()
  self.drawables = self.drawables or {}
end

function Composite:add(drawable)
  table.insert(self.drawables, drawable)
end

function Composite:onDraw()
  for _,drawable in ipairs(self.drawables) do
    drawable:draw()
  end
end

return Composite

