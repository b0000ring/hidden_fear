local Something = require('classes/basic/Something')
local TAGS = require('constants/tags')

local Item = {}

function Item:new(name, coordX, coordY, health, tags)
  local newObj = Something:new(name, coordX, coordY, health, {[TAGS.pickupable] = true})
  
  function newObj:action()
    error('using default Item action')
  end
	
  self.__index = self
  return setmetatable(newObj, self)
end

return Item