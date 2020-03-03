-- classes
local Bush = require('classes/objects/Bush')
local Tree = require('classes/objects/Tree')
local Trap = require('classes/objects/Trap')
local Stone = require('classes/objects/Stone')

-- constants
local OBJECTS_TYPES = require('constants/objects')

function createObject(x, y, specific)
  local selector = math.floor(math.random(1, 100))
  if selector > 1 and selector < 5 then
    return Bush:new(x, y)
  elseif selector > 15 and selector < 25 then
    return Trap:new(x, y)
  elseif selector > 25 and selector < 30 then
    return Stone:new(x, y)
  else 
    return Tree:new(x, y)
  end

end

return createObject