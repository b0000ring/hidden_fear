local ActionDescription = {}

function ActionDescription:new(actorName, actionType, targetName, instrumentName, points)
  local newObj = {}
  newObj.actorName = actorName
  newObj.actionType = actionType
  newObj.targetName = targetName
  newObj.instrumentName = instrumentName
  newObj.points = points

  self.__index = self
  return setmetatable(newObj, self)
end

return ActionDescription