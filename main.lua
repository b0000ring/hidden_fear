-- global
config = require('config')
mediator = require('mediator')
collisionManager = require('collisionManager')
-- stores
local creaturesStore = require('stores/creatures')
local itemsStore = require('stores/items')
local objectsStore = require('stores/objects')
-- classes
local ActionsManager = require('classes/ActionsManager')
-- engine
local controlManager = require('engine/controlManager')
local viewer = require('engine/viewer')
local audioManager = require('engine/audioManager')
-- functions
local loadGame = require('functions/loadGame')
local listenMonstersDead = require('functions/listenMonstersDead')
local checkOver = require('functions/checkOver')
local actionsManager = ActionsManager:new()

function startEngine()

end

function startGame()  
  math.randomseed( os.time() )
  collisionManager:setStores(creaturesStore.items, itemsStore.items, objectsStore.items)
  -- assets loading
  function love.load()
    viewer:init(onUpdate)
    audioManager:init()
  end
  controlManager:init(onKeyPress)
  -- map generation
  loadGame(creaturesStore, itemsStore, objectsStore)
  listenMonstersDead(itemsStore)
end

function checkItems() 
  creaturesStore:checkItems()
  objectsStore:checkItems()
  itemsStore:checkItems()
end

function onUpdate()
  viewer:view(creaturesStore.items, objectsStore.items, itemsStore.items, creaturesStore:findPlayer())
end

function onKeyPress()
  local overType = nil
  creaturesStore:makeActions()
  actionsManager:executeActions()
  checkItems()

  -- overType = checkOver(viewer)

  -- if overType then
  --   if overType == 'dead' then viewer:showScreen('dead') end
  --   if overType == 'win' then viewer:showScreen('win') end
  -- end
end

startGame()