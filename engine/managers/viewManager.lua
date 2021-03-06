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
local fogMap = require('engine/maps/fogMap')
local animationsMap = require('engine/maps/animationsMap')
-- view interface function
local viewInterface = require('engine/interface')
-- effects
local rain = require('engine/effects/rain')
local lightning = require('engine/effects/lightning')
-- windows
local help = require('engine/windows/help')
local inventory = require('engine/windows/inventory')
local map = require('engine/windows/map')
-- classes
local Animation = require('engine/Animation')

local viewManager = {
  font = nil,
  screens = {
    [screens.start] = start,
    [screens.loading] = loading,
    [screens.dead] = dead,
    [screens.win] = win
  },
  window = nil,
  windows = {
    help = help,
    inventory = inventory, 
    map = map,
  },
  views = {},
  sprites = {},
  animations = {},
  audio = {},
  map = {},
  effects = {},
  directions = {}
}

function viewManager:load(updateCallback)
  for key, val in pairs(spritesMap) do
    local sprite = val(self.loadSprite)
    if(animationsMap[key]) then
      self.animations[key] = Animation:new(sprite())
    end
    
    self.sprites[key] = sprite
  end
  self.font = love.graphics.newFont('assets/fonts/manaspc.ttf')

  mediator:subscribe('control.main.show_help', 'view', self:setWindow('help'))
  mediator:subscribe('control.main.show_inventory', 'view', self:setWindow('inventory'))
  mediator:subscribe('control.main.show_map', 'view', self:setWindow('map'))
  mediator:subscribe('control.interface.escape', 'view', self:closeWindow())
  mediator:subscribe('control.interface.return', 'view', self:closeWindow())
  mediator:subscribe('view.direction.change', 'view', self:changeDirection())

end

function viewManager:changeDirection()
  return function(data)
    self.directions[data.id] = data.direction
  end
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

function viewManager:getQuad(name, sprite)
  local animation = self.animations[name]
  if(animation) then 
    return animation:getFrame()
  end
  return love.graphics.newQuad(0, 0, 32, sprite:getHeight(), sprite:getDimensions())
end

function viewManager:clearMap(map)
  for i = 1, config.mapWidth do
    map[i] = {}
    for j = 1, config.mapHeight do
      map[i][j] = nil
    end
  end
end

function viewManager:updateAnimations(dt)
  for key, val in pairs(self.animations) do
    val:update(dt)
  end
end

function viewManager:addToMap(items, map)
  for key, val in pairs(items) do
    if self.views[val.id] then
      map[val.coordX][val.coordY] = self.views[val.id]
    else
      local sprite = viewManager:getSprite(val.name)
      map[val.coordX][val.coordY] = {sprite = sprite, data = val}
      self.views[val.id] = {sprite = sprite, data = val}
    end
  end
end

function viewManager:getViewBorders(centralPoint)
  return {
    xStart = centralPoint.x - config.mapPadding,
    xEnd = centralPoint.x + config.mapPadding,
    yStart = centralPoint.y - config.mapPadding,
    yEnd = centralPoint.y + config.mapPadding
  }
end

function viewManager:closeWindow()
  return function()
    mediator:call('control.setMode', 'main')
    self.window = nil
  end
end

function viewManager:setWindow(window)
  return function()
    mediator:call('control.setMode', 'interface')
    self.window = window
  end
end

-- this way of params sharing is not good
function viewManager:showWindow(player)
  if self.window then
    self.windows[self.window]:show(self.font, player, self.map, fogMap.items)
  end
end
-- @TODO refactoring
function viewManager:drawFrame(playerCoords, viewRange)
  local grass = grassMap:getMap(function(type) return self:getSprite(type) end)
  local fog = fogMap:getMap(playerCoords.x, playerCoords.y, viewRange)
  local viewBorders = viewManager:getViewBorders(playerCoords)
  local yoffset = 0
  
  for i = viewBorders.yStart, viewBorders.yEnd do
    local xoffset = 0
    for j = viewBorders.xStart, viewBorders.xEnd do
      if i > 0 and j > 0 and j < config.mapWidth and i < config.mapHeight then
        love.graphics.draw(grass[j][i], xoffset, yoffset)
        -- draw lover effects
        if self.effects[j][i] and not fog[j][i] then
          local drawable = self.effects[j][i]
          if not drawable.data.overlapping then
            love.graphics.draw(drawable.sprite, self:getQuad(drawable.data.name, drawable.sprite), xoffset, yoffset)
          end
        end
        -- draw content
        if self.map[j][i] and not fog[j][i] then
          local drawable = self.map[j][i]
          local scale = 1
          local offsetx = 0
          if self.directions[drawable.data.id] == 'left'then 
            scale = -1
            offsetx = 32
          end
          love.graphics.draw(drawable.sprite, self:getQuad(drawable.data.name, drawable.sprite), xoffset, yoffset - (drawable.sprite:getHeight() - 32), 0, scale, 1, offsetx)
        end
        -- draw upper effects
        if self.effects[j][i] and not fog[j][i] then
          local drawable = self.effects[j][i]
          if drawable.data.overlapping then
            love.graphics.draw(drawable.sprite, self:getQuad(drawable.data.name, drawable.sprite), xoffset, yoffset)
          end
        end
        -- @TODO refactoring this
        if fog[j][i] then
          local r, g, b, a = love.graphics.getColor( )
          love.graphics.setColor(0, 0, 0)
          love.graphics.rectangle( 'fill', xoffset, yoffset, 32, 32 )
          love.graphics.setColor(r, g, b, a)
        end
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

function viewManager:view(data, dt)
  self:updateAnimations(dt)
  self:clearMap(self.map)
  self:clearMap(self.effects)
  self:addToMap(data.items, self.map)
  self:addToMap(data.creatures, self.map)
  self:addToMap(data.objects, self.map)
  self:addToMap(data.containers, self.effects)

  self:drawFrame(data.player:getCoords(), data.player:getViewRange())
  viewInterface(self.font, self.sprites, data.player)
  self:showWindow(data.player)
end

return viewManager