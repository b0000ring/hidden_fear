-- classes
local Store = require('classes/basic/Store')
local Key = require('classes/items/Key')
local Axe = require('classes/items/Axe')
-- constants
local ITEMS_TYPES = require('constants/items') 
local KEYS = require('constants/keys')
-- factory
local factory = require('factories/items')

local itemsStore = Store:new('items')

local itemsFillList = {
  [ITEMS_TYPES.pistol] = config.pistolLimit,
  [ITEMS_TYPES.pistol_bullets] = config.pistolBulletsLimit,
  [ITEMS_TYPES.shotgun] = config.shotgunLimit,
  [ITEMS_TYPES.shotgun_bullets] = config.shotgunBulletsLimit,
  [ITEMS_TYPES.knife] = config.knifeLimit,
  [ITEMS_TYPES.health] = config.healthLimit
}

function itemsStore:createAxe()
  local x = math.random(config.mapPadding + 1, config.mapWidth - config.mapPadding - 1)
  local y = math.random(config.mapPadding + 1, config.mapHeight - config.mapPadding - 1)
  self.items[#self.items + 1] = Axe:new(51, 51)
end

function itemsStore:fill()
  self:createAxe()
  for type in pairs(itemsFillList) do
    local items = {}
    while(#items < itemsFillList[type]) do
      self:startCreationCycle(factory, itemsFillList[type], type, items)
    end  
    for k,v in pairs(items) do table.insert(self.items, v) end
  end
end

function itemsStore:createFinalKey(x, y)
  self.items[#self.items + 1] = Key:new(KEYS.mansion, x, y)
end

function itemsStore:startCreationCycle(factory, limit, type, items)
  for i = config.mapPadding, config.mapWidth - config.mapPadding do
    for j = config.mapPadding, config.mapHeight - config.mapPadding do
      if #items < limit then
        if math.floor(math.random(0,1000)) == 1 and not collisionManager:findCollision(i,j) then
          items[#items + 1] = factory(type, i, j)
        end
      else
        return
      end
    end
  end 
end

return itemsStore