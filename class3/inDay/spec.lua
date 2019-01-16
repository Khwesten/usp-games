
local Spec = new(Object) {
  health = 50,
  speed = 100,
  firerate = 0,
  bullet = nil,
  bullet_direction = { 0, 0 },
  bullet_cooldown = 1,
  view = {
    color = { 1, 1, 1 },
    type = 'rectangle',
    params = { 'fill', -5, -5, 10, 10 }
  },
  area_collision = {
    color = { 0, 1, 0 },
    type = 'circle',
    params = { 'line',  10, 10, 10 }
  },
}

return Spec
