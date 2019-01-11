function love.load(args)
  UP_POSITION = 0
  RIGHT_POSITION = 1
  DOWN_POSITION = 2
  LEFT_POSITION = 3

  currentTime = 0
  lastKeyPressed = 'down'
  duration = duration or 0.5

  local W,H = love.graphics.getDimensions()

  _player = {
    x = W/2,
    y = H/2,
    w = 32,
    h = 36,
    speed = 300,
    quads = {},
    frames = {[0] = 1, [1] = 1, [2] = 1, [3] = 1},
    line = 2,
  }

  loadCharacter(_player)
end

function love.draw()
  local x, y, w, h = _player.x, _player.y, _player.w, _player.h

  local column = _player.frames[_player.line]

  love.graphics.draw(
    _player.texture,
    _player.quads[_player.line][column],
    x, y, 0, 2, 2, w/2, h/2
  )
end

function love.update(dt)
  currentTime = currentTime + dt

  if currentTime >= duration then
      currentTime = currentTime - duration
  end

  local line = 2
  local dirx, diry = 0,0

  love.graphics.print(dt, 100, 100)

  characterMovement(_player, dirx, diry, dt)
end

function love.keypressed(key)
  line = DOWN_POSITION

  if key == 'escape' then
    love.event.quit()
  end

  if key == 'up' then
    line = UP_POSITION
    diry = -1
  end

  if key == 'down' then
    line = DOWN_POSITION
    diry = 1
  end

  if key == 'left' then
    line = LEFT_POSITION
    dirx = -1
  end

  if key == 'right' then
    line = RIGHT_POSITION
    dirx = 1
  end

  lastKeyPressed = key

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

  for line = 0, texture:getWidth()/width do
    quads[line] = {}

    for column = 0, texture:getHeight()/height do
      quads[line][column] = love.graphics.newQuad(column * width, line * height, width, height, texture:getDimensions())
    end
  end

  return quads
end

function round(value)
  return value + 0.5 - (value + 0.5) % 1
end

function characterMovement(player, dirx, diry, dt)
  line = _player.line

  if love.keyboard.isDown('up') then
    line = UP_POSITION
    diry = -1
  elseif love.keyboard.isDown('right') then
    line = RIGHT_POSITION
    dirx = 1
  elseif love.keyboard.isDown('down') then
    line = DOWN_POSITION
    diry = 1
  elseif love.keyboard.isDown('left') then
    line = LEFT_POSITION
    dirx = -1
  end

  if not love.keyboard.isDown(lastKeyPressed) then
    line = player.line
    frame = player.frames[player.line]
  else
    frame = math.floor(currentTime / duration * 3)
  end

  player.x = player.x + player.speed * dirx * dt
  player.y = player.y + player.speed * diry * dt
  player.frames[player.line] = frame
  player.line = line
end

