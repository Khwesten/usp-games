
return new 'spec' {
  speed = 300,
  firerate = 10,
  bullet = 'simple-bullet',
  bullet_direction = { 0, 1 },
  bullet_cooldown = 2,
  bullet_start = 25,
  hide_on_die = true,
  view = {
    color = { 1, 0, 0 },
    type = 'polygon',
    params = { 'fill',  -10, -5, 10, -5, 0, 15 }
  },
  area_collision = {
    color = { 0, 1, 0 },
    type = 'circle',
    params = { 'line',  0, 0, 10 }
  },
}

