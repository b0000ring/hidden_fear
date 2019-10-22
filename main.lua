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
-- interaction
local controlManager = require('interaction/controlManager')
local viewer = require('interaction/viewer')
-- functions
local loadGame = require('functions/loadGame')
local listenMonstersDead = require('functions/listenMonstersDead')
local checkOver = require('functions/checkOver')

function startGame()  
  math.randomseed( os.time() )
  collisionManager:setStores(creaturesStore.items, itemsStore.items, objectsStore.items)
  viewer.init()
  viewer:showScreen('start')
  viewer:showScreen('loading')
  loadGame(creaturesStore, itemsStore, objectsStore)
  listenMonstersDead(itemsStore)
  startGameLoop()
end

function checkItems() 
  creaturesStore:checkItems()
  objectsStore:checkItems()
  itemsStore:checkItems()
end

function startGameLoop()
  local actionsManager = ActionsManager:new()
  local overType = nil
  viewer:view(creaturesStore.items, objectsStore.items, itemsStore.items, creaturesStore:findPlayer())
  controlManager:listen()
  creaturesStore:makeActions()
  actionsManager:executeActions()
  checkItems()

  overType = checkOver(viewer)

  if not overType then
    startGameLoop()
  else
    if overType == 'dead' then viewer:showScreen('dead') end
    if overType == 'win' then viewer:showScreen('win') end
  end
end

local function err (err)
  curses.endwin ()
  print "Caught an error:"
  print (debug.traceback (err, 2))
  os.exit (2)
end

xpcall (startGame, err)