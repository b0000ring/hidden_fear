-- classes
local Creature = require('classes/basic/Creature')
local ActionDescription = require('classes/basic/ActionDescription')
local Action = require('classes/basic/Action')
-- constants
local TAGS = require('constants/tags')
local ACTION_TYPES = require('constants/actionTypes')
local CREATURES_TYPES = require('constants/creatures')
local DIRECTIONS = require('constants/directions')
local WEAPONS_TYPES = require('constants/weapons')
local DESCRIPTIONS = require('constants/descriptions')
-- collections
local weapons = require('collections/weapons')

local Player = {
  tags = {
    TAGS.player
  }
}

function Player:new(x,y)
  local newObj = Creature:new(CREATURES_TYPES.player, x, y, 30, weapons.fists)

  newObj.heals = 0
  newObj.keys = {}
  newObj.items = {}
  newObj.bullets = {
    pistol = 0,
    shotgun = 0,
  }

  function newObj:onDead()
    mediator:call('player.dead')
  end
  	
  function newObj:attack(enemy)
    local attack = true
    if self.weapon.bullets then
      if self.bullets[self.weapon.bullets] > 0 then
        self.bullets[self.weapon.bullets] = self.bullets[self.weapon.bullets] - 1
      else
        attack = false
      end
    end
    if attack == true then
      local damage = self.weapon.power + math.random(-1, 1) 
      enemy.health = enemy.health - ( damage + math.random(0, 1) )
      return damage
    else
      return 0
    end
  end

  function newObj:getDirection()
    return false
  end

  function newObj:wait()
    return function()
      mediator:call('description.addAction', ActionDescription:new(self.name, DESCRIPTIONS.wait))
      self:move(DIRECTIONS.x, 0)
      return
    end
  end

  function newObj:pickup()
    return function()
      mediator:call('actions.addAction', Action:new(ACTION_TYPES.pickup, self))
      self:move(DIRECTIONS.x, 0)
      return
    end
  end

  function newObj:dropWeapon()
    return function()
      if self.weapon.name ~= WEAPONS_TYPES.fists then
        mediator:call('description.addAction', ActionDescription:new(self.name, DESCRIPTIONS.drop_weapon))
        self.weapon = weapons.fists
        return
      end
    end
  end

  function newObj:heal()
    return function()
      if self.heals > 0 and self.health < self.maxHealth then
        self.health = self.health + 15
        if self.health > self.maxHealth then self.health = self.maxHealth end
        self.heals = self.heals - 1
        self:move(DIRECTIONS.x, 0)
        mediator:call('description.addAction', ActionDescription:new(self.name, DESCRIPTIONS.heals))
      else 
        mediator:call('description.addAction', ActionDescription:new(self.name, DESCRIPTIONS.heals_failed))
      end
      return
    end
  end

  mediator:subscribe('control.main.drop_weapon', 'player', newObj:dropWeapon())
  mediator:subscribe('control.main.wait', 'player', newObj:wait())
  mediator:subscribe('control.main.move_up', 'player', newObj:move(DIRECTIONS.y, -1))
  mediator:subscribe('control.main.move_down', 'player', newObj:move(DIRECTIONS.y, 1))
  mediator:subscribe('control.main.move_left', 'player', newObj:move(DIRECTIONS.x, -1))
  mediator:subscribe('control.main.move_right', 'player', newObj:move(DIRECTIONS.x, 1))
  mediator:subscribe('control.main.pickup', 'player', newObj:pickup())
  mediator:subscribe('control.main.heal', 'player', newObj:heal())

	self.__index = self
  return setmetatable(newObj, self)
end

return Player
