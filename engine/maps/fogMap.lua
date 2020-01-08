local fogMap = {
  items = {}
}

function fogMap:getMap(x,y) 
  if not self.items[1] then
    for i = 1, config.mapWidth do
      self.items[i] = {}
      for j = 1, config.mapHeight do
        self.items[i][j] = true
      end
    end
    return self.items
  else
    self:removeFog(x,y) 
    return self.items
  end
end

function fogMap:removeFog(x,y)
  local offset = 3
  for i = x - offset, x + offset do
    for j = y - offset, y + offset do
      if i > 0 and j > 0 and i < config.mapWidth and j < config.mapHeight then
        self.items[i][j] = false
      end
    end
  end
end

return fogMap