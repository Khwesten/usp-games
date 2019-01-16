
return new 'spec' {
  health = 1000,
  speed = 600,
  firerate = 0,
  bullet = nil,
  hide_on_die = false,
  view = {
    color = { 1, 1, 1 },
    type = 'rectangle',
    params = { 'fill',  -3, -3, 6, 6 }
  },
  area_collision = {
    color = { 0, 1, 0 },
    type = 'circle',
    params = { 'line',  0, 0, 5 }
  },
}
