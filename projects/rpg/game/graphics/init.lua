
local Graphics = new(Object) {
  layers = nil,
  focused = nil
}

function Graphics:init()
  assert(self.layers)
  for _,layer_id in ipairs(self.layers) do
    self.layers[layer_id] = new 'graphics.layer' {}
  end
end

function Graphics:add(layer, drawable)
  self.layers[layer]:add(drawable)
  drawable.graphics = self
end

function Graphics:focus(drawable)
  self.focused = drawable
end

function Graphics:onKeyPressed(key)
  if self.focused then
    self.focused:onKeyPressed(key)
  end
end

function Graphics:update(dt)
  for _, layer_id in ipairs(self.layers) do
    self.layers[layer_id]:update(dt)
  end
end

function Graphics:drawLayers()
  for _, layer_id in ipairs(self.layers) do
    self.layers[layer_id]:draw()
  end
end

return Graphics

