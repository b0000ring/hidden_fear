-- screens
local start = require('engine/screens/start')
local loading = require('engine/screens/loading')
local dead = require('engine/screens/dead')
local win = require('engine/screens/win')
-- maps
local spritesMap = require('engine/spritesMap')
-- view interface function
local viewInterface = require('engine/interface')

local viewer = {
  screens = {
    start = start,
    loading = loading,
    dead = dead,
    win = win
  },
  views = {},
  grassMap = {},
  sprites = {}
}

function viewer:init(updateCallback)
  local settings = {
    resizable = false,
    centered = true,
  }
  love.window.updateMode( 1024, 672, settings )
  love.window.setTitle( 'Hidden Fear' )

  function love.load()
    for key, val in pairs(spritesMap) do
      self.sprites[key] = val(self.loadSprite)
    end

    self:generateGrass()
  end

  function love.update()
    updateCallback()
  end

end

function viewer.loadSprite(name)
  return love.graphics.newImage('/assets/graphics/' .. name .. '.png')
end

function viewer:showScreen(screen)
  return self.screens[screen].show(stdscr, curses)
end

function viewer:getSprite(name)
  return self.sprites[name]()
end

function viewer:clearMap()
  self.map = {}
  for i = 1, config.mapWidth do
    self.map[i] = {}
    for j = 1, config.mapHeight do
      self.map[i][j] = nil
    end
  end
end

function viewer:addToMap(items)
  for key, val in pairs(items) do
    if self.views[val.id] then
      self.map[val.coordX][val.coordY] = self.views[val.id]
    else
      local sprite = viewer:getSprite(val.name)
      self.map[val.coordX][val.coordY] = sprite
      self.views[val.id] = sprite
    end
  end
end

function viewer:generateGrass()
  for i = 1, config.mapWidth do
    self.grassMap[i] = {}
    for j = 1, config.mapHeight do
      self.grassMap[i][j] = self:getSprite('grass')
    end
  end
end

function viewer:viewMap(playerCoords)
  function love.draw(drawable)
    local yoffset = 0
    for i = playerCoords.y - config.mapPadding, playerCoords.y + config.mapPadding do
      local xoffset = 0
      for j = playerCoords.x - config.mapPadding, playerCoords.x + config.mapPadding do
        love.graphics.draw( self.grassMap[j][i], xoffset, yoffset)
        if self.map[j][i] then
          local drawable = self.map[j][i]
          love.graphics.draw(drawable, xoffset, yoffset - (10 + drawable:getHeight() - 32))
        end
        xoffset = xoffset + 32
      end
      xoffset = 0
      yoffset = yoffset + 32
    end
    love.graphics.draw(self:getSprite('night_effect'), 0, 0)
  end
end

function viewer:view(creatures, objects, items, player)
  self:clearMap()
  self:addToMap(items)
  self:addToMap(creatures)
  self:addToMap(objects)
  self:viewMap(player:getCoords())
  -- viewInterface(stdscr, player)
end

return viewer