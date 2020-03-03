-- classes
local Monster = require('classes/creatures/Monster')
local Zombie = require('classes/creatures/Zombie')
local Imp = require('classes/creatures/Imp')
local Necromancer = require('classes/creatures/Necromancer')

function createCreature(x,y)
  local selector = math.random(1,4)
  if selector == 1 then
    return Monster:new(x,y)
  elseif selector == 2 then
    return Zombie:new(x,y)
  elseif selector == 3 then
    return Imp:new(x,y)
  elseif selector == 4 then
    return Necromancer:new(x,y)
  end
end

return createCreature