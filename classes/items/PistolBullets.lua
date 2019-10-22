-- classes
local Item = require('classes/basic/Item')
-- constants
local ITEMS_TYPES = require('constants/items')

local PistolBullets = {}

function PistolBullets:new(x, y)
  local newObj = Item:new(ITEMS_TYPES.pistol_bullets, x, y)

  function newObj:action(initiator)
    initiator.bullets.pistol = initiator.bullets.pistol + 10
  end
	
  self.__index = self
  return setmetatable(newObj, self)
end

return PistolBullets