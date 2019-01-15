
local Vec = new(Object) {}

function Vec:init()
  self.x = self.x or self[1] or 0
  self.y = self.y or self[2] or 0
end

function Vec:__tostring()
  return "(" .. self.x .. ", " .. self.y .. ")"
end

function Vec:set(x, y)
  self.x = x
  self.y = y
end

function Vec:get()
  return self.x, self.y
end

function Vec:__add(other)
  return new(Vec) { self.x + other.x, self.y + other.y }
end

function Vec:__sub(other)
  return new(Vec) { self.x - other.x, self.y - other.y }
end

function Vec:__mul(other)
  if type(other) == 'number' then
    return new(Vec) { self.x * other, self.y * other }
  else
    return new(Vec) { self.x * other.x, self.y * other.y }
  end
end

function Vec:__div(other)
  if type(other) == 'number' then
    return new(Vec) { self.x / other, self.y / other }
  else
    return new(Vec) { self.x / other.x, self.y / other.y }
  end
end

function Vec:translate(other)
  self.x = self.x + other.x
  self.y = self.y + other.y
end

function Vec:normalized()
  local length = math.sqrt(self.x * self.x + self.y * self.y)
  if length >= 0.1 then
    return self / length
  else
    return new(Vec) {}
  end
end

return Vec

