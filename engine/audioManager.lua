-- maps
local audioMap = require('engine/maps/audioMap')
-- constants
local DESCRIPTION_TYPES = require('constants/descriptions')

local audioManager = {
  audio = {},
}

function audioManager:init()
  for key, val in pairs(audioMap) do
    self.audio[val] = love.audio.newSource('/assets/sounds/' .. val .. '.wav', "static")
  end
  self.audio.rain:setLooping( true )
  love.audio.play(self.audio.rain)
  mediator:subscribe('description.addAction', 'audio', audioManager:play())
end

function audioManager:play(key)
  return function(action)
    local type = action.actionType

    if type == DESCRIPTION_TYPES.move then
      love.audio.play(self.audio.step)
    elseif type == DESCRIPTION_TYPES.attack then 
      if action.instrumentName == 'claws' then 
        love.audio.play(self.audio.hit_claws)
      elseif action.instrumentName == 'knife' then
        love.audio.play(self.audio.hit_knife)
      -- elseif action.instrumentName == 'magic' then
      --   love.audio.play(self.audio.magic)
      -- elseif action.instrumentName == 'teeths' then
      --   love.audio.play(self.audio.teeths)
      -- else if action.instrumentName == 'fists' then
      --   love.audio.play(self.audio.hit_knife)
      elseif action.instrumentName == 'shotgun' then
        love.audio.play(self.audio.shotgun)
      elseif action.instrumentName == 'pistol' then
        love.audio.play(self.audio.pistol)
      end
    elseif type == DESCRIPTION_TYPES.wait then 
     
    elseif type == DESCRIPTION_TYPES.hiding then
    
    elseif type == DESCRIPTION_TYPES.over then
     
    elseif type == DESCRIPTION_TYPES.pickup then
      love.audio.play(self.audio.pickup)
    elseif type == DESCRIPTION_TYPES.fail_pickup then
      love.audio.play(self.audio.impossible)
    elseif type == DESCRIPTION_TYPES.dies then
      
    elseif type == DESCRIPTION_TYPES.heals then
      love.audio.play(self.audio.health)
    elseif type == DESCRIPTION_TYPES.heals_failed then
      love.audio.play(self.audio.impossible)
    elseif type == DESCRIPTION_TYPES.open then
      love.audio.play(self.audio.open_door)
    elseif type == DESCRIPTION_TYPES.drop_weapon then
     
    elseif type == DESCRIPTION_TYPES.cant_open then
      love.audio.play(self.audio.impossible)
    end
  end
end

return audioManager