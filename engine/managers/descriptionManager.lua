-- constants
local DESCRIPTION_TYPES = require('constants/descriptions')

local descriptionManager = {}

function descriptionManager:new()
  local newObj = {
    actions = {
      [1] = '',
      [2] = '',
      [3] = '',
      [4] = '',
      [5] = '',
      [6] = '',
    },
  }

  function newObj:getActions()
    return self.actions
  end

  function newObj:addAction()
    return function(action)
      local text = ''
      local type = action.actionType

      if type == DESCRIPTION_TYPES.move then
        text = action.actorName .. ' move' 
      elseif type == DESCRIPTION_TYPES.attack then 
        text = action.actorName .. ' makes ' .. action.points .. ' damage to ' .. action.targetName .. ' by ' .. action.instrumentName
      elseif type == DESCRIPTION_TYPES.wait then 
        text = action.actorName .. ' wait'
      elseif type == DESCRIPTION_TYPES.hiding then
        text = action.actorName .. ' hidden by ' .. action.targetName
      elseif type == DESCRIPTION_TYPES.over then
        text = action.actorName .. ' stands over ' .. action.targetName
      elseif type == DESCRIPTION_TYPES.pickup then
        text = action.actorName .. ' pickup ' .. action.targetName
      elseif type == DESCRIPTION_TYPES.fail_pickup then
        text = 'nothing to pickup'
      elseif type == DESCRIPTION_TYPES.dies then
        text = action.actorName .. ' dies '
      elseif type == DESCRIPTION_TYPES.heals then
        text = action.actorName .. ' heals himself '
      elseif type == DESCRIPTION_TYPES.heals_failed then
        text = 'cant heal'
      elseif type == DESCRIPTION_TYPES.open then
        text = action.actorName .. ' open a ' .. action.targetName
      elseif type == DESCRIPTION_TYPES.drop_weapon then
        text = action.actorName .. ' drop his weapon '
      elseif type == DESCRIPTION_TYPES.cant_open then
        text = action.actorName .. ' failed to open ' .. action.targetName
      elseif type == DESCRIPTION_TYPES.hit then
        text = action.actorName .. ' hit ' .. action.targetName
      end

      table.insert(self.actions, text)
      table.remove(self.actions, 1)
    end
  end

  mediator:subscribe('description.addAction', 'description', newObj:addAction())

  self.__index = self
  return setmetatable(newObj, self)
end

return descriptionManager