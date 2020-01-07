-- classes
local Regular = require('classes/creatures/Regular')
-- constants 
local CREATURES_TYPES = require('constants/creatures')
-- collections
local weapons = require('collections/weapons')

local Monster = {}

function Monster:new(x,y)
  local newObj = Regular:new(CREATURES_TYPES.imp, x, y, 10, weapons.batWithNails)
	
	self.__index = self
  return setmetatable(newObj, self)
end

return Monster
