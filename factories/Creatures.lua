-- classes
local Monster = require('classes/creatures/Monster')
local Zombie = require('classes/creatures/Zombie')
local Imp = require('classes/creatures/Imp')

function createCreature(x,y)
  local selector = math.random(1,3)
  if selector == 1 then
    return Monster:new(x,y)
  elseif selector == 2 then
    return Zombie:new(x,y)
  elseif selector == 3 then
    return Imp:new(x,y)
  end
end

return createCreature