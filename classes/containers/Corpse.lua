-- classes
local Container = require('classes/basic/Container')
-- constants
local CONTAINERS_TYPES = require('constants/containers')

local Corpse = {}

function Corpse:new(x,y)
  local newObj = Container:new(CONTAINERS_TYPES.corpse, x, y, false)
  
  self.__index = self
  return setmetatable(newObj, self)
end

return Corpse