local lightning = {
  timer = 150,
  pause = 0,
  lightnings = 0
}

function lightning:generateLightning()
  self.lightnings = math.floor(math.random(1, 3))
end

function lightning:flashLightning()
    self.lightnings = self.lightnings - 1
    self.pause = math.floor(math.random(10, 50)),
    love.graphics.rectangle( 'fill', 0, 0, 672, 672 )
end

function lightning:makeFrame()
  if self.lightnings > 0 then
    if self.pause <= 0 then
      self:flashLightning()
    else
      self.pause = self.pause - 1
    end
  else
    if self.timer == 0 then
      self.timer = math.floor(math.random(1500, 3000))
    else
      self.timer = self.timer - 1
      if self.timer == 0 and self.lightnings == 0 then
        self:generateLightning()
      end
    end
  end

  
end

return lightning