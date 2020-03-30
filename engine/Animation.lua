local Animation = {}

function Animation:new(image)
  local newObj = {
    image = image,
    duration = math.ceil(image:getWidth() / 64),
    quads = {},
    currentTime = 0
  }

  local height = 32
  local width = 32 

  for y = 0, newObj.image:getHeight() - height, height do
      for x = 0, newObj.image:getWidth() - width, width + 32 do
          table.insert(newObj.quads, love.graphics.newQuad(x, y, width, height, newObj.image:getDimensions()))
      end
  end

  function newObj:getFrame()
    local spriteNum = math.floor(self.currentTime / self.duration * #self.quads) + 1
    return self.quads[spriteNum]
  end

  function newObj:update(dt)
    self.currentTime = self.currentTime + math.ceil(dt) / 5
    if self.currentTime >= self.duration then
      self.currentTime = self.currentTime - self.duration
    end
  end

  self.__index = self
  return setmetatable(newObj, self)
end

return Animation