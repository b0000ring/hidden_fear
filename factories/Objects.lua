-- classes
local Bush = require('classes/objects/Bush')
local Tree = require('classes/objects/Tree')
-- constants
local OBJECTS_TYPES = require('constants/objects')

function createObject(x,y, specific)
  if (specific and specific ~= OBJECTS_TYPES.tree) or (not specific and math.floor(math.random(1, 20)) == 1) then
    return Bush:new(x,y)
  else
    return Tree:new(x,y)
  end
end

return createObject