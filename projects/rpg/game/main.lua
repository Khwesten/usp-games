
require 'common'

local _state_stack
local _graphics

function love.load()

  DEBUG = false

  -- Carrega fontes de texto usadas no jogo
  local font_loader = require 'graphics.font_loader'
  font_loader:load("regular", "assets/fonts/VT323-Regular.ttf")

  -- Cria gerenciador de gráficos
  _graphics = new 'graphics' {
    layers = { 'bg', 'cursor', 'entities', 'gui', 'fx' }
  }
  love.graphics.setBackgroundColor(.05, .05, .05)

  -- Cria uma nova pilha de estados e empilha o estado principal
  _state_stack = new 'state.stack' {}
  _state_stack:push('battle', _graphics)

end

function love.update(dt)
  _state_stack:getCurrentState():onUpdate(dt)
  _graphics:update(dt)
end

function love.draw()
  _graphics:drawLayers()
end

function love.keypressed(key)
  _graphics:onKeyPressed(key)
end

