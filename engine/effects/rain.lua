local rain = {
  blobs = {},
  maxBlobs = 100,
}

function rain:generateBlob()
  table.insert(self.blobs, {
    length = math.floor(math.random(5, 10)),
    frames = 30,
    x = math.floor(math.random(-500, 600)),
    y = 0,
  })
end

function rain:render()
  local r, g, b, a = love.graphics.getColor( )
  love.graphics.setColor(0, 83, 105)
  for key, val in pairs(self.blobs) do
    love.graphics.line(val.x, val.y, val.x + val.length, val.y + val.length)
  end
  love.graphics.setColor(r, g, b, a)
end

function rain:moveAll()
  for key, val in pairs(self.blobs) do
    val.x = val.x + 20
    val.y = val.y + 20
    val.frames = val.frames - 1
    if val.frames <= 0 then
      self.blobs[key] = nil
    end
  end
end

function rain:makeFrame()
  self:moveAll()  
  self:render()
  if #self.blobs < self.maxBlobs then
    self:generateBlob()
  end
end

return rain