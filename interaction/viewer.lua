-- libraries
local curses = require "curses"
local stdscr = curses.initscr ()
-- screens
local start = require('interaction/screens/start')
local loading = require('interaction/screens/loading')
local dead = require('interaction/screens/dead')
local win = require('interaction/screens/win')
-- maps
local symbolsMap = require('interaction/symbolsMap')
-- view interface function
local viewInterface = require('interaction/interface')
local viewer = {
  map = {}, 
  screens = {
    start = start,
    loading = loading,
    dead = dead,
    win = win
  }
}

function viewer:init()
  curses.resizeterm (50, 60)
  curses.cbreak ()
  curses.echo (false)	-- not noecho !
  curses.nl (false)	-- not nonl !
  stdscr:clear ()
end

function viewer:showScreen(screen)
  return self.screens[screen].show(stdscr, curses)
end

function viewer:getSymbol(name)
  return symbolsMap[name]
end

function viewer:clearMap()
  self.map = {}
  for i = 1, config.mapWidth do
    self.map[i] = {}
    for j = 1, config.mapHeight do
      self.map[i][j] = '.'
    end
  end
end

function viewer:addToMap(items)
  for key, val in pairs(items) do
    self.map[val.coordX][val.coordY] = viewer:getSymbol(val.name)
  end
end

function viewer:viewMap(playerCoords)
  for i = playerCoords.y - config.mapPadding / 2, playerCoords.y + config.mapPadding - config.mapPadding / 2 do
    for j = playerCoords.x - config.mapPadding, playerCoords.x + config.mapPadding do
      stdscr:addstr(self.map[j][i])
    end
    stdscr:addstr('\n')
  end
end

function viewer:view(creatures, objects, items, player)
  stdscr:clear()
  self:clearMap()
  self:addToMap(items)
  self:addToMap(creatures)
  self:addToMap(objects)
  self:viewMap(player:getCoords())
  viewInterface(stdscr, player)
  stdscr:refresh()
end

return viewer