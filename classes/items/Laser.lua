-- classes
local Item = require('classes/basic/Item')
-- collections
local weapons = require('collections/weapons')
-- constants
local ITEMS_TYPES = require('constants/items')

local Laser = {}

function Laser:new(x, y)
  local newObj = Item:new(ITEMS_TYPES.laser, x, y)

  function newObj:action(initiator)
    initiator.weapon = weapons.laser
  end
	
  self.__index = self
  return setmetatable(newObj, self)
end

return Laser