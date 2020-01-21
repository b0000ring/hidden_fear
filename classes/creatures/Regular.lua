-- classes
local Creature = require('classes/basic/Creature')
local Corpse = require('classes/containers/Corpse')

local Regular = {}

function Regular:new(name, x, y, health, weapon)
  local newObj = Creature:new(name, x, y, health, weapon)
  
  function newObj:onDead()
    mediator:call('store.containers.addSpecial', Corpse:new(self.coordX, self.coordY))
    mediator:call('monster.die', {x = self.coordX, y = self.coordY})
  end
	
	self.__index = self
  return setmetatable(newObj, self)
end

return Regular
