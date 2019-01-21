-- json = require 'dkjson'
-- debuggee = require 'vscode-debuggee'
-- startResult, breakerType = debuggee.start(json)

-- print('debuggee start ->', startResult, breakerType)

-- xpcall(
--   function()
--     -- Code to actually run
--     local a = 1 + nil
--   end,
--   function(e)
--     if debuggee.enterDebugLoop(1, e) then
--       -- ok
--     else
--       -- If the debugger is not attached, enter here.
--       print(e)
--       print(debug.traceback())
--     end
--   end
-- )

require 'common'
require 'score'
local Entity = require 'entity'

local _easy_enemy_timer
local _kamikaze_enemy_timer

function love.load()
  game_debug_mode = true
  default_color = { 1, 1, 1 }

  score = new(Score) {}

  W, H = love.graphics.getDimensions()

  _ais = {}
  _entities = {}
  _objects_on_screen = 0
  _easy_enemy_timer = 0
  _kamikaze_enemy_timer = 0
  _player = Entity.load 'player'
  _player.pos:set(W/2, 9*H/10)

  add_entity(_player)
end

local CONTROLS = {
  up = new(Vec) { 0, -1 },
  down = new(Vec) { 0, 1 },
  left = new(Vec) { -1, 0 },
  right = new(Vec) { 1, 0 },
}

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
end

function love.draw()
  if game_debug_mode then
    love.graphics.print(_objects_on_screen, 10, H - 20)
  end

  score:print()

  if _player.spec.health <= 0 then
    love.graphics.print('GAME OVER', W/2 - 40, H/2)
    love.graphics.print('Press return to continue', W/2 -80, H/2 + 20)

    if love.keyboard.isDown('return') then
      love.load()
    end
  end

  for _,entity in next, _entities do
    entity:draw()
  end
end

function ai_thinking()
  for _,ai in next, _ais do
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

function update_entities(dt)
  for _,entity in next, _entities do
    entity:update(_entities, dt)
  end
end

function add_easy_enemy()
  local ai = new 'ai-easy' {}
  local new_entity = Entity.load 'enemy'

  new_entity.pos:set(love.math.random() * W, 10)
  ai:setEntity(new_entity)

  add_entity(new_entity, ai)
end

function add_kamikaze_enemy()
  local ai = new 'ai-kamikaze' {}
  local new_entity = Entity.load 'enemy-kamikaze'

  new_entity.pos:set(love.math.random() * W, 10)
  ai:setEntity(new_entity)

  add_entity(new_entity, ai)
end

function add_entity(entity, ai)
  _entities[entity.id] = entity

  if ai then
    _ais[entity.id] = ai
  end

  _objects_on_screen = _objects_on_screen + 1
end

function remove_entity(entity)
  if _ais[entity.id] then
    _ais[entity.id] = nil
  end

  _entities[entity.id] = nil

  _objects_on_screen = _objects_on_screen - 1
end

function set_default_color()
  love.graphics.setColor(default_color)
end
