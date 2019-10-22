-- classes
local Object = require('classes/basic/Object')
-- constants
local TAGS = require('constants/tags')
local OBJECTS_TYPES = require('constants/objects')

local Door = {}

function Door:new(x, y, keyId)
  local newObj = Object:new(OBJECTS_TYPES.door, x, y, {[TAGS.blocking] = true, [TAGS.openable] = true})
  newObj.keyId = keyId

  function newObj:open()
    self.tags = {}
    self.health = 0
  end

  self.__index = self
  return setmetatable(newObj, self)
end

return Door