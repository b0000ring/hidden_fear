local Weapon = {}

function Weapon:new(name, power, bullets)
  return {
    name = name,
    power = power,
    bullets = bullets
  }
end

return Weapon