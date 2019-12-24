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
-- constants
local screens = require('constants/screens')
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
  engine:update()
  engine:setScreen(screens.start)
  mediator:call('control.setMode', 'menu')
  listenMonstersDead(itemsStore)
end

function handleReturn()
  if engine.screen == 'start' then 
    startMainCycle()
  elseif engine.screen == screens.dead or engine.screen == screens.win then
    engine:quit()
  end
end

function handleEscape()
  engine:quit()
end

function startMainCycle()
  showLoadingScreen()
  loadGame(creaturesStore, itemsStore, objectsStore)
  engine:update(passData())
  showMainScreen()
end

function showLoadingScreen()
  engine:setScreen(screens.loading)
end

function showMainScreen()
  mediator:call('control.setMode', 'main')
  engine:setScreen(screens.main)
end

function endGame()
  engine:quit()
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
  if engine.screen == screens.main then
    local overType = nil
    creaturesStore:makeActions()
    actionsManager:executeActions()
    checkItems()

    overType = checkOver()

    if overType then
      mediator:call('control.setMode', 'menu')
      if overType == 'dead' then engine:setScreen(screens.dead) end
      if overType == 'win' then engine:setScreen(screens.win) end
    end
  end
end

mediator:subscribe('control.menu.return', 'main', handleReturn)
mediator:subscribe('control.menu.escape', 'main', handleEscape)
mediator:subscribe('control.main.escape', 'main', handleEscape)


startGame()