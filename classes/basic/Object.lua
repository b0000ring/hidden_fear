local Something = require('classes/basic/Something')
local TAGS = require('constants/tags')

local Object = {}

function Object:new(name, coordX, coordY, tags)
  local newObj = Something:new(name, coordX, coordY, 1, tags or {[TAGS.blocking] = true})

  function newObj:action()
    error('using default Object action')
  end
	
  self.__index = self
  return setmetatable(newObj, self)
end

return Object