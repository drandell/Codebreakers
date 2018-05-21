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
		{21, 0, 3, 0, 12, 0, 15, 0, 8, 0, 22, 0, 14},
		{13, 8, 6, 22, 13, 13, 18, 0, 21, 23, 1, 6, 8},
		{22, 0, 13, 0, 3, 0, 14, 0, 21, 0, 7, 0, 4},
		{16, 22, 9, 15, 17, 13, 9, 26, 8, 0, 22, 24, 8},
		{0, 0, 26, 0, 0, 0, 26, 0, 4, 22, 12, 0, 4},
		{2, 22, 6, 8, 15, 0, 6, 0, 9, 0, 8, 0, 25},
		{8, 0, 0, 0, 3, 12, 8, 22, 26, 0, 26, 0, 8},
		{14, 22, 1, 9, 3, 0, 0, 0, 22, 12, 17, 3, 14},
		{12, 0, 8, 0, 17, 9, 6, 11, 17, 0, 0, 0, 8},
		{8, 0, 17, 0, 11, 0, 22, 0, 8, 4, 25, 8, 1},
		{2, 0, 11, 9, 15, 0, 10, 0, 0, 0, 9, 0, 0},
		{17, 3, 14, 0, 22, 19, 23, 22, 2, 13, 22, 26, 8},
		{9, 0, 3, 0, 18, 0, 4, 0, 3, 0, 15, 0, 22},
		{20, 8, 26, 23, 8, 0, 2, 3, 5, 9, 8, 15, 17},
		{8, 0, 8, 0, 14, 0, 15, 0, 8, 0, 1, 0, 15} 
	};

	key = {
		'd', 'p', 'o', 'm', 'k', 'g', 'j', 'e', 'i', 'z', 'h', 'c', 'l',
		'r', 's', 'w', 't', 'y', 'q', 'v', 'f', 'a', 'u', 'x', 'b', 'n' 
	};  
	
	player_key = {}
	player_key[17] = {key = 't', changeable = false};
	player_key[3] = {key = 'o', changeable = false};
	player_key[14] = {key = 'r', changeable = false};
	
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