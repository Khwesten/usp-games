local Character = new(Object) {
  spec = nil
}

function Character.load(name)
  return new(Character) {
    spec = new 'spec' (require('database.characters.'..name))
  }
end

function Character:init()
  self.sprite = self.spec.sprite
  self.currentHealth = self.spec.maxHealth
  self.maxHealth = self.spec.maxHealth
end

return Character

