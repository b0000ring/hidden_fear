local win = {}

function win.show(stdscr, curses)
	stdscr:clear()
	stdscr:addstr("\n\n\n\n\n\n\n\n")
	stdscr:addstr("        You have defeat powerfull great evil!  \n")
	stdscr:addstr("        Martenses ancient curse was destroyed!  \n")
	stdscr:addstr("        You lucky to be survived! \n")
	stdscr:addstr("        But can you forget this hidden fear?\n")
	stdscr:refresh()
	curses.napms(3000)
	os.exit (0)
end

return win