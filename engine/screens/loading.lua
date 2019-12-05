local loading = {}

function loading:show(font)
	love.graphics.printf('LOADING', font,  450, 300, 352, 'left', 0 , 2)
end

return loading