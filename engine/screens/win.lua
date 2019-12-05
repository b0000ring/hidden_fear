local win = {
  timeToChange = 30,
  showAdvice = true
}

function win:show(font)
	love.graphics.printf('YOU WIN!', font,  320, 150, 352, 'left', 0 , 5)
	love.graphics.printf('You have defeat powerfull great evil!', font,  250, 300, 352, 'left', 0 , 1.5)
	love.graphics.printf('Martenses ancient curse was destroyed!', font,  250, 320, 352, 'left', 0 , 1.5)
	love.graphics.printf('You lucky to be survived!', font,  250, 340, 352, 'left', 0 , 1.5)
	love.graphics.printf('But can you forget this hidden fear?', font,  250, 360, 352, 'left', 0 , 1.5)

	if self.showAdvice then 
    love.graphics.printf('PRESS ENTER TO QUIT GAME', font,  330, 500, 352, 'left', 0 , 1.5)
  end
  if self.timeToChange > 0 then
    self.timeToChange = self.timeToChange - 1
  else
    self.timeToChange = 30
    if self.showAdvice then self.showAdvice = false else self.showAdvice = true end
  end
end

return win