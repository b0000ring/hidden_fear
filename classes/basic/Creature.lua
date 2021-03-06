local Something = require('classes/basic/Something')
local TAGS = require('constants/tags')
local Action = require('classes/basic/Action')
local ACTION_TYPES = require('constants/actionTypes')
-- constants
local DIRECTIONS = require('constants/directions')
-- collections
local weapons = require('collections/weapons')

local Creature = {}

function Creature:new(name, coordX, coordY, health, weapon)
	local newObj = Something:new(name, coordX, coordY, health, {[TAGS.enemy] = true, [TAGS.blocking] = true})
  newObj.hiddenSteps = 0
  newObj.visionRange = 5
  newObj.keys = {}
  newObj.mental = 10
  newObj.maxMental = newObj.mental
  newObj.maxHealth = newObj.health
  newObj.weapon = weapon or weapons.fists

	function newObj:hide(steps)
		newObj.hiddenSteps = steps
	end
	
	function newObj:attack(enemy)
    enemy.health = enemy.health - self.weapon.power
    enemy.mental = enemy.mental - 2
    return self.weapon.power
	end

	function newObj:setCoords(xDirection, yDirection)
		self.coordX = xDirection
    self.coordY = yDirection
  end
  
  function newObj:reduceHiddenPoint()
    if(self.hiddenSteps > 0) then 
      self.hiddenSteps = self.hiddenSteps - 1
    end 
  end

  function newObj:increaseMentalPoint()
    if(self.mental < self.maxMental) then 
      self.mental = self.mental + 1
    end 
  end

  function newObj:move(direction, value) 
    -- TODO REFACTORING!!!
    return function()
      local newDirection = nil
      local newValue = nil
      if self.mental <= 0 then
        if math.floor(math.random() + 0.5) == 1 then newDirection = DIRECTIONS.x else newDirection = DIRECTIONS.y end
        newValue = math.random(-1, 1)
      else
        newDirection = nil
        newValue = nil
      end

      if value ~= 0 and newValue ~= 0 then 
        local newCoords = {}
        if(newDirection == DIRECTIONS.y or direction == DIRECTIONS.y) then
          newCoords = {
            y = self.coordY + (newValue or value),
            x = self.coordX
          }
        else
          newCoords = {
            y = self.coordY,
            x = self.coordX + (newValue or value)
          }
          if newValue == 1 or value == 1 then
            mediator:call('view.direction.change', {id = self.id, direction = 'right'})
          else
            mediator:call('view.direction.change', {id = self.id, direction = 'left'})
          end
        end
        if newCoords.x > 0 and newCoords.y > 0 and newCoords.x < config.mapWidth and newCoords.y < config.mapHeight then 
          mediator:call('actions.addAction', Action:new(ACTION_TYPES.move, self, newCoords))
        end
      end
    end
  end

  -- actually this is a AI
  function newObj:getDirection(playerCoords)
    local xRange = self.coordX - playerCoords.x
    local yRange = self.coordY - playerCoords.y
    local step = {}

    if xRange < 0 then xRange = xRange * -1 end
    if yRange < 0 then yRange = yRange * -1 end
    
    -- decide where to go by x
    if xRange ~= 0 then
      local step = {}
      if xRange <= self.visionRange and yRange <= self.visionRange then
        if self.coordX > playerCoords.x then
          step =  {
            direction = DIRECTIONS.x,
            value = -1
          }
        else
          step =  {
            direction = DIRECTIONS.x,
            value = 1
          }
        end
      else
        -- it randomize x and y directions
        if math.floor(math.random() + 0.5) == 1 then
          step =  {
            direction = DIRECTIONS.x,
            value = math.random(-1, 1)
          }
        end
      end

      if step.value then 
        local collision = collisionManager:findCollision(self.coordX + step.value, self.coordY )

        if not collision or collision.name == 'player' then
          return step
        end
      end
    
    end

    step = {}
    -- decide where to go by y
    if yRange <= self.visionRange and xRange <= self.visionRange then
      if self.coordY > playerCoords.y then
        step =  {
          direction = DIRECTIONS.y,
          value = -1
        }
      else
        step =  {
          direction = DIRECTIONS.y,
          value = 1
        }
      end
    else
      step = {
        direction = DIRECTIONS.y,
        value = math.random(-1, 1)
      }
    end
    
    if step.value then 
      local collision = collisionManager:findCollision(self.coordX, self.coordY + step.value )

      if not collision or collision.name == 'player' then
        return step
      end
    end
  end


	self.__index = self
  return setmetatable(newObj, self)
end

return Creature