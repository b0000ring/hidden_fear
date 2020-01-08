-- classes
local Bush = require('classes/objects/Bush')
local Tree = require('classes/objects/Tree')
local Trap = require('classes/objects/Trap')
local Darkness = require('classes/objects/Darkness')

-- constants
local OBJECTS_TYPES = require('constants/objects')

function createObject(x, y, specific)
  if specific then
    if specific == OBJECTS_TYPES.tree  then
      return Tree:new(x, y)
    end
  end
  if math.floor(math.random(1, 20)) == 1 then
    return Bush:new(x, y)
  elseif  math.floor(math.random(1, 20)) == 2 then
    return Trap:new(x, y)
  else 
    return Tree:new(x, y)
  end

end

return createObject