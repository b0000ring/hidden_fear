-- classes
local Object = require('classes/basic/Object')
-- constants
local OBJECTS_TYPES = require('constants/objects')
local TAGS = require('constants/tags')

local Bush = {}

function Bush:new(x,y)
  local newObj = Object:new(OBJECTS_TYPES.bush, x, y, {[TAGS.hiding] = true})

  function newObj:setHide(hidable)
    return hidable:hide(2)
  end

  self.__index = self
  return setmetatable(newObj, self)
end

return Bush