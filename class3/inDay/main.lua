require 'common'
require 'score'
require 'game'
require 'vscode_debug'

local Entity = require 'entity'
local HealthBar = require 'healthBar'

local _easy_enemy_timer
local _kamikaze_enemy_timer

local CONTROLS = {
  up = new(Vec) { 0, -1 },
  down = new(Vec) { 0, 1 },
  left = new(Vec) { -1, 0 },
  right = new(Vec) { 1, 0 },
}

local bgElements = {
  love.graphics.newImage("images/Stars-Nebulae/Nebula1.png"),
  love.graphics.newImage("images/Stars-Nebulae/Nebula2.png"),
  love.graphics.newImage("images/Stars-Nebulae/Nebula3.png")
}

function love.load()
  debuggee.poll()
  game = new(Game) {}
  score = new(Score) {}
  default_color = { 1, 1, 1 }
  count = 1

  W, H = love.graphics.getDimensions()

  _easy_enemy_timer = 0
  _kamikaze_enemy_timer = 0

  _player = Entity.load 'player'
  _player.pos:set(W/2, 9*H/10)
  _background = love.graphics.newImage("images/Stars-Nebulae/Stars.png")
  _background_element = bgElements[count]
  background_y = 0
  element_y = 0
  game:add_entity(_player)
end

function love.update(dt)
  _easy_enemy_timer = _easy_enemy_timer + dt
  _kamikaze_enemy_timer = _kamikaze_enemy_timer + dt

  if _easy_enemy_timer >= 2 then
    _easy_enemy_timer = 0

    add_easy_enemy()
  end

  if _kamikaze_enemy_timer >= 3 then
    _kamikaze_enemy_timer = 0

    add_kamikaze_enemy()
  end

  ai_thinking()

  player_control()

  update_entities(dt)

  update_bg_elements(dt)
end

function love.draw()
  if game.debug_mode then
    love.graphics.print(game:entities_size(), 10, H - 20)
  end

    love.graphics.draw(_background, 0, background_y)
    love.graphics.draw(_background, 0, background_y - _background:getHeight())
    love.graphics.draw(_background_element, - count * 120, element_y)

  score:print()

  if _player.spec.health <= 0 then
    love.graphics.print('GAME OVER', W/2 - 40, H/2)
    love.graphics.print('Press return to continue', W/2 -80, H/2 + 20)

    if love.keyboard.isDown('return') then
      love.load()
    end
  end

  for _,entity in next, game.entities do
    entity:draw()
  end

  HealthBar(_player.spec.health, _player.spec.maxHealth)
  set_default_color()
end

function ai_thinking()
  for _,ai in next, game.ais do
    ai:think()
  end
end

function player_control()
  local dir = new(Vec) {}

  for key,control_dir in pairs(CONTROLS) do
    if love.keyboard.isDown(key) and not _player:screen_limit(key) then
      dir:translate(control_dir)
    end
  end

  _player:setDirection(dir)
end

function update_bg_elements(dt)
  background_y = background_y + (50 * dt)
  element_y = element_y + (30 * dt)

  if background_y > love.graphics.getHeight() then
    background_y = -(_background:getHeight() - H)
  end

  if element_y > love.graphics.getHeight() then
    count = count + 1
    element_y = - (_background_element:getHeight() + 100)
    _background_element = bgElements[count]
    if count == 3 then
      count = 0
    end
  end
end

function update_entities(dt)
  for _,entity in next, game.entities do
    entity:update(game.entities, dt)
  end
end

function add_easy_enemy()
  local ai = new 'ai-easy' {}
  local new_entity = Entity.load 'enemy'

  new_entity.pos:set(love.math.random() * W, 10)
  ai:setEntity(new_entity)

  game:add_entity(new_entity, ai)
end

function add_kamikaze_enemy()
  local ai = new 'ai-kamikaze' {}
  local new_entity = Entity.load 'enemy-kamikaze'

  new_entity.pos:set(love.math.random() * W, 10)
  ai:setEntity(new_entity)

  game:add_entity(new_entity, ai)
end

function set_default_color()
  love.graphics.setColor(default_color)
end
