-- managers
local audioManager = require('engine/audioManager')
local controlManager = require('engine/controlManager')
local viewManager = require('engine/viewManager')

local engine = {}

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
    viewManager:view(data)
    audioManager:init()
  end
end

function engine:setInputCallback(callback)
  controlManager:init(callback)
end

return engine