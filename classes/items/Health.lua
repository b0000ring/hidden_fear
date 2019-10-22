-- classes
local Item = require('classes/basic/Item')
-- constants
local ITEMS_TYPES = require('constants/items')

local Health = {}

function Health:new(x,y)
  local newObj = Item:new(ITEMS_TYPES.health, x, y)
  
  function newObj:action(initiator)
    initiator.heals = initiator.heals + 1
  end
	
  self.__index = self
  return setmetatable(newObj, self)
end

return Health