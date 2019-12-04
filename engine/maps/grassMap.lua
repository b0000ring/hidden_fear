local grassMap = {
  items = {}
}

function grassMap:getMap(getSprite) 
  if not self.items[1] then
    for i = 1, config.mapWidth do
      self.items[i] = {}
      for j = 1, config.mapHeight do
        self.items[i][j] = getSprite('grass')
      end
    end
    return self.items
  else
    return self.items
  end
  
end

return grassMap