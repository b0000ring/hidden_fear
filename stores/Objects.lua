-- classes
local Store = require('classes/basic/Store')
local House = require('classes/basic/House')
-- factory
local factory = require('factories/objects')
-- constants
local OBJECTS_TYPES = require('constants/objects')

local objectsStore = Store:new('objects')

function objectsStore:fillBorders()
  self.border_items = {}
  for i = 1, config.mapWidth do
    for j = 1, config.mapHeight do
      if(config.mapPadding + 1 - i > 0 or config.mapPadding + 1 - j > 0 or (config.mapWidth - config.mapPadding - 1) < i or (config.mapHeight - config.mapPadding - 1) < j) then
        self.border_items[#self.border_items + 1] = factory(i, j, OBJECTS_TYPES.tree)
      end
    end
  end
end

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
  self:fillBorders()

  while(#self.items < config.objectsLimit) do
    self:startCreationCycle(factory, config.objectsLimit)
  end
  
  for k,v in pairs(self.border_items) do table.insert(self.items, v) end
end

return objectsStore