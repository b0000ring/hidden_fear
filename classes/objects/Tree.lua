-- classes
local Object = require('classes/basic/Object')
-- constants
local OBJECTS_TYPES = require('constants/objects')

local Tree = {}

function Tree:new(x,y)
  local newObj = Object:new(OBJECTS_TYPES.tree, x, y)

  self.__index = self
  return setmetatable(newObj, self)
end

return Tree