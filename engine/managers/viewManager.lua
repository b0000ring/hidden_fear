-- screens
local start = require('engine/screens/start')
local loading = require('engine/screens/loading')
local dead = require('engine/screens/dead')
local win = require('engine/screens/win')
-- constants
local screens = require('constants/screens')
-- maps
local spritesMap = require('engine/maps/spritesMap')
local grassMap = require('engine/maps/grassMap')
-- view interface function
local viewInterface = require('engine/interface')
-- effects
local rain = require('engine/effects/rain')
local lightning = require('engine/effects/lightning')

local viewManager = {
  font = nil,
  screens = {
    [screens.start] = start,
    [screens.loading] = loading,
    [screens.dead] = dead,
    [screens.win] = win
  },
  views = {},
  sprites = {},
  audio = {}
}

function viewManager:load(updateCallback)
  for key, val in pairs(spritesMap) do
    self.sprites[key] = val(self.loadSprite)
  end
  self.font = love.graphics.newFont('assets/fonts/manaspc.ttf')
end

function viewManager.loadSprite(name)
  return love.graphics.newImage('/assets/graphics/' .. name .. '.png')
end

function viewManager:showScreen(screen)
  return self.screens[screen]:show(self.font)
end

function viewManager:getSprite(name)
  return self.sprites[name]()
end

function viewManager:clearMap()
  self.map = {}
  for i = 1, config.mapWidth do
    self.map[i] = {}
    for j = 1, config.mapHeight do
      self.map[i][j] = nil
    end
  end
end

function viewManager:addToMap(items)
  for key, val in pairs(items) do
    if self.views[val.id] then
      self.map[val.coordX][val.coordY] = self.views[val.id]
    else
      local sprite = viewManager:getSprite(val.name)
      self.map[val.coordX][val.coordY] = sprite
      self.views[val.id] = sprite
    end
  end
end

function getViewBorders(centralPoint)
  return {
    xStart = centralPoint.x - config.mapPadding,
    xEnd = centralPoint.x + config.mapPadding,
    yStart = centralPoint.y - config.mapPadding,
    yEnd = centralPoint.y + config.mapPadding
  }
end

function viewManager:drawFrame(playerCoords)
  -- think about anonimous function
  local grass = grassMap:getMap(function(type) return self:getSprite(type) end)
  local viewBorders = getViewBorders(playerCoords)
  local yoffset = 0
  for i = viewBorders.yStart, viewBorders.yEnd do
    local xoffset = 0
    for j = viewBorders.xStart, viewBorders.xEnd do
      love.graphics.draw(grass[j][i], xoffset, yoffset)
      if self.map[j][i] then
        local drawable = self.map[j][i]
        love.graphics.draw(drawable, xoffset, yoffset - (10 + drawable:getHeight() - 32))
      end
      xoffset = xoffset + 32
    end
    xoffset = 0
    yoffset = yoffset + 32
  end
  rain:makeFrame()
  love.graphics.draw(self:getSprite('night_effect'), 0, 0)
  lightning:makeFrame()
end

function viewManager:view(data)
  self:clearMap()
  self:addToMap(data.items)
  self:addToMap(data.creatures)
  self:addToMap(data.objects)

  self:drawFrame(data.player:getCoords())
  viewInterface(self.font, self.sprites, data.player)
end

return viewManager