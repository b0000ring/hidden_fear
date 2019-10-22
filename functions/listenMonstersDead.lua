-- classes
local Key = require('classes/items/Key')

function createManisonKey(itemsStore, x, y)
  itemsStore.items[#itemsStore.items + 1] = Key:new('mansion', x, y)
end

function listenMonstersDead(itemsStore)
  local totalMonsters = config.creaturesLimit
  
  function listenMainCondition()
    return function(coords)
      totalMonsters = totalMonsters - 1
      if totalMonsters <= 0 then
        createManisonKey(itemsStore, coords.x, coords.y)
      end
    end
  end

  mediator:subscribe('monster.die', '', listenMainCondition())
end

return listenMonstersDead