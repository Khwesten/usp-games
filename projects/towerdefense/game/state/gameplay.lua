W, H = love.graphics.getDimensions()
start = love.timer.getTime()

game_status = new 'graphics.game_status' {
  text = 'game play'
}

local spanw_count = 0
local spanw_rate = 0
local Gameplay = new 'state.base' {
  graphics = nil,
  grid = nil,
  counter = nil,
  tower_specs = nil,
  enemy_specs = nil,
  buy_buttons = nil,
  selected = 1,
  page = 1,
  page_num = 1,
  cooldown = 5
}

function Gameplay:onEnter(graphics)
  self.graphics = graphics
  self:loadTowerSpecs()
  self:loadEnemySpecs()
  self:createGrid()
  self:createBuyButtons()
  self:createArrowButtons()
  self:createCounter()
  self:changeTowers(1)
end

function Gameplay:loadTowerSpecs()
  self.tower_specs = {}
  for i,specname in require 'database' :each('towers') do
    self.tower_specs[i] = require('database.towers.' .. specname)
  end
  self.page_num = math.ceil(#self.tower_specs / 4)
end

function Gameplay:loadEnemySpecs()
  self.enemy_specs = {}
  for i,specname in require 'database' :each('enemies') do
    self.enemy_specs[i] = require('database.enemies.' .. specname)
  end
end

function Gameplay:createEnemy(i, j)
  local enemy = new 'graphics.enemy_sprite' {
      spec = self.enemy_specs[1] ,
      grid = self.grid,
      gameplay = self
    }
    if spanw_rate < (self.cooldown - 1) then
      spanw_rate = spanw_rate + 1
    end
    self.grid:put(i, 12, enemy, "enemy")
end

function Gameplay:changeTowers()
  for i=1,4 do
    local k = (self.page - 1) * 4 + i
    self.buy_buttons[i].tower_spec = self.tower_specs[k]
  end
  self:selectTower(1)
end

function Gameplay:createGrid()
  self.grid = new 'graphics.grid' {}
  self.grid.selected_callback = function(i, j) self:buildTower(i, j) end
  self.graphics:add('bg', self.grid)
end

function Gameplay:createBuyButtons()
  self.buy_buttons = {}
  local W,H = love.graphics.getDimensions()
  for i=1,4 do
    local buy_button
    buy_button = new 'graphics.buy_button' { index = i }
    buy_button.callback = function() self:selectTower(i) end
    self.buy_buttons[i] = buy_button
    self.graphics:add('gui', buy_button)
  end
end

function Gameplay:createArrowButtons()
  local W,H = love.graphics.getDimensions()
  self.graphics:add('gui', new 'graphics.arrow_button' {
    side = 'left',
    position = new(Vec) { 240 / 4, 3 * H / 4 + 40 },
    callback = function()
      self.page = math.max(1, self.page - 1)
      self:changeTowers()
    end
  })
  self.graphics:add('gui', new 'graphics.arrow_button' {
    side = 'right',
    position = new(Vec) { 3 * 240 / 4, 3 * H / 4 + 40 },
    callback = function()
      self.page = math.min(self.page_num, self.page + 1)
      self:changeTowers()
    end
  })
end

function Gameplay:createCounter()
  self.counter = new 'graphics.counter' {}
  self.counter:add(100)
  self.graphics:add('gui', self.counter)
end

function Gameplay:buildTower(i, j)
  local spec = self.buy_buttons[self.selected].tower_spec
  local tower = new 'graphics.tower_sprite' {
    spec = spec,
    grid = self.grid
  }
  if self.counter.value >= tower.spec.cost then
    self.counter.change = - tower.spec.cost
    self.grid:put(i, j, tower, "tower")
  end
  tower:shoot()
end

function Gameplay:selectTower(i)
  local button = self.buy_buttons[i]
  if button.tower_spec then
    self.buy_buttons[self.selected].selected = false
    button.selected = true
    self.selected = i
  end
end

function Gameplay:onUpdate(dt)
  spanw_count = spanw_count + dt
  if spanw_count > self.cooldown  and game_status.status ~= "GAME OVER!" then
    self:createEnemy(love.math.random(1, 6), 12)
    spanw_count = (spanw_count + spanw_rate) - self.cooldown
  end
end

return Gameplay

