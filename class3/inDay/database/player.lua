
return new 'spec' {
  type = 'player',
  health = 100,
  speed = 300,
  firerate = 10,
  bullet = 'simple-bullet',
  bullet_direction = { 0, -1 },
  bullet_cooldown = 1,
  bullet_start = -25,
  hide_on_die = true,
  view = {
    color = { .7, .2, .7 },
    type = 'polygon',
    params = { 'fill',  -10, 5, 10, 5, 0, -15 }
  },
  area_collision = {
    color = { 0, 1, 0 },
    type = 'circle',
    params = { 'line',  0, 0, 10 }
  },
}

