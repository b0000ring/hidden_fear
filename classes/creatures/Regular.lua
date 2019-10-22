-- classes
local Creature = require('classes/basic/Creature')

local Regular = {}

function Regular:new(name, x, y, health, weapon)
  local newObj = Creature:new(name, x, y, health, weapon)
  
  function newObj:onDead()
    mediator:call('monster.die', {x = self.coordX, y = self.coordY})
  end
	
	self.__index = self
  return setmetatable(newObj, self)
end

return Regular
