local inputActions = require('/engine/maps/controlMap')

local controlManager = {
  mode = 'menu'
}

function controlManager:setMode()
  return function(mode)
    self.mode = mode
  end
end

function controlManager:init(keyUpCallback)
  function love.keypressed(key)
    local action = self:makeAction(key)
    if action then keyUpCallback() end
  end
  mediator:subscribe('control.setMode', 'control', controlManager:setMode())

end

function controlManager:makeAction(key)
  if inputActions[self.mode][key] then 
    mediator:call('control.' .. self.mode .. '.' .. inputActions[self.mode][key])
    return true
  end
end

return controlManager