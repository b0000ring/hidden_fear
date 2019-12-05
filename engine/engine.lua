-- managers
local audioManager = require('engine/managers/audioManager')
local controlManager = require('engine/managers/controlManager')
local viewManager = require('engine/managers/viewManager')

local engine = {
  screen = 'start'
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
  function love.update()
    function love.draw(drawable)
      if self.screen == 'play' then 
        viewManager:view(data)
      else
        viewManager:showScreen(self.screen)
      end
    end
  end
end

function engine:setInputCallback(callback)
  controlManager:init(callback)
end

function engine:setScreen(screen)
  self.screen = screen
end

return engine