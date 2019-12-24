local help = {}
  
  function help:show(font)
    local r, g, b, a = love.graphics.getColor( )
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle( 'fill', 80, 100, 500, 400 )
    love.graphics.setColor(r, g, b, a)

    love.graphics.printf('HELP', font,  300, 140, 352, 'left', 0 , 2)
    love.graphics.printf('Press I button to view inventory', font,  100, 190, 352, 'left', 0 , 1.5)
    love.graphics.printf('Press arrow buttons to make a move', font,  100, 250, 352, 'left', 0 , 1.5)
    love.graphics.printf('Press z button to pick up item', font,  100, 290, 352, 'left', 0 , 1.5)
    love.graphics.printf('Press x button to heal yourself', font,  100, 330, 352, 'left', 0 , 1.5)
    love.graphics.printf('Press c button to throw out weapon', font,  100, 370, 352, 'left', 0 , 1.5)
    love.graphics.printf('Press escape button to close game', font,  100, 450, 352, 'left', 0 , 1.5)

  end
  
return help