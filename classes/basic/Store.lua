local Store = {}

function Store:new(name)
  local newObj = {items = {}}
  
  function newObj:fill()
    error("Using of default Store fill function!")
  end

  function newObj:checkItems()
    for key, item in pairs(self.items) do
      if item.health <= 0 then
        self.items[key]:onDead()
        self.items[key] = nil
      end
    end
  end

  function newObj:addSpecial()
    return function(item)
      print(item.name)
      self.items[#self.items + 1] = item
    end
  end
	
  function newObj:startCreationCycle(factory, limit)
    for i = 2, config.mapWidth - 2 do
      for j = 2, config.mapHeight - 2 do
        if #self.items < limit then
          if math.floor(math.random(0,1000)) == 1 and not collisionManager:findCollision(i,j) then
            self.items[#self.items + 1] = factory(i,j)
          end
        else
          return
        end
      end
    end 
  end

  mediator:subscribe('store.' .. name .. '.addSpecial', 'store', newObj:addSpecial())

	self.__index = self
  return setmetatable(newObj, self)
end



return Store