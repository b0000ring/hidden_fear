-- classes
local Object = require('classes/basic/Object')
-- constants
local OBJECTS_TYPES = require('constants/objects')
local CREATURES_TYPES = require('constants/creatures')
local TAGS = require('constants/tags')

local Trap = {}

function Trap:new(x, y)
  local newObj = Object:new(OBJECTS_TYPES.trap, x, y, {[TAGS.effect] = true})

  function newObj:action(initiator)
    if initiator.name == CREATURES_TYPES.player then
      initiator.mental = -1
      self.health = 0
    end
  end
	
  self.__index = self
  return setmetatable(newObj, self)
end

return Trap