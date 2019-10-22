-- classes
local Object = require('classes/basic/Object')
-- constants
local OBJECTS_TYPES = require('constants/objects')

local HorizontalWall = {}

function HorizontalWall:new(x, y)
  local newObj = Object:new(OBJECTS_TYPES.horizontal_wall, x, y)

  self.__index = self
  return setmetatable(newObj, self)
end

return HorizontalWall