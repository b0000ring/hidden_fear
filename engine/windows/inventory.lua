local inventory = {}
  
function inventory:show(font, player)
  local r, g, b, a = love.graphics.getColor( )
  local stringY = 230
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle( 'fill', 80, 100, 500, 400 )
  love.graphics.setColor(r, g, b, a)

  love.graphics.printf('INVENTORY', font,  250, 140, 352, 'left', 0 , 2)
  love.graphics.printf('KEYS', font,  300, 190, 352, 'left', 0 , 1.5)

  for key, val in pairs(player.keys) do
    love.graphics.printf('- ' .. val, font, 200, stringY, 352, 'left', 0 , 1.5)
    stringY = stringY + 40
  end

  love.graphics.printf('ITEMS', font,  295, stringY, 352, 'left', 0 , 1.5)
  stringY = stringY + 40

  for key, val in pairs(player.items) do
    love.graphics.printf('- ' .. val, font, 200, stringY, 352, 'left', 0 , 1.5)
    stringY = stringY + 40
  end
end
  
return inventory