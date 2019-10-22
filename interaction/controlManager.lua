local curses = require "curses"
local stdscr = curses.initscr ()

local inputActions = require('/interaction/controlMap')

local controlManager = {}

function controlManager:listen()
  local key = stdscr:getch ()
  if inputActions[key] then 
    mediator:call('control.' .. inputActions[key])
  else 
    self:listen()
  end
end

return controlManager