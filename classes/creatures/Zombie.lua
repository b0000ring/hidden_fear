-- classes
local Regular = require('classes/creatures/Regular')
-- constants
local CREATURES_TYPES = require('constants/creatures')
-- collections
local weapons = require('collections/weapons')

local Zombie = {}

function Zombie:new(x,y)
  local newObj = Regular:new(CREATURES_TYPES.zombie, x, y, 7, weapons.teeths)
	
	self.__index = self
  return setmetatable(newObj, self)
end

return Zombie
