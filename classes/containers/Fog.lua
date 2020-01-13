-- classes
local Container = require('classes/basic/Container')
-- constants
local CONTAINERS_TYPES = require('constants/containers')

local Fog = {}

function Fog:new(x,y)
  local newObj = Container:new(CONTAINERS_TYPES.fog, x, y, true)
  
  self.__index = self
  return setmetatable(newObj, self)
end

return Fog