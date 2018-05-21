local state = {}

function state:new()
	return lovelyMoon.new(self)
end

function state:load()

end

function state:close()
	
end

function state:enable()
  level = {
		{0, 15, 0, 8, 0, 4, 0, 26, 16, 6, 15, 24, 15},
		{4, 21, 22, 11, 1, 14, 4, 24, 0, 2, 0, 0, 14},
		{0, 26, 0, 12, 0, 16, 0, 9, 13, 6, 18, 18, 15},
		{15, 14, 23, 4, 0, 4, 21, 6, 0, 15, 0, 0, 8},
		{2, 0, 0, 7, 26, 14, 0, 22, 15, 1, 1, 11, 5},
		{2, 24, 6, 22, 0, 0, 0, 15, 0, 0, 0, 7, 0},
		{4, 0, 0, 11, 0, 20, 4, 5, 0, 14, 15, 22, 2},
		{24, 0, 0, 15, 8, 4, 0, 4, 7, 4, 0, 0, 25},
		{5, 4, 19, 5, 0, 24, 11, 14, 0, 10, 0, 0, 6},
		{0, 7, 0, 0, 0, 16, 0, 0, 0, 4, 8, 4, 4},
		{7, 15, 3, 3, 1, 4, 0, 5, 26, 9, 0, 0, 15},
		{6, 0, 0, 11, 0, 15, 26, 7, 0, 5, 15, 2, 18},
		{9, 15, 24, 17, 11, 24, 0, 6, 0, 26, 0, 4, 0},
		{18, 0, 0, 4, 0, 9, 11, 21, 8, 11, 6, 24, 14},
		{2, 9, 15, 7, 9, 4, 0, 8, 0, 24, 0, 14, 0}
	};

	key = {
		'l', 's', 'f', 'e', 't', 'u', 'r', 'p', 'c', 'j', 'o', 'w', 'h',
		'd', 'a', 'g', 'y', 'k', 'x', 'v', 'm', 'b', 'z', 'n', 'q', 'i' 
	};  
	
	player_key[22] = {key = 'b', changeable = false};
	player_key[11] = {key = 'o', changeable = false};
	player_key[7] = {key = 'r', changeable = false};
	
	--[[ Testing
	player_key[1] = {key = 'l', changeable = false};
	player_key[2] = {key = 's', changeable = false};
	player_key[3] = {key = 'f', changeable = false};
	player_key[4] = {key = 'e', changeable = false};
	player_key[5] = {key = 't', changeable = false};
	player_key[6] = {key = 'u', changeable = false};
	
	player_key[8] = {key = 'p', changeable = false};
	player_key[9] = {key = 'c', changeable = false};
	player_key[10] = {key = 'j', changeable = false};
	
	player_key[12] = {key = 'w', changeable = false};
	player_key[13] = {key = 'h', changeable = false};
	player_key[14] = {key = 'd', changeable = false};
	player_key[15] = {key = 'a', changeable = false};
	player_key[16] = {key = 'g', changeable = false};
	player_key[17] = {key = 'y', changeable = false};
	player_key[18] = {key = 'k', changeable = false};
	player_key[19] = {key = 'x', changeable = false};
	player_key[20] = {key = 'v', changeable = false};
	player_key[21] = {key = 'm', changeable = false};
	player_key[23] = {key = 'z', changeable = false};
	player_key[24] = {key = 'n', changeable = false};
	player_key[25] = {key = 'q', changeable = false};
	player_key[26] = {key = 'i', changeable = false};
	]]--
end

function state:disable()
	
end

function state:update(dt)
	
end

function state:draw()
	
end

function state:keypressed(key, unicode)
	
end

function state:keyreleased(key, unicode)
	
end

return state