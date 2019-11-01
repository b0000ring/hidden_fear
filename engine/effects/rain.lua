local rain = {
  blobs = {},
  maxBlobs = 20,
  splashes = {},
  maxSplashes = 20
}

function rain:generateBlobs(count)
  for i = 1, count do
    self:generateBlob()
  end
end

function rain:generateBlob()
  table.insert(self.blobs, {
    length = math.floor(math.random(2, 5))
    frames = math.floor(math.random(5, 50))
  })
end

function rain:generateSplash()

end

function rain:moveALl()
  for key, val in pairs(self.blobs) do

  end

  for key, val in pairs(self.splashes) do

  end
end

function rain:makeFrame()
  self:moveAll()  
  if self.blobs < self.maxBlobs then
    self:generateBlobs(self.maxBlobs - self.blobs)
  end
end