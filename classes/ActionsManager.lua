-- classes
local ActionDescription = require('classes/basic/ActionDescription')
-- constants
local ACTION_TYPES = require('constants/actionTypes')
local TAGS = require('constants/tags')
local CREATURES_TYPES = require('constants/creatures')
local DESCRIPTIONS = require('constants/descriptions')

local ActionsManager = {}

function ActionsManager:new()
  local newObj = {
    actions = {}
  }

  function newObj:addAction()
    return function(action)
      table.insert(self.actions, action)
    end
  end

  function newObj:setActionDescription(actorName, actionType, targetName, instrumentName, points)
      mediator:call('description.addAction', ActionDescription:new(actorName, actionType, targetName, instrumentName, points))
  end

  function newObj:setPlayerActionDescription(actorName, actionType, targetName, instrumentName, points)
    if actorName == CREATURES_TYPES.player or targetName == CREATURES_TYPES.player then
      self:setActionDescription(actorName, actionType, targetName, instrumentName, points)
    end
  end

  function newObj:getActionByCollisionType(action, collision)
    if collision.tags[TAGS.enemy] then
      self:attackFlow(action.initiator, collision)
      return true
    elseif collision.tags[TAGS.openable] then
      self:openFlow(action.initiator, collision)
      return true
    elseif collision.tags[TAGS.effect] then
      self:effectFlow(action.initiator, collision)
    elseif collision.tags[TAGS.cutable] then
      self:cutableFlow(action.initiator, collision)
      return true
    elseif collision.tags[TAGS.hiding] then
      self:hideFlow(action.initiator, collision)
    elseif collision.tags[TAGS.blocking] then
      return true
    elseif collision.tags[TAGS.pickupable] then
      self:setPlayerActionDescription(action.initiator.name, DESCRIPTIONS.over, collision.name)
    end
  end

  function newObj:cutableFlow(initiator, collision)
    local items = initiator.items
    if items then 
      for key, val in pairs(items) do
        if val == 'axe' then
          collision.health = collision.health - 1
          self:setPlayerActionDescription(initiator.name, DESCRIPTIONS.cut, collision.name)
        end
      end
    end
  end

  function newObj:effectFlow(initiator, collision)
    collision:action(initiator)
    self:setPlayerActionDescription(initiator.name, DESCRIPTIONS.hit, collision.name)
  end

  function newObj:openFlow(initiator, collision)
    local keys = initiator.keys
    for key, val in pairs(keys) do
      if val == collision.keyId then
        collision:open()
        self:setPlayerActionDescription(initiator.name, DESCRIPTIONS.open, collision.name)
        return
      end
    end
    self:setPlayerActionDescription(initiator.name, DESCRIPTIONS.cant_open, collision.name)
  end

  function newObj:hideFlow(initiator, hider)
    self:setPlayerActionDescription(initiator.name, DESCRIPTIONS.hiding, hider.name)
    hider:setHide(initiator)
  end

  function newObj:attackFlow(initiator, enemy)
    if initiator.health > 0 then
      local damage = initiator:attack(enemy)
      self:setPlayerActionDescription(initiator.name, DESCRIPTIONS.attack, enemy.name, initiator.weapon.name, damage)

      if enemy.health <= 0 then
        self:setActionDescription(enemy.name, DESCRIPTIONS.dies)
      end
    end
  end

  function newObj:pickupFlow(initiator)
    local collision = collisionManager:findItem(initiator.coordX, initiator.coordY)
    if collision then
      collision:action(initiator) 
      collision.health = 0
      self:setPlayerActionDescription(initiator.name, DESCRIPTIONS.pickup, collision.name)
    else
      self:setPlayerActionDescription(initiator.name, DESCRIPTIONS.fail_pickup)
    end
  end

  function newObj:moveFlow(action)
    local collision = collisionManager:findCollision(action.params.x, action.params.y)
    local isBlockable =  collision and self:getActionByCollisionType(action, collision) or false 

    if not isBlockable then
      self:setPlayerActionDescription(action.initiator.name, DESCRIPTIONS.move)
      action.initiator:setCoords(action.params.x, action.params.y)
      action.initiator:reduceHiddenPoint()
      action.initiator:increaseMentalPoint()
    end
  end
  

  function newObj:executeAction(action) 
    if action.type == ACTION_TYPES.move then
      self:moveFlow(action)
    elseif action.type == ACTION_TYPES.pickup then
      self:pickupFlow(action.initiator)
    end
  end

  function newObj:executeActions()
    for key, action in pairs(self.actions) do
      self:executeAction(action)
      self.actions[key] = nil
    end
  end

  mediator:subscribe('actions.addAction', 'actionManager', newObj:addAction())

  self.__index = self
  return setmetatable(newObj, self)
end

return ActionsManager