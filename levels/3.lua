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
		{0, 13, 17, 26, 11, 23, 0, 19, 6, 18, 19, 17, 0},
		{23, 0, 9, 0, 5, 0, 5, 0, 17, 0, 12, 0, 13},
		{7, 26, 17, 1, 3, 5, 13, 17, 23, 0, 12, 5, 26},
		{15, 0, 2, 0, 15, 0, 5, 0, 12, 0, 17, 0, 25},
		{14, 10, 5, 15, 6, 0, 15, 0, 10, 25, 26, 26, 9},
		{17, 0, 10, 0, 13, 17, 6, 26, 17, 0, 10, 0, 6},
		{18, 25, 10, 12, 0, 4, 0, 5, 0, 8, 9, 14, 17},
		{0, 15, 0, 17, 21, 19, 5, 2, 10, 17, 0, 15, 0},
		{23, 3, 15, 6, 0, 18, 0, 2, 0, 7, 15, 6, 23},
		{15, 0, 6, 0, 2, 17, 22, 15, 12, 0, 6, 0, 12},
		{10, 15, 24, 17, 26, 0, 16, 0, 7, 5, 24, 17, 26},
		{17, 0, 15, 0, 25, 0, 25, 0, 17, 0, 25, 0, 5},
		{6, 25, 12, 0, 6, 25, 26, 11, 5, 10, 15, 12, 9},
		{1, 0, 17, 0, 20, 0, 18, 0, 3, 0, 1, 0, 23},
		{17, 5, 23, 15, 17, 26, 0, 5, 23, 3, 17, 18, 0} 
	};

	key = {
		'c', 'b', 'k', 'x', 'a', 'n', 'w', 'h', 'y', 'l', 'm', 't', 'g',
		'p', 'i', 'j', 'e', 'd', 'u', 'z', 'q', 'f', 's', 'v', 'o', 'r' 
	};  
	
	player_key = {}
	player_key[14] = {key = 'p', changeable = false};
	player_key[15] = {key = 'i', changeable = false};
	player_key[6] = {key = 'n', changeable = false};
	
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