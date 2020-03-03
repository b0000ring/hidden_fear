-- classes
local Regular = require('classes/creatures/Regular')
-- constants 
local CREATURES_TYPES = require('constants/creatures')
-- collections
local weapons = require('collections/weapons')

local Necromancer = {}

function Necromancer:new(x,y)
  local newObj = Regular:new(CREATURES_TYPES.necromancer, x, y, 5, weapons.magic)
	
	self.__index = self
  return setmetatable(newObj, self)
end

return Necromancer
