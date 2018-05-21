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
		{15, 12, 12, 5, 24, 8, 0, 4, 7, 1, 5, 18, 26},
		{4, 0, 15, 0, 17, 0, 0, 0, 18, 0, 11, 0, 11},
		{26, 3, 18, 17, 4, 26, 0, 5, 19, 9, 5, 23, 7},
		{5, 0, 25, 0, 0, 1, 13, 24, 0, 0, 18, 0, 18},
		{18, 5, 7, 6, 6, 14, 0, 19, 14, 22, 24, 5, 11},
		{20, 0, 18, 0, 0, 26, 0, 15, 0, 0, 7, 0, 6},
		{5, 8, 8, 14, 0, 19, 0, 17, 0, 26, 6, 15, 5},
		{0, 15, 0, 7, 13, 18, 8, 18, 15, 2, 0, 7, 0},
		{10, 5, 18, 1, 0, 7, 0, 7, 0, 14, 7, 18, 24},
		{15, 0, 5, 0, 0, 2, 0, 22, 0, 0, 8, 0, 15},
		{4, 13, 26, 16, 17, 5, 0, 13, 24, 12, 7, 24, 11},
		{6, 0, 19, 0, 0, 18, 17, 24, 0, 0, 2, 0, 19},
		{5, 21, 13, 26, 11, 26, 0, 22, 6, 13, 11, 19, 3},
		{26, 0, 24, 0, 15, 0, 0, 0, 5, 0, 15, 0, 5},
		{26, 13, 8, 13, 24, 22, 0, 8, 5, 4, 18, 13, 26} 
	};

	key = {
		'k', 'p', 'h', 'b', 'e', 'l', 'a', 'd', 'z', 'j', 't', 'f', 'i',
		'y', 'o', 'q', 'u', 'r', 'c', 'v', 'x', 'g', 'm', 'n', 'w', 's' 
	};  
	
	player_key = {}
	player_key[24] = {key = 'n', changeable = false};
	player_key[17] = {key = 'u', changeable = false};
	player_key[4] = {key = 'b', changeable = false};
	
	--[[ Testing
	player_key[1] = {key = 'o', changeable = false};
	player_key[2] = {key = 'n', changeable = false};
	player_key[3] = {key = 't', changeable = false};
	player_key[4] = {key = 'v', changeable = false};
	player_key[5] = {key = 'k', changeable = false};
	player_key[7] = {key = 'j', changeable = false};
	player_key[8] = {key = 'x', changeable = false};
	player_key[9] = {key = 'h', changeable = false};
	player_key[11] = {key = 'y', changeable = false};
	player_key[12] = {key = 'l', changeable = false};
	player_key[13] = {key = 'u', changeable = false};
	
	player_key[14] = {key = 'e', changeable = false};
	player_key[15] = {key = 's', changeable = false};
	player_key[16] = {key = 'f', changeable = false};
	player_key[18] = {key = 'c', changeable = false};
	player_key[19] = {key = 'g', changeable = false};
	player_key[20] = {key = 'i', changeable = false};
	player_key[21] = {key = 'b', changeable = false};
	player_key[22] = {key = 'q', changeable = false};
	player_key[23] = {key = 'd', changeable = false};
	player_key[24] = {key = 'w', changeable = false};
	player_key[25] = {key = 'm', changeable = false};
	player_key[26] = {key = 'z', changeable = false};
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