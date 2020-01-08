-- classes
local Store = require('classes/basic/Store')
local House = require('classes/basic/House')
-- factory
local factory = require('factories/objects')
-- constants
local OBJECTS_TYPES = require('constants/objects')

local objectsStore = Store:new('objects')

function objectsStore:drawHouse(x, y, width, height, keyId)
  local collision = false
  for i = x, x + width do
    for j = y, y + height do
      collision = collisionManager:findCollision(i,j)
    end
  end
  if collision then 
    return false
  else
    House:new(x, y, width, height, keyId)
    return true
  end
end

function objectsStore:removeNothing()
  for key, val in pairs(self.items) do
    if val.name == OBJECTS_TYPES.nothing then 
      self.items[key] = nil
    end
  end
end

function objectsStore:fill()
  while(#self.items < config.objectsLimit) do
    self:startCreationCycle(factory, config.objectsLimit)
  end
end

return objectsStore