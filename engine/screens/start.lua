local start = {}

function start.show(stdscr)
	stdscr:addstr("\n\n")
	stdscr:addstr("||  ||  ||  ||||    ||||    ||||||  ||    ||\n")
	stdscr:addstr("||  ||      ||  ||  ||  ||  ||      ||||  ||\n")
	stdscr:addstr("||||||  ||  ||  ||  ||  ||  ||||||  || || ||\n")
	stdscr:addstr("||  ||  ||  ||  ||  ||  ||  ||      ||  ||||\n")
	stdscr:addstr("||  ||  ||  ||||    ||||    ||||||  ||    ||\n")
	stdscr:addstr("\n")
	stdscr:addstr("\n")
	stdscr:addstr("\n")
	stdscr:addstr("                press any key... \n")
	stdscr:addstr("\n")
	stdscr:addstr("\n")
	stdscr:addstr("\n")
	stdscr:addstr("     ||||||  ||||||      ||      ||||||\n")
	stdscr:addstr("     ||      ||         ||||     ||  ||\n")
	stdscr:addstr("     ||||    ||||||    ||  ||    ||||| \n")
	stdscr:addstr("     ||      ||       ||||||||   ||  ||\n")
	stdscr:addstr("     ||      ||||||  ||      ||  ||   ||\n")
	stdscr:getch ()
	stdscr:getch ()
	stdscr:getch ()
end

return start