-- classes
local Monster = require('classes/creatures/Monster')
local Zombie = require('classes/creatures/Zombie')

function createCreature(x,y)
  if math.floor(math.random() + 0.5) == 1 then
    return Monster:new(x,y)
  else
    return Zombie:new(x,y)
  end
end

return createCreature