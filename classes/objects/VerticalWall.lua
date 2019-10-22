-- classes
local Object = require('classes/basic/Object')
-- constants
local OBJECTS_TYPES = require('constants/objects')

local VerticalWall = {}

function VerticalWall:new(x, y)
  local newObj = Object:new(OBJECTS_TYPES.vertical_wall, x, y)

  self.__index = self
  return setmetatable(newObj, self)
end

return VerticalWall