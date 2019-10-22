local collisionManager = {
  collections = {}
}

function collisionManager:setStores(creatures, items, objects)
  self.collections['items'] = items
  self.collections['creatures'] = creatures
  self.collections['objects'] = objects
end

function collisionManager:find(collection, x, y)
  for key, item in pairs(collection) do
    if item.coordX == x and item.coordY == y then
      return item
    end
  end
end

function collisionManager:findItem(x, y)
  return self:find(self.collections.items, x, y)
end

function collisionManager:findObject(x, y)
  return self:find(self.collections.objects, x, y)
end

function collisionManager:findCollision(x, y)
  for key, collection in pairs(self.collections) do
    local item = self:find(collection, x, y)
    if item then
      return item
    end
  end
  
  return false
end



return collisionManager