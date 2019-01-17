
return new 'spec' {
  type = 'bullet',
  health = 5,
  speed = 600,
  damage = 5,
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
