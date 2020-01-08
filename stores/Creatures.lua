-- classes
local Store = require('classes/basic/Store')
local Player = require('classes/creatures/Player')
-- factory
local factory = require('factories/creatures')
-- constants
local CREATURES_TYPES = require('constants/creatures')

local creaturesStore = Store:new('creatures')

function creaturesStore:findPlayer()
  for key, val in pairs(self.items) do
    if val.name == CREATURES_TYPES.player then
      return val
    end
  end
end

function creaturesStore:createPlayer()
  local x = math.random(config.mapPadding + 1, config.mapWidth - config.mapPadding - 1)
  local y = math.random(config.mapPadding + 1, config.mapHeight - config.mapPadding - 1)
  if not collisionManager:findCollision(x, y) then
    self.items[#self.items + 1] = Player:new(x, y)
    return
  end
  self:createPlayer()
end

function creaturesStore:makeActions()
  local player = self:findPlayer()
  local playerCoords = {x = 0, y = 0}
  if player.hiddenSteps == 0 then
    playerCoords = player:getCoords()
  end
  for key, item in pairs(self.items) do
    local direction = item:getDirection(playerCoords)
    if direction then
      item:move(direction.direction, direction.value)()
    end
  end
end

function creaturesStore:fill()
  while(#self.items < config.creaturesLimit) do
    self:startCreationCycle(factory, config.creaturesLimit)
  end
  -- player creating
  self:createPlayer()
end

return creaturesStore