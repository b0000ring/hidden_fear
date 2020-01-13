-- classes
local Boss = require('classes/creatures/Boss')
local Shotgun = require('classes/items/Shotgun')
local Key = require('classes/items/Key')
local Bush = require('classes/objects/Bush')
local Laser = require('classes/items/Laser')
local Field = require('classes/basic/Field')
local Fog = require('classes/containers/Fog')
local Water = require('classes/objects/Water')
-- constants
local KEYS = require('constants/keys')
local OBJECTS_TYPES = require('constants/objects') 

function drawMansion(objectsStore)
  local x = math.random(config.mapPadding + 1, config.mapWidth - config.mapPadding - 20)
  local y = math.random(config.mapPadding + 1, config.mapHeight - config.mapPadding - 20)
  local result = objectsStore:drawHouse(x, y, math.random(10, 20), math.random(10, 20), KEYS.mansion)
  if not result then
    return drawMansion(objectsStore)
  end
end

function drawField(Obj, store)
  local x = math.random(1, config.mapWidth)
  local y = math.random(1, config.mapHeight)
  local width = math.random(5, 15)
  local height = math.random(5, 15)
  
  Field:new(x, y, width, height, Obj, store)
end

function drawBarn(objectsStore)
  local x = math.random(config.mapPadding + 1, config.mapWidth - config.mapPadding - 20)
  local y = math.random(config.mapPadding + 1, config.mapHeight - config.mapPadding - 20)
  local result = objectsStore:drawHouse(x, y, math.random(4, 6), math.random(4, 6), KEYS.barn)
  if not result then
    return drawBarn(objectsStore)
  end
end

function createBarnKey(itemsStore)
  local x = math.random(config.mapPadding + 1, config.mapWidth - config.mapPadding - 1)
  local y = math.random(config.mapPadding + 1, config.mapHeight - config.mapPadding - 1)
  itemsStore.items[#itemsStore.items + 1] = Key:new(KEYS.barn, x, y)
end

function createShotgun(itemsStore, x ,y) 
  itemsStore.items[#itemsStore.items + 1] = Shotgun:new(x, y)
end

function createBoss(creaturesStore, x, y)
  creaturesStore.items[#creaturesStore.items + 1] = Boss:new(x, y)
end

function placeSecretLaser(itemsStore, objectsStore)
  local x = math.random(config.mapPadding + 1, config.mapWidth - config.mapPadding - 1)
  local y = math.random(config.mapPadding + 1, config.mapHeight - config.mapPadding - 1)
  objectsStore.items[#itemsStore.items + 1] = Bush:new(x, y)
  itemsStore.items[#itemsStore.items + 1] = Laser:new(x, y)
end

function loadGame(creaturesStore, itemsStore, objectsStore, containersStore)
  for i = 1, math.random(5,10) do
    drawField(Fog, 'containers')
  end

  for i = 1, 2 do
    drawField(Water, 'objects')
  end

  drawMansion(objectsStore)
  drawBarn(objectsStore)
  createBarnKey(itemsStore)

  placeSecretLaser(itemsStore, objectsStore)

  objectsStore:fill()
  creaturesStore:fill()
  itemsStore:fill()
  containersStore:fill()
  objectsStore:removeNothing()

  local mansionCoords = nil
  local barnCoords = nil

  for key, val in pairs(objectsStore.items) do
    if val.name == OBJECTS_TYPES.door and val.keyId == KEYS.mansion then
      mansionCoords = { x = val.coordX, y = val.coordY }
    end

    if val.name == OBJECTS_TYPES.door and val.keyId == KEYS.barn then
      barnCoords = { x = val.coordX, y = val.coordY }
    end
  end

  -- prevent doors blocking
  for key, val in pairs(objectsStore.items) do
    if (val.coordX + 1 == mansionCoords.x and val.coordY == mansionCoords.y) or 
        (val.coordX + 1 == barnCoords.x and val.coordY == barnCoords.y) then
      objectsStore.items[key] = nil
    end
  end
  
  createShotgun(itemsStore, barnCoords.x + 2, barnCoords.y)
  createBoss(creaturesStore, mansionCoords.x + 2, mansionCoords.y)
end

return loadGame