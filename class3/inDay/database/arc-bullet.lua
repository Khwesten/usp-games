
return new 'spec' {
  type = 'bullet',
  health = 5,
  speed = 600,
  damage = 15,
  firerate = 0,
  bullet = nil,
  hide_on_die = false,
  view = {
    color = { 1, 1, 1 },
    type = 'arc',
    params = { 'line', 'open', -1, -1, 10, 0, math.pi, 10 }
  },
  area_collision = {
    color = { 0, 1, 0 },
    type = 'circle',
    params = { 'line',  1, 1, 10 }
  },
}
