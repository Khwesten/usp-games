local i, a

function love.load(args)
  i = tonumber(args[1]) or 10
  a = 0
  v = 0
  b = 0
  x = 0
  y = 0

  local W,H = love.graphics.getDimensions()

  _player = {
    speed = 300,
    x = W/2,
    y = H/2,
    w = 32,
    h = 36,
    quads = {},
    frame = 1,
    line = 2
  }

  _player.texture = love.graphics.newImage("sprites/mage_f.png")
  _player.texture:setFilter('nearest', 'nearest')
  _player.quad = love.graphics.newQuad(0, 0, _player.w, _player.h, 96, 144)

  for line = 0,3 do
    _player.quads[line] = {}
    for column = 0,2 do
      _player.quads[line][column] = love.graphics.newQuad(
        column * _player.w, line * _player.h, _player.w, _player.h, _player.texture:getDimensions()
      )
    end
  end
end

function love.draw()
  local x,y,w,h = _player.x, _player.y, _player.w, _player.h

  love.graphics.draw(_player.texture, _player.quads[_player.line][_player.frame], x, y, 0, 2, 2, w/2, h/2)

  love.graphics.print("Flw galera!", 50, 50)
  love.graphics.print("time: " .. i, 100, 100)
  love.graphics.polygon('fill', 10+a, 20+a, 20+a, 20+a, 20+a, 10+a, 10+a, 10+a)
  love.graphics.polygon('fill', 10, 20+a, 20, 20+a, 20, 10+a, 10, 10+a)
  love.graphics.polygon('fill', 10+5*a, 20, 20+5*a, 20, 20+5*a, 10, 10+5*a, 10)

  love.graphics.polygon('line', 1000, 0, 1000, 10, 0, 10, 0, 0)
  love.graphics.polygon('fill', 1000-b, 0, 1000-b, 10, 0, 10, 0, 0)
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

function love.update(dt)
  local dirx, diry = 0,0
  local line = 2
  i = i - dt
  if i <= 0 then love.event.quit() end

  aceleration()

  if b < 1000 then
    b = b + 1
  end
  a = a + 1

  -- movement
  if love.keyboard.isDown('up') then
    diry = -1
  end
  if love.keyboard.isDown('down') then
    diry = 1
  end
  if love.keyboard.isDown('left') then
    dirx = -1
  end
  if love.keyboard.isDown('right') then
    dirx = 1
  end

  _player.x = _player.x + _player.speed * dirx * dt
  _player.y = _player.y + _player.speed * diry * dt
end

function aceleration()
  if love.keyboard.isDown('space') then
    acelerate()
  end

  if not love.keyboard.isDown('space') then
    stopAceleration()
  end
end

function acelerate()
  v = v + 0.5
  a = a + v
  b = b + v
end

function stopAceleration()
  v = 0
end