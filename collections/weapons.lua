-- classes
local Weapon = require('classes/basic/Weapon')
-- constants
local WEAPONS_TYPES = require('constants/weapons')

local weapons = {
  magic = Weapon:new(WEAPONS_TYPES.magic, 3),
  claws = Weapon:new(WEAPONS_TYPES.claws, 3),
  fists = Weapon:new(WEAPONS_TYPES.fists, 1),
  teeths = Weapon:new(WEAPONS_TYPES.teeths, 2),
  pistol = Weapon:new(WEAPONS_TYPES.pistol, 3, 'pistol'),
  shotgun = Weapon:new(WEAPONS_TYPES.shotgun, 4, 'shotgun'),
  batWithNails = Weapon:new(WEAPONS_TYPES.batWithNails, 3),
}

return weapons