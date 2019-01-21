
return new 'spec' {
  type = 'boss',
  health = 300,
  speed = 30, --back to 300
  damage = 50,
  firerate = 8,
  bullet = 'simple-bullet',
  bullet_direction = { 0, 1 },
  bullet_cooldown = 2,
  bullet_start = 25,
  hide_on_die = true,
  view = {
    color = { 1, 1, 1 },
    type = 'polygon',
    params = { 'fill', 0, 0, 7.5, 7.5, 0, 15, -7.5, 7.5 }
  },
  area_collision = {
    color = { 0, 1, 0 },
    type = 'circle',
    params = { 'line',  0, 0, 10 }
  },
}

