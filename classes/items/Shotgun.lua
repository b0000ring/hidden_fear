-- classes
local Item = require('classes/basic/Item')
-- collections
local weapons = require('collections/weapons')
-- constants
local ITEMS_TYPES = require('constants/items')

local Shotgun = {}

function Shotgun:new(x,y)
  local newObj = Item:new(ITEMS_TYPES.shotgun, x, y)

  function newObj:action(initiator)
    initiator.weapon = weapons.shotgun
    initiator.bullets.shotgun = initiator.bullets.shotgun + 5
  end
	
  self.__index = self
  return setmetatable(newObj, self)
end

return Shotgun