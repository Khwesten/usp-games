
return new 'spec' {
  type = 'enemy',
  health = 10,
  speed = 300,
  damage = 30,
  firerate = 7,
  bullet = 'arc-bullet',
  bullet_direction = { 0, 1 },
  bullet_cooldown = 2,
  bullet_start = 25,
  hide_on_die = true,
  view = {
    color = { 0, 0, 1 },
    type = 'circle',
    params = { 'fill', 0, 0, 10 }
  },
  area_collision = {
    color = { 0, 1, 0 },
    type = 'circle',
    params = { 'line',  0, 0, 10 }
  },
}

