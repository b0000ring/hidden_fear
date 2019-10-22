-- classes
local Item = require('classes/basic/Item')
-- constants
local ITEMS_TYPES = require('constants/items')

local ShotgunBullets = {}

function ShotgunBullets:new(x, y)
  local newObj = Item:new(ITEMS_TYPES.shotgun_bullets, x, y)

  function newObj:action(initiator)
    initiator.bullets.shotgun = initiator.bullets.shotgun + 10
  end
	
  self.__index = self
  return setmetatable(newObj, self)
end

return ShotgunBullets