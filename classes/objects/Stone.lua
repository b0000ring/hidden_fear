-- classes
local Object = require('classes/basic/Object')
-- constants
local OBJECTS_TYPES = require('constants/objects')

local Stone = {}

function Stone:new(x, y)
  local newObj = Object:new(OBJECTS_TYPES.stone, x, y)

  self.__index = self
  return setmetatable(newObj, self)
end

return Stone