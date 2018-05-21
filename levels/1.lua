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
		{6, 0, 13, 0, 12, 0, 14, 0, 12, 0, 15, 0, 6},
		{18, 1, 2, 18, 14, 2, 3, 17, 6, 3, 20, 2, 19},
		{17, 0, 7, 0, 24, 0, 9, 0, 18, 0, 8, 0, 19},
		{14, 25, 13, 0, 23, 17, 6, 2, 5, 0, 10, 6, 17},
		{0, 0, 15, 0, 0, 0, 2, 0, 12, 20, 14, 0, 6},
		{15, 20, 3, 14, 15, 0, 1, 0, 13, 0, 2, 0, 4},
		{22, 0, 0, 0, 11, 14, 12, 10, 15, 0, 18, 0, 6},
		{13, 2, 20, 1, 2, 0, 0, 0, 3, 9, 14, 16, 3},
		{6, 0, 2, 0, 1, 12, 23, 14, 17, 0, 0, 0, 14},
		{2, 0, 15, 0, 2, 0, 14, 0, 14, 21, 21, 14, 23},
		{23, 0, 3, 9, 11, 0, 18, 0, 0, 0, 17, 0, 0},
		{14, 17, 6, 0, 25, 6, 20, 26, 14, 0, 14, 2, 23},
		{17, 0, 2, 0, 1, 0, 25, 0, 10, 0, 24, 0, 6},
		{14, 2, 18, 1, 13, 17, 6, 19, 14, 25, 14, 2, 3},
		{23, 0, 14, 0, 15, 0, 12, 0, 14, 0, 17, 0, 6} 
	};

	key = {
		'o', 'n', 't', 'v', 'k', 'a', 'j', 'x', 'h', 'p', 'y', 'l', 'u',
		'e', 's', 'f', 'r', 'c', 'g', 'i', 'b', 'q', 'd', 'w', 'm', 'z' 
	};  
	
	player_key = {}
	player_key[10] = {key = 'p', changeable = false};
	player_key[6] = {key = 'a', changeable = false};
	player_key[17] = {key = 'r', changeable = false};
	
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