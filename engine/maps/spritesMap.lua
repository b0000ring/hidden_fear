-- constants
local CREATURES_TYPES = require('constants/creatures')
local OBJECTS_TYPES = require('constants/objects')
local ITEMS_TYPES = require('constants/items')

function load(names)
  return function(loader)
    local sprites = {}
    for key, name in pairs(names) do
      table.insert(sprites, loader(name))
    end
    return function()
      local number = math.floor(math.random(1, #sprites))
      return sprites[number]
    end
  end
end


-- function returns a filename
local spritesMap = {
  -- creatures
  [CREATURES_TYPES.player] = load({'player'}),
  [CREATURES_TYPES.monster] = load({'monster'}),
  [CREATURES_TYPES.zombie] = load({'zombie'}),
  [CREATURES_TYPES.boss] = load({'boss'}),
  [CREATURES_TYPES.imp] = load({'imp'}),
  -- objects
  [OBJECTS_TYPES.bush] = load({'bush'}),
  [OBJECTS_TYPES.tree] = load({'tree1', 'tree2'}),
  [OBJECTS_TYPES.horizontal_wall] = load({'horizontal_wall'}),
  [OBJECTS_TYPES.vertical_wall] = load({'vertical_wall'}),
  [OBJECTS_TYPES.nothing] = load({'nothing'}),
  [OBJECTS_TYPES.door] = load({'door'}),
  [OBJECTS_TYPES.trap] = load({'trap'}),
  [OBJECTS_TYPES.grass] = load({'grass1', 'grass2'}),
  -- items
  [ITEMS_TYPES.shotgun] = load({'shotgun'}),
  [ITEMS_TYPES.pistol] = load({'pistol'}),
  [ITEMS_TYPES.knife] = load({'knife'}),
  [ITEMS_TYPES.health] = load({'health'}),
  [ITEMS_TYPES.shotgun_bullets] = load({'shotgun_bullets'}),
  [ITEMS_TYPES.pistol_bullets] = load({'pistol_bullets'}),
  [ITEMS_TYPES.key] = load({'key'}),
  [ITEMS_TYPES.laser] = load({'laser'}),

  -- effects
  night_effect = load({'night_effect'}),
}


return spritesMap