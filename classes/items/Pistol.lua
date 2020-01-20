-- classes
local Gun = require('classes/items/Gun')
-- collections
local weapons = require('collections/weapons')
-- constants
local ITEMS_TYPES = require('constants/items')

local Pistol = {}

function Pistol:new(x, y, isUsed)
  local newObj = Gun:new(ITEMS_TYPES.pistol, isUsed , x, y)

  function newObj:addWeapon(initiator)
    initiator.weapon = weapons.pistol
  end

  function newObj:addBullets(initiator)
    initiator.bullets.pistol = initiator.bullets.pistol + 10
  end
	
  self.__index = self
  return setmetatable(newObj, self)
end

return Pistol