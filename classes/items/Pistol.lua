-- classes
local Item = require('classes/basic/Item')
-- collections
local weapons = require('collections/weapons')
-- constants
local ITEMS_TYPES = require('constants/items')

local Pistol = {}

function Pistol:new(x, y)
  local newObj = Item:new(ITEMS_TYPES.pistol, x, y)

  function newObj:action(initiator)
    initiator.weapon = weapons.pistol
    initiator.bullets.pistol = initiator.bullets.pistol + 10
  end
	
  self.__index = self
  return setmetatable(newObj, self)
end

return Pistol