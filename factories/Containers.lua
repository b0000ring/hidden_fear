-- classes
local Floor = require('classes/containers/Floor') 
local Fog = require('classes/containers/Fog') 

function createContainer(x, y, container)
  local map = {
    floor = Floor,
    fog = Fog
  }

  if container then
    local Obj = map[container]
    return Obj:new(x,y)
  end

  -- recomment when will be more than 1 effect
  -- local selector = math.random(1,1)

  -- if selector == 1 then 
  --   return Container:new(x, y, CONTAINER_TYPES.fog)
  -- end
  
  return Fog:new(x, y)
end

return createContainer