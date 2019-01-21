
local Score = new(Object) {}

local SCORE_RIGHT_MARGIN = 20

function Score:init()
  local font = love.graphics.getFont()

  self.score = 0
  self.text = 'score: ' .. self.score
  self.graphic_text = love.graphics.newText(font, self.text)
end

function Score:print()
  local W,H = love.graphics.getDimensions()

  love.graphics.print(self.text, W - (self.graphic_text:getWidth() + SCORE_RIGHT_MARGIN), 10)
end

function Score:add_one()
  local font = love.graphics.getFont()

  self.score = self.score + 1
  self.text = 'score: ' .. self.score
  self.graphic_text = love.graphics.newText(font, self.text)
end

return Score
