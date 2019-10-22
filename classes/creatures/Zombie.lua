-- classes
local Creature = require('classes/basic/Creature')
-- constants
local CREATURES_TYPES = require('constants/creatures')
-- collections
local weapons = require('collections/weapons')

local Zombie = {}

function Zombie:new(x,y)
  local newObj = Creature:new(CREATURES_TYPES.zombie, x, y, 7, weapons.teeths)
	
	self.__index = self
  return setmetatable(newObj, self)
end

return Zombie
