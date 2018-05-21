local state = {}

local menu =  { text = string.upper( "Codebreakers" ), x = 0, y = 75};
local sub_menu =  { text = 'Developed by Wizardry Games', x = 0, y = 145};
local start_y_offset = 300;
local final_y_offset = conf.game_height - 50;
local key_down = true;

function state:new()
	return lovelyMoon.new(self)
end

function state:load()
	state.titleFont = love.graphics.newFont('content/o-ten-one/handy-andy.otf', 60);
	state.smallFont = love.graphics.newFont('content/o-ten-one/handy-andy.otf', 18);
	state.current_option = 1;
	
	state.levels_dir = '/levels/';
	state.options = love.filesystem.getDirectoryItems( state.levels_dir );
	state.options[#state.options+1] = 'RETURN';
	
	for i = 1, #state.options-1 do
		state.options[i] = string.sub(state.options[i], 1, #state.options[i]-4);
	end
	
end

function state:close()
	
end

function state:enable()
	if love.keyboard.isDown('return') then
		key_down = true;
	end
end

function state:disable()
	
end

function state:update(dt)
	
end

function state:draw()
	love.graphics.clear(bg_blue);
	
	love.graphics.setColor(white)
	love.graphics.setFont(state.titleFont);
	
	menu.x =  (conf.game_width / 2) - helper:getTextLenCenter(menu.text);
	love.graphics.print(menu.text, menu.x, menu.y);
	
	love.graphics.setFont(state.smallFont);
	
	sub_menu.x = (conf.game_width / 2) - helper:getTextLenCenter(sub_menu.text);
	love.graphics.print(sub_menu.text, sub_menu.x, sub_menu.y);
	
	love.graphics.setFont(standard_font);
	
	for i in ipairs(state.options) do
		if i == state.current_option then
			love.graphics.setColor(255,223,0, 255);
		else
			love.graphics.setColor(255,255,255, 255);
		end
		
		if i ~= #state.options then
			love.graphics.print(state.options[i], math.floor((conf.game_width / 2) - helper:getTextLenCenter(state.options[i])), math.floor(start_y_offset + i * 25));
		end
	end
	
	love.graphics.print(state.options[#state.options], math.floor((conf.game_width / 2) - helper:getTextLenCenter(state.options[#state.options])), final_y_offset);
end

function state:keypressed(key, unicode)
	if love.keyboard.isDown(key) and not key_down then
	
	if key == 'up' then
		state.current_option = state.current_option - 1;
	elseif key == 'down' then 
		state.current_option = state.current_option + 1;
	end
	
	if state.current_option < 1 then
		state.current_option = #state.options;
	elseif state.current_option > #state.options then
		state.current_option = 1;
	end
	
	if key == 'return' then
		if state.current_option ~= #state.options then
			levels.current_level = state.current_option;
			lovelyMoon.enableState(levels[state.current_option]._id);
			lovelyMoon.disableState('menu_entities');
			lovelyMoon.switchState("level_selection", "game"); 
		else
			state.current_option = 1;
			lovelyMoon.switchState("level_selection", "menu");
		end
	end
	end
end

function state:keyreleased(key, unicode)
	key_down = false;
end

return state