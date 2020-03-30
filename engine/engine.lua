-- managers
local audioManager = require('engine/managers/audioManager')
local controlManager = require('engine/managers/controlManager')
local viewManager = require('engine/managers/viewManager')
-- constants
local screens = require('constants/screens')

local engine = {
  screen = nil
}

function engine:init()
  local settings = {
    resizable = false,
    centered = true,
  }
  love.window.updateMode( 1024, 672, settings )
  love.window.setTitle( 'Hidden Fear' )
end

function engine:load()
  function love.load()
    viewManager:load()
    audioManager:load()
  end
end

function engine:update(data)
  function love.update(dt)
    function love.draw(drawable)
      if self.screen == screens.main then 
        viewManager:view(data, dt)
      else
        viewManager:showScreen(self.screen)
      end
    end
  end
end

function engine:setInputCallback(callback)
  controlManager:init(callback)
end

function engine:quit()
  love.event.quit()
end

function engine:setScreen(screen)
  self.screen = screen
end

return engine