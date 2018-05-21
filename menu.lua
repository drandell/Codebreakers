local state = {}

local menu =  { text = string.upper( "Codebreakers" ), x = 0, y = 75};
local sub_menu =  { text = 'Developed by Wizardry Games', x = 0, y = 145};
local y_offset = conf.game_height - 100;

function state:new()
	return lovelyMoon.new(self)
end

function state:load()
	state.titleFont = love.graphics.newFont('content/o-ten-one/handy-andy.otf', 60);
	state.smallFont = love.graphics.newFont('content/o-ten-one/handy-andy.otf', 18);
	state.current_option = 1;
	state.options = {
		{text = 'START', selected = false},
		{text = 'QUIT', selected = false}
	}
end

function state:close()
	
end

function state:enable()
	state.current_option = 1;
	lovelyMoon.enableState('menu_entities');
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
			love.graphics.setColor(bright_yellow);
		else
			love.graphics.setColor(white);
		end
		
		love.graphics.print(state.options[i].text, math.floor((conf.game_width / 2) - helper:getTextLenCenter(state.options[i].text)), math.floor(y_offset + i * 25));
	end
end

function state:keypressed(key, scancode, isrepeat)
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
		if state.current_option == 1 then
			lovelyMoon.switchState("menu", "level_selection");
		elseif state.current_option == 2 then
			love.event.quit();
		end
	end
end

function state:keyreleased(key, scancode)
end

return state