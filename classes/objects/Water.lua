-- classes
local Object = require('classes/basic/Object')
-- constants
local OBJECTS_TYPES = require('constants/objects')
local TAGS = require('constants/tags')

local Water = {}

function Water:new(x,y)
  local newObj = Object:new(OBJECTS_TYPES.water, x, y, {[TAGS.blocking] = true})
  
  self.__index = self
  return setmetatable(newObj, self)
end

return Water