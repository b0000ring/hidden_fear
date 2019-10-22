local Action = {}

function Action:new(type, initiator, params)
  local newObj = {}
  newObj.type = type
  newObj.initiator = initiator
  newObj.params = params

  self.__index = self
  return setmetatable(newObj, self)
end

return Action