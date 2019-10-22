-- classes
local Item = require('classes/basic/Item')
-- constants
local ITEMS_TYPES = require('constants/items')

local Key = {}

function Key:new(keyId, x, y)
  local newObj = Item:new(ITEMS_TYPES.key, x, y)
  newObj.keyId = keyId

  function newObj:action(initiator)
    table.insert(initiator.keys, self.keyId)
  end
	
  self.__index = self
  return setmetatable(newObj, self)
end

return Key