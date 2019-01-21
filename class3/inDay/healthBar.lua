
local function controlColor(health, maxHealth)
  if health >= maxHealth/2 then
    love.graphics.setColor(0, 1, 0)
  end
  if health < maxHealth/2 and health >= maxHealth/4 then
    love.graphics.setColor(196, 196, 0)
  end
  if health < maxHealth/4 then
    love.graphics.setColor(1, 0, 0)
  end
end

local function healthBar(health, maxHealth)
  _currentHealth = health*2
  if health <= 0 then _currentHealth = 0 end
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle('fill', 10, 10, maxHealth*2, 15)
  controlColor(health, maxHealth)
  love.graphics.rectangle('fill', 10, 10, _currentHealth, 15)
  love.graphics.rectangle('line', 10, 10, maxHealth*2, 15)
end

return healthBar
