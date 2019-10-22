-- classes
local Item = require('classes/basic/Item')
local Weapon = require('classes/basic/Weapon')
-- constants
local ITEMS_TYPES = require('constants/items')

local Knife = {}

function Knife:new(x, y)
  local newObj = Item:new(ITEMS_TYPES.knife, x, y)

  function newObj:action(initiator)
    initiator.weapon = Weapon:new(ITEMS_TYPES.knife, 2)
  end
	
  self.__index = self
  return setmetatable(newObj, self)
end

return Knife