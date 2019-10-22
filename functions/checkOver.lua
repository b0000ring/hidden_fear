local isDead = false
local isWin = false

mediator:subscribe('player.dead', '', function() isDead = true end)
mediator:subscribe('boss.dead', '', function() isWin = true end)

function checkOver()
  if isDead then return 'dead' end
  if isWin then return 'win' end 
end

return checkOver