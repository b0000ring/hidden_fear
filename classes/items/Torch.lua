-- classes
local Item = require('classes/basic/Item')
-- constants
local ITEMS_TYPES = require('constants/items')

local Torch = {}

function Torch:new(x, y)
  local newObj = Item:new(ITEMS_TYPES.torch, x, y)

  function newObj:action(initiator)
    table.insert(initiator.items, ITEMS_TYPES.torch)
  end
	
  self.__index = self
  return setmetatable(newObj, self)
end

return Torch