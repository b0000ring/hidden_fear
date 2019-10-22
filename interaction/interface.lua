local DescriptionManager = require('interaction/descriptionManager')
local descriptionManager = DescriptionManager:new()
function viewInterface(stdscr, player)
  stdscr:addstr('\n_________________________________________\n\n')
  stdscr:addstr('health: ' .. player.health .. ' | ' .. 'mental: ' .. player.mental .. ' | ' .. 'heals: ' .. player.heals .. '\n\n')
  stdscr:addstr('weapon: ' .. player.weapon.name .. ' | ' .. 'power: ' .. player.weapon.power .. '\n\n')
  stdscr:addstr('pistol bullets: ' .. player.bullets.pistol .. ' | ' .. 'shotgun bullets: ' .. player.bullets.shotgun .. '\n\n')
  stdscr:addstr('x: ' .. player.coordX .. ' | y ' .. player.coordY .. '\n')
  stdscr:addstr('\n_________________________________________\n\n')
  local actionDescriptions = descriptionManager:getActions()
  for key, val in pairs(actionDescriptions) do
    stdscr:addstr(val .. '\n\n')
  end
end

return viewInterface