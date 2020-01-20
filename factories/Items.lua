-- classes
local Pistol = require('classes/items/Pistol')
local Knife = require('classes/items/Knife')
local Key = require('classes/items/Key')
local PistolBullets = require('classes/items/PistolBullets')
local Shotgun = require('classes/items/Shotgun')
local ShotgunBullets = require('classes/items/ShotgunBullets')
local Health = require('classes/items/Health')
local Laser = require('classes/items/Laser')
-- constants
local ITEMS_TYPES = require('constants/items') 

local objectMap = {
  [ITEMS_TYPES.pistol] = Pistol,
  [ITEMS_TYPES.knife] = Knife,
  [ITEMS_TYPES.key] = Key,
  [ITEMS_TYPES.pistol_bullets] = PistolBullets,
  [ITEMS_TYPES.shotgun] = Shotgun,
  [ITEMS_TYPES.shotgun_bullets] = ShotgunBullets,
  [ITEMS_TYPES.health] = Health,
  [ITEMS_TYPES.laser] = Laser
}

function createItem(type, x, y, isUsed)
  return objectMap[type]:new(x, y, isUsed)
end

return createItem