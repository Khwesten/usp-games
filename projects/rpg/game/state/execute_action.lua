
local ExecuteAction = new 'state.base' {
  delay = 0
}

function ExecuteAction:onEnter(battle, action)
  local name, params = action.name, action.params

  executor = battle:currentCharacter()

  if name == 'attack' then
    attack_executor = executor.avatar.character.spec.attack

    local target = params.target
    battle.graphics:add('fx', new 'graphics.notification' {
      position = new(Vec) { target.avatar.position:get() },
      color = { .9, .9, .2 },
      text = "-"..attack_executor
    })

    target.avatar.character.currentHealth = target.avatar.character.currentHealth - attack_executor
    executor.avatar.character.currentStamina = 0

    self.delay = 1.0
  elseif name == 'item' then
    battle.graphics:add('fx', new 'graphics.notification' {
      position = new(Vec) { params.target.position:get() },
      color = { .2, .9, .9 },
      text = params.item
    })
  elseif name == 'stamina' then
    currentStamina = executor.avatar.character.currentStamina
    staminaRecovery = executor.avatar.character.spec.staminaRecovery

    battle.graphics:add('fx', new 'graphics.notification' {
      position = new(Vec) { executor.avatar.position:get() },
      color = { 1, 0.6, 0 },
      text = '+' .. staminaRecovery
    })

    executor.avatar.character.currentStamina = currentStamina + staminaRecovery

    self.delay = .5
  end
end

function ExecuteAction:onUpdate(dt)
  self.delay = self.delay - dt
  if self.delay <= 0 then
    self.stack:pop()
  end
end

return ExecuteAction

