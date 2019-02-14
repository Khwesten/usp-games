
local Battle = new 'state.base' {
  graphics = nil,
  current_party = 'right',
  current_char = 1,
  next_action = nil,
  delay = 0
}

local round = 1

function Battle:onEnter(graphics)
  self.graphics = graphics
  graphics:add('bg', new 'graphics.arena' {})
  self:loadParty('right', 'heroes')
  self:loadParty('left', 'slimes01')
end

function Battle:loadParty(side, name)
  local W, H = love.graphics.getDimensions()
  local charnames = require('database.parties.' .. name)
  local party = {
    characters = {}
  }
  for i, charname in ipairs(charnames) do
    local x
    if side == 'right' then x = W - 480 + 80 * i
    elseif side == 'left' then x = 480 - 80 * i end
    party.characters[i] = {
      avatar = new 'graphics.avatar' {
        charactername = charname,
        side = side,
        position = new(Vec) { x, i * 120 },
        drawables = {}
      }
    }
    self.graphics:add('entities', party.characters[i].avatar)
  end
  self[side] = party
end

function Battle:onResume()
  if self.next_action then
      self.stack:push('execute_action', self, self.next_action)
      self.next_action = nil
  end
  if self:currentCharacter() then
    self:currentCharacter().avatar:hideCursor()

    if self.current_party == 'right' then
      self.current_char = self.current_char % #self.right.characters + 1
    else
      self.current_char = self.current_char % #self.left.characters + 1
    end
  end
end

function Battle:onUpdate(dt)
  self:removeDeadCharacters(self.right.characters)
  self:removeDeadCharacters(self.left.characters)
  if #self.right.characters == 0 then
    self.stack:push('game_over', self.graphics)
  end
  if round > table.getn(self[self.current_party].characters) then
    if self.current_party == 'left' then
      self.current_party = 'right'
    else
      self.current_party = 'left'
    end

    self.current_char = 1
    round = 1

    return
  else
    round = round + 1
  end
  self:currentCharacter().avatar:showCursor()

  if self:currentCharacter().avatar.charactername == 'slime' then
    rand_characters = { self.right.characters[love.math.random(#self['right'].characters)] }
    attack_action = {
      name = 'attack',
      params = { target = rand_characters[1] }
    }

    self.stack:push('choose_target', self, rand_characters)
    self.stack:push('execute_action', self, attack_action)
  else
    executor = self:currentCharacter()
    currentStaminaExecutor = executor.avatar.character.currentStamina

    if currentStaminaExecutor >= 100 then
      self.stack:push('choose_action', self)
    else
      self.stack:push('execute_action', self, { name = 'stamina' })
    end
  end
end

function Battle:removeDeadCharacters(party)
  local charsToBeRemoved = {}
  for i, char in ipairs(party) do
    if char.avatar.character.currentHealth <= 0 then
      charsToBeRemoved[i] = true
    end
  end
  for i=#party,1,-1 do
    if charsToBeRemoved[i] then
      party[i].avatar:destroy()
      table.remove(party, i)
    end
  end
end

function Battle:currentCharacter()
  return self[self.current_party].characters[self.current_char]
end

function Battle:setNextAction(name, params)
  self.next_action = {
    name = name,
    params = params
  }
end

return Battle

