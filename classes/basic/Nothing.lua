-- classes
local Object = require('classes/basic/Object')
-- constants
local OBJECT_TYPES = require('constants/objects')

local Nothing = {}

function Nothing:new(x, y)
  local newObj = Object:new()
  newObj.name = OBJECT_TYPES.nothing
  newObj.tags = {}
  newObj.coordX = x
  newObj.coordY = y

  self.__index = self
  return setmetatable(newObj, self)
end

return Nothing