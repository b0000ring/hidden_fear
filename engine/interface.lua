local DescriptionManager = require('engine/managers/descriptionManager')
local descriptionManager = DescriptionManager:new()

local totalMonsters = config.creaturesLimit

function reduceMonsers()
  totalMonsters = totalMonsters - 1
end

mediator:subscribe('monster.die', 'view', reduceMonsers)

function viewInterface(font, sprites, player)
  local r, g, b, a = love.graphics.getColor( )
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle( 'fill', 672, 0, 352, 672 )
  love.graphics.setColor(r, g, b, a)
  love.graphics.printf('Health: ' .. player.health , font,  680, 30, 352, 'left', 0 , 1.5)
  love.graphics.printf('Mental: ' .. player.mental , font,  680, 60, 352, 'left', 0 , 1.5)
  love.graphics.printf('Heals: ' .. player.heals, font,  680, 90, 352, 'left', 0 , 1.5)
  love.graphics.printf('_________________________________________', font,  680, 120, 352, 'left', 0 , 1.5)
  love.graphics.printf('Weapon: ' .. player.weapon.name , font,  680, 160, 352, 'left', 0 , 1.5)
  love.graphics.printf('Power: ' .. player.weapon.power, font,  680, 190, 352, 'left', 0 , 1.5)
  love.graphics.printf('Pistol bullets: ' .. player.bullets.pistol, font,  680, 220, 352, 'left', 0 , 1.5)
  love.graphics.printf('Shotgun bullets: ' .. player.bullets.shotgun, font,  680, 250, 352, 'left', 0 , 1.5)
  love.graphics.printf('_________________________________________', font,  680, 280, 352, 'left', 0 , 1.5)
  love.graphics.printf('X: ' .. player.coordX .. ' | Y ' .. player.coordY, font,  680, 320, 352, 'left', 0 , 1.5)
  love.graphics.printf('Monsters left: ' .. totalMonsters, font,  680, 350, 352, 'left', 0 , 1.5)
  love.graphics.printf('_________________________________________', font,  680, 380, 352, 'left', 0 , 1.5)
  
  local actionDescriptions = descriptionManager:getActions()
  local basicHeight = 420
  for key, val in pairs(actionDescriptions) do
    love.graphics.printf(val, font,  680, basicHeight, 300, 'left', 0 , 1.2)
    basicHeight = basicHeight + 40
  end
end

return viewInterface