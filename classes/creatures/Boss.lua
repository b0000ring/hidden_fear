-- classes
local Creature = require('classes/basic/Creature')
-- constants
local CREATURES_TYPES = require('constants/creatures')
-- collections
local weapons = require('collections/weapons')

local Boss = {}

function Boss:new(x,y)
  local newObj = Creature:new(CREATURES_TYPES.boss, x, y, 30, weapons.magic)

  function newObj:onDead()
    mediator:call('boss.dead')
  end
	
	self.__index = self
  return setmetatable(newObj, self)
end

return Boss
