local Something = require('classes/basic/Something')
local TAGS = require('constants/tags')

local Container = {}

function Container:new(name, coordX, coordY, overlapping)
  local newObj = Something:new(name, coordX, coordY, 1)
  newObj.overlapping = overlapping
  
  self.__index = self
  return setmetatable(newObj, self)
end

return Container