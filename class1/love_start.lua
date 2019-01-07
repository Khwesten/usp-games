local i, a

function love.load(args)
  i = tonumber(args[1]) or 5
  a = 0
end

function love.draw()
  love.graphics.print("Flw galera!", 50, 50)
  love.graphics.print("time: " .. i, 100, 100)
  love.graphics.polygon('line', 0, 10, 10, 10, 10, 0, 0, 0)
  love.graphics.polygon('fill', 10 + a, 20 + a, 20 + a, 20 + a, 20 + a, 10 + a, 10 + a, 10 + a)
end

function love.update(dt)
  i = i - dt
  if i <= 0 then love.event.quit() end

  a = a + 2
end