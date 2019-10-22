local loading = {}

function loading.show(stdscr, curses)
	stdscr:clear()
	stdscr:addstr("\n\n\n\n\n\n\n\n")
	stdscr:addstr("   ||    ||||||      ||      ||||    ||  ||    ||  |||||| \n")
	stdscr:addstr("   ||    ||  ||     ||||     ||  ||      ||||  ||  ||  \n")
	stdscr:addstr("   ||    ||  ||    ||  ||    ||  ||  ||  || || ||  || ||| \n")
	stdscr:addstr("   ||    ||  ||   ||||||||   ||  ||  ||  ||  ||||  ||  || \n")
	stdscr:addstr("   ||||  ||||||  ||      ||  ||||    ||  ||    ||  |||||| \n")
	stdscr:refresh()
	curses.napms(2000)
end

return loading