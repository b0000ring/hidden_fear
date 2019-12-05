local start = {
  timeToChange = 30,
  showAdvice = true
}

function start:show(font)
  love.graphics.printf('HIDDEN FEAR', font,  270, 200, 352, 'left', 0 , 5)
  if self.showAdvice then 
    love.graphics.printf('PRESS ENTER TO START GAME', font,  340, 400, 352, 'left', 0 , 1.5)
  end
  if self.timeToChange > 0 then
    self.timeToChange = self.timeToChange - 1
  else
    self.timeToChange = 30
    if self.showAdvice then self.showAdvice = false else self.showAdvice = true end
  end
end

return start