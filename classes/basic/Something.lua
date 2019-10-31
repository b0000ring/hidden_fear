local generateId = require('/functions/generateId')

local Something = {}

function Something:new(name, coordX, coordY, health, tags)
  local newObj = {
		tags = tags or {},
		coordX = coordX or 0,
		coordY = coordY or 0,
		name = name or '',
		health = health or 1,
		id = generateId()
	}

	print(generateId())

	function newObj:onDead()
    return nil
  end
	
	function newObj:getCoords()
		return {x = self.coordX, y = self.coordY}
	end

  self.__index = self
  return setmetatable(newObj, self)
end



return Something