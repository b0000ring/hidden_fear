local dead = {}

function dead.show(stdscr, curses)
	stdscr:clear()
	stdscr:addstr("\n\n\n\n\n\n\n\n")
	stdscr:addstr("   || || |||||| ||  ||   ||||   || ||||||  \n")
	stdscr:addstr("   || || ||  || ||  ||   ||  ||    ||  \n")
	stdscr:addstr("    ||   ||  || ||  ||   ||  || || |||| \n")
	stdscr:addstr("    ||   ||  || ||  ||   ||  || || ||  \n")
	stdscr:addstr("    ||   |||||| ||||||   ||||   || ||||||  \n")
	stdscr:refresh()
	curses.napms(3000)
	os.exit (0)
end

return dead