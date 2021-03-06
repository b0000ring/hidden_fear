-- classes
local Object = require('classes/basic/Object')
local HorizontalWall = require('classes/objects/HorizontalWall')
local VerticalWall = require('classes/objects/VerticalWall')
local Door = require('classes/objects/Door')
local Nothing = require('classes/basic/Nothing')
local Floor = require('classes/containers/Floor')

local House = {}

function House:new(x, y, width, height, keyId)

  local newObj = {}

  function drawVerticalWall(x, y)
    mediator:call('store.objects.addSpecial', VerticalWall:new(x, y))
  end

  function drawHorizontalWall(x, y)
    mediator:call('store.objects.addSpecial', HorizontalWall:new(x, y))
  end

  function drawDoor(x, y)
    mediator:call('store.objects.addSpecial', Door:new(x, y, keyId))
  end
  
  local currentX = x
  local currentY = y
  local isKeyCreated = false
  for i = currentX - 1, currentX + width + 1 do
    drawHorizontalWall(i, y)
  end
  for i = currentX - 1, currentX + width + 1 do
    drawHorizontalWall(i, y + height)
  end
  for i = currentY - 1, currentY + height + 1 do
    if i ~= y + math.floor(height / 2) then
      drawVerticalWall(x, i)
    else
      drawDoor(x, i, keyId)
    end
  end
  for i = currentY - 1, currentY + height + 1 do
    drawVerticalWall(x + width, i)
  end
  -- fill by nothing to prevent generating inside of house
  for i = x, x + width do
    for j = y, y + height do
      mediator:call('store.objects.addSpecial', Nothing:new(i, j))
      mediator:call('store.containers.addSpecial', Floor:new( i, j))
    end
  end

end

return House