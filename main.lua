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
local engine = require('engine/engine')
-- functions
local loadGame = require('functions/loadGame')
local listenMonstersDead = require('functions/listenMonstersDead')
local checkOver = require('functions/checkOver')
local actionsManager = ActionsManager:new()

function startGame()  
  math.randomseed( os.time() )
  collisionManager:setStores(creaturesStore.items, itemsStore.items, objectsStore.items)
  -- load engine
  engine:init()
  engine:load()
  engine:setInputCallback(onKeyPress)
  -- generate objects
  loadGame(creaturesStore, itemsStore, objectsStore)
  -- start game cycle
  engine:update(passData())
  -- listenMonstersDead(itemsStore)
end

function checkItems() 
  creaturesStore:checkItems()
  objectsStore:checkItems()
  itemsStore:checkItems()
end

function passData()
  return {
    creatures = creaturesStore.items, 
    objects = objectsStore.items, 
    items = itemsStore.items, 
    player = creaturesStore:findPlayer()
  }
end

function onKeyPress()
  local overType = nil
  creaturesStore:makeActions()
  actionsManager:executeActions()
  checkItems()

  -- overType = checkOver()

  -- if overType then
  --   if overType == 'dead' then viewManager:showScreen('dead') end
  --   if overType == 'win' then viewManager:showScreen('win') end
  -- end
end

startGame()