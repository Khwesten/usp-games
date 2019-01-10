function love.load(args)
  local W,H = love.graphics.getDimensions()

  _player = {
    x = W/2,
    y = H/2,
    w = 32,
    h = 36,
    speed = 300,
    quads = {},
    frame = 1,
    line = 2
  }

  loadCharacter(_player)
end

function love.draw()
  local x, y, w, h = _player.x, _player.y, _player.w, _player.h

  love.graphics.draw(_player.texture, _player.quads[_player.line][_player.frame], x, y, 0, 2, 2, w/2, h/2)
end

function love.update(dt)
  local line = 2
  local dirx, diry = 0,0

  characterMovement(_player, dirx, diry, dt)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end

  if key == 'up' then
    line = 0
    diry = -1
  end

  if key == 'down' then
    line = 2
    diry = 1
  end

  if key == 'left' then
    line = 3
    dirx = -1
  end

  if key == 'right' then
    line = 1
    dirx = 1
  end

  _player.line = line
end

function loadCharacter(player)
  player.texture = love.graphics.newImage('sprites/mage_f.png')
  player.texture:setFilter('nearest', 'nearest')
  player.quad = love.graphics.newQuad(0, 0, player.w, player.h, 96, 144)

  player.quads = loadQuads(player.w, player.h, player.texture)
end

function loadQuads(width, height, texture)
  quads = {}

  for line = 0, 3 do
    quads[line] = {}

    for column = 0, 2 do
      quads[line][column] = love.graphics.newQuad(column * width, line * height, width, height, texture:getDimensions())
    end
  end

  return quads
end

function characterMovement(player, dirx, diry, dt)
  if love.keyboard.isDown('up') then diry = -1 end
  if love.keyboard.isDown('right') then dirx = 1 end
  if love.keyboard.isDown('down') then diry = 1 end
  if love.keyboard.isDown('left') then dirx = -1 end

  player.x = player.x + player.speed * dirx * dt
  player.y = player.y + player.speed * diry * dt
end

