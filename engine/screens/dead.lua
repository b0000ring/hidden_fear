local dead = {
  timeToChange = 30,
  showAdvice = true
}

function dead:show(font)
	love.graphics.printf('YOU DEAD...', font,  320, 200, 352, 'left', 0 , 5)

	if self.showAdvice then 
    love.graphics.printf('PRESS ENTER TO QUIT GAME', font,  350, 400, 352, 'left', 0 , 1.5)
  end
  if self.timeToChange > 0 then
    self.timeToChange = self.timeToChange - 1
  else
    self.timeToChange = 30
    if self.showAdvice then self.showAdvice = false else self.showAdvice = true end
  end
end

return dead