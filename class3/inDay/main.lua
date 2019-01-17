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
local Entity = require 'entity'

local _player
local _entity_timer

function love.load()
  W, H = love.graphics.getDimensions()

  _ais = {}
  _entities = {}
  _objects_on_screen = 0
  _entity_timer = 0
  _player = Entity.load 'player'
  _player.pos:set(W/2, 9*H/10)

  love.graphics.print(_player.id, 100, 100)

  add_entity(_player)
end

local CONTROLS = {
  up = new(Vec) { 0, -1 },
  down = new(Vec) { 0, 1 },
  left = new(Vec) { -1, 0 },
  right = new(Vec) { 1, 0 },
}

function love.update(dt)
  -- Update entity timer
  _entity_timer = _entity_timer + dt

  if _entity_timer >= 2 then
    -- Reseta contador
    _entity_timer = 0

    local ai = new 'ai' {}
    local W = love.graphics.getDimensions()
    local new_entity = Entity.load 'enemy'

    new_entity.pos:set(love.math.random() * W, 10)
    ai:setEntity(new_entity)

    add_entity(new_entity, ai)
  end

  -- AI control
  for _,ai in next, _ais do
    ai:think()
  end

  -- Player control
  local dir = new(Vec) {}
  local half_screen = love.graphics.getWidth()

  for key,control_dir in pairs(CONTROLS) do
    if love.keyboard.isDown(key) then
      if not _player:screen_limit() then
        dir:translate(control_dir)
      end
    end
  end

  _player:setDirection(dir)

  -- Update entities
  for _,entity in next, _entities do
    entity:update(_entities, dt)
  end
end

function love.draw()
  love.graphics.print(_objects_on_screen, 10, 10)
  love.graphics.print(_player.health, 370, 10)
  if _player.health <= 0 then
    love.graphics.print('GAME OVER', W/2 - 40, H/2)
    love.graphics.print('Press space to continue', W/2 -80, H/2 + 20)
    if love.keyboard.isDown('space') then
      love.load()
    end
  end
  for _,entity in next, _entities do
    entity:draw()
  end
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
