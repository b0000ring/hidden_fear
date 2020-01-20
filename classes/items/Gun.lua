-- classes
local Item = require('classes/basic/Item')
-- constants
local WEAPONS_TYPES = require('constants/weapons')

local Gun = {}

function Gun:new(type, isUsed, x, y)
  local newObj = Item:new(type, x, y)

  newObj.isUsed = isUsed or false

  function newObj:action(initiator)
    if initiator.weapon.name ~= WEAPONS_TYPES.fists then
      initiator:dropWeapon()()
    end
    self:addWeapon(initiator)
    if not isUsed then
      self:addBullets(initiator)
    end
  end
	
  self.__index = self
  return setmetatable(newObj, self)
end

return Gun