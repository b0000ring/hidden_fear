local Field = {}

function Field:new(x, y, width, height, Object, store)
  local newObj = {}
  
  local midX = x + width / 2

  for i = y, y + height do
    local start = math.floor(midX + math.random(-3, 3))
    for j = start, start + width do
      if(i > 1 and j > 1 and i < config.mapHeight and j < config.mapWidth) then 
        mediator:call('store.' .. store .. '.addSpecial', Object:new(j, i))
      end
    end
  end
end

return Field