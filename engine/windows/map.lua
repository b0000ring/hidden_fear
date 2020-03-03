local CREATURES_TYPES = require('constants/creatures')
local ITEMS_TYPES = require('constants/items')
local OBJECTS_TYPES = require('constants/objects')
local CREATURES_TYPES = require('constants/creatures')


local map = {}
  
function map:show(font, player, map, fogMap)
  local r, g, b, a = love.graphics.getColor( )
  local stringY = 230
  local size = 4

  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle( 'fill', 80, 100, 500, 500 )
  love.graphics.setColor(r, g, b, a)

  love.graphics.printf('MAP', font,  320, 140, 352, 'left', 0 , 2)

  for i = 1, config.mapWidth do
    for j = 1, config.mapHeight do
      local item = map[i][j]
      if item then
        if ITEMS_TYPES[item.data.name] then 
          love.graphics.setColor(255, 255, 0)
        elseif OBJECTS_TYPES[item.data.name] then
          love.graphics.setColor(255, 255, 255)
        elseif item.data.name == 'player' then 
          love.graphics.setColor(255, 0, 0)
        elseif CREATURES_TYPES[item.data.name] then
          love.graphics.setColor(0, 255, 0)
        end
      end
      love.graphics.rectangle( 'fill', 130 + i * size, 180 + j * size, size, size )
      love.graphics.setColor(0, 0, 0)
    end
  end

  love.graphics.setColor(r, g, b, a)
end
  
return map