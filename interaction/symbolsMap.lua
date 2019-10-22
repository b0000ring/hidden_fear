-- constants
local CREATURES_TYPES = require('constants/creatures')
local OBJECTS_TYPES = require('constants/objects')
local ITEMS_TYPES = require('constants/items')

local symbolsMap = {
  -- creatures
  [CREATURES_TYPES.player] = '@',
  [CREATURES_TYPES.monster] = 'M',
  [CREATURES_TYPES.zombie] = 'Z',
  [CREATURES_TYPES.boss] = 'B',
  -- objects
  [OBJECTS_TYPES.bush] = '&',
  [OBJECTS_TYPES.tree] = 'T',
  [OBJECTS_TYPES.horizontal_wall] = '-',
  [OBJECTS_TYPES.vertical_wall] = '|',
  [OBJECTS_TYPES.nothing] = ' ',
  [OBJECTS_TYPES.door] = '/',
  -- items
  [ITEMS_TYPES.shotgun] = '=',
  [ITEMS_TYPES.pistol] = 'L',
  [ITEMS_TYPES.knife] = '1',
  [ITEMS_TYPES.health] = '+',
  [ITEMS_TYPES.shotgun_bullets] = 's',
  [ITEMS_TYPES.pistol_bullets] = 'p',
  [ITEMS_TYPES.key] = '$',
}


return symbolsMap