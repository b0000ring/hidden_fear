-- classes
local Container = require('classes/basic/Container')
-- constants
local CONTAINERS_TYPES = require('constants/containers')

local Floor = {}

function Floor:new(x,y)
  local newObj = Container:new(CONTAINERS_TYPES.floor, x, y, false)
  
  self.__index = self
  return setmetatable(newObj, self)
end

return Floor