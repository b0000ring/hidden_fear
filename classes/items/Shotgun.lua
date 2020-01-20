-- classes
local Gun = require('classes/items/Gun')
-- collections
local weapons = require('collections/weapons')
-- constants
local ITEMS_TYPES = require('constants/items')

local Shotgun = {}

function Shotgun:new(x, y, isUsed)
  local newObj = Gun:new(ITEMS_TYPES.shotgun, isUsed, x, y)

  function newObj:addWeapon(initiator)
    initiator.weapon = weapons.shotgun
  end

  function newObj:addBullets(initiator)
    initiator.bullets.shotgun = initiator.bullets.shotgun + 10
  end
	
  self.__index = self
  return setmetatable(newObj, self)
end

return Shotgun