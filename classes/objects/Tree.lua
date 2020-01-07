-- classes
local Object = require('classes/basic/Object')
-- constants
local OBJECTS_TYPES = require('constants/objects')
local TAGS = require('constants/tags')

local Tree = {}

function Tree:new(x,y)
  local newObj = Object:new(OBJECTS_TYPES.tree, x, y, {[TAGS.blocking] = true, [TAGS.cutable] = true})
  newObj.health = 3
  
  self.__index = self
  return setmetatable(newObj, self)
end

return Tree