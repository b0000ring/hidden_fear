-- classes
local Store = require('classes/basic/Store')
-- constants
local CONTAINERS_TYPES = require('constants/containers') 
local KEYS = require('constants/keys')
-- factory
local factory = require('factories/containers')

local containersStore = Store:new('containers')

function containersStore:fill()
  while(#self.items < config.effectsLimit) do
    self:startCreationCycle(factory, config.effectsLimit)
  end
end

return containersStore