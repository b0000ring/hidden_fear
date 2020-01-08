-- classes
local Container = require('classes/basic/Container') 
-- constants
local CONTAINER_TYPES = require('constants/containers')

function createContainer(x, y, container)
  if container then
    return Container:new(container, x, y)
  end

  -- recomment when will be more than 1 effect
  -- local selector = math.random(1,1)

  -- if selector == 1 then 
  --   return Container:new(x, y, CONTAINER_TYPES.fog)
  -- end
  
  return Container:new(CONTAINER_TYPES.fog, x, y, true)
end

return createContainer