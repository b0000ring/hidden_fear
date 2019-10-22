local curses = require("curses")
stdscr = curses.initscr ()
stdscr:addstr(stdscr:getch())
stdscr:getch()