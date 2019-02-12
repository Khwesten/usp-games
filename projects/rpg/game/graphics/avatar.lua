local Character = require 'graphics.character'

local Avatar = new 'graphics.composite' {
  charactername = 'slime',
  side = 'right',
  counter = 0
}

local COLORS = {
  right = { .6, .6, .9 },
  left = { .9, .6, .6 }
}

local BARS = {
  right = 'graphics.leftbar',
  left = 'graphics.rightbar'
}

local STAMINA_BARS = {
  left = 'graphics.staminaleftbar',
  right = 'graphics.staminarightbar'
}

function Avatar:init()
  self.character = Character.load(self.charactername)
  self.sprite = new 'graphics.sprite' {
    filename = self.character.sprite,
    color = COLORS[self.side],
    position = new(Vec) {}
  }

  self.lifebar = new(BARS[self.side]) {
    color = { .2, .8, .2 },
    value = 1
  }

  self.staminabar = new(STAMINA_BARS[self.side]) {
    value = 1
  }

  self.cursor = new 'graphics.polygon' {
    position = new(Vec) { 0, -64 },
    vertices = { -16, 0, 16, 0, 0, 20 },
    visible = false
  }

  self:add(new 'graphics.shadow' { position = new(Vec) { 0, 48 } })
  self:add(self.sprite)
  self:add(self.lifebar)
  self:add(self.staminabar)
  self:add(self.cursor)
  self.counter = love.math.random() * 2 * math.pi
end

function Avatar:showCursor()
  self.cursor.visible = true
end

function Avatar:hideCursor()
  self.cursor.visible = false
end

function Avatar:update(dt)
  self.counter = self.counter + 5 * dt
  self.sprite.position.y = 4 * math.sin(self.counter)

  self.lifebar.value = self:getHealthPercentage()
  self.staminabar.value = self.character.currentStamina * 0.01
end

function Avatar:getHealthPercentage()
  if self.character.currentHealth <= 0 then
    return 0
  else
    return ((self.character.currentHealth * 100) / self.character.maxHealth) * 0.01
  end
end

return Avatar

