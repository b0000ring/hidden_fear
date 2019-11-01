local inputActions = require('/engine/controlMap')

local controlManager = {}

function controlManager:init(keyUpCallback)
  function love.keypressed(key)
    local action = self:makeAction(key)
    if action then keyUpCallback() end
  end
end

function controlManager:makeAction(key)
  if inputActions[key] then 
    mediator:call('control.' .. inputActions[key])
    return true
  end
end

return controlManager