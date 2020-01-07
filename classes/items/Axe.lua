-- classes
local Item = require('classes/basic/Item')
-- constants
local ITEMS_TYPES = require('constants/items')

local Axe = {}

function Axe:new(x, y)
  local newObj = Item:new(ITEMS_TYPES.axe, x, y)

  function newObj:action(initiator)
    table.insert(initiator.items, ITEMS_TYPES.axe)
  end
	
  self.__index = self
  return setmetatable(newObj, self)
end

return Axe