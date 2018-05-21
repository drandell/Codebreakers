local state = {}

require "libs/round";

local key_lookup = {};
local hints = {current_hint = 0, max_num_of_hints = 3};

local mouse = {x = 0, y = 0}; 
local y_offset = 0;
local start_digit = 0;
local digit_to_render = 0;
local digit_selected = 0;
local x_offset = 100;
local text_offset = 2;
local text_digit_offset = {x = 11, y = 10};
local flashing_text = {x_offset = 14, y_offset = 8, counter = 0, flash_counts = 250, show_time = 250, old_show_time = 250};
local mini_text_offset = {x = 25, y = 15, space_between = 20};
local small_letter_offset = {x = 0, y = 0};
local tile = {width = 40, height = 40};
local time = {start_time = 0, current_time = 0, old_current_time = 0};

-- Buttons
local complete_rect = {x = 0, y = 0, width = 100, height = 50, rx = 10, ry = 10, text = 'Complete', text_offset_y = 15, clicked = false};
local hints_rect = {x = 20, y = 0, width = 100, height = 50, rx = 10, ry = 10, text = 'Hint', text_offset_y = 15, clicked = false};
local go_back_rect = {x = 295, y = 520, width = 100, height = 50, rx = 10, ry = 10, text = 'Go Back', text_offset_y = 15, clicked = false};
local nxt_level_rect = {x = 410, y = 520, width = 100, height = 50, rx = 10, ry = 10, text = 'Next Level', text_offset_y = 15, clicked = false};

-- Alpha Locals
local alpha_count = #alpha;
local half_alpha_count = #alpha / 2;

-- ASCII codes
local a_lower_ascii_code = 65;
local z_lower_ascii_code = 90;
local a_upper_ascii_code = 97;
local z_upper_ascii_code = 122;

local level_status = {completed = false, errors_remaining = 0, total_number_of_errors = 0};

local error_text = {};
local paused = false;
local current_error = 1;
local go_back_rect_offset = 60;

function state:new()
	return lovelyMoon.new(self)
end

function state:load()
	state.normalFont = love.graphics.newFont(10);
	state.midFont = love.graphics.newFont(14);
	state.normalFontBig = love.graphics.newFont(24);
	state.tiles = love.graphics.newImage('content/tiles.png');
	state.arrow_cursor = love.mouse.getSystemCursor('arrow');
	state.pen_cursor = love.mouse.newCursor( 'content/pen_cursor.png', 0, 15 );
	state.error_icon = love.graphics.newImage('content/info-24.png');
	
	state.blank_quad = love.graphics.newQuad( 0, 0, tile.width, tile.height, state.tiles:getDimensions() );
	state.nil_quad = love.graphics.newQuad( 40, 0, tile.width, tile.height, state.tiles:getDimensions() );
  
	-- Set Line Style
	love.graphics.setLineWidth( 2 );
	love.graphics.setLineStyle( 'rough')
end

function state:close()
	
end

function state:enable()
	-- Create key-lookup table
	for i,j in pairs(player_key) do
		key_lookup[j.key] = true;
	end
	
	math.randomseed(os.time());
	
	hints.current_hint = 0;
	hints.max_num_of_hints = 3;
	paused = false;
	
	local hint = 0;
	while #hints < hints.max_num_of_hints do
		hint = math.random(1, #alpha);
		
		if player_key[hint] == nil then
			hints[#hints + 1] = {key = hint, value = key[hint]};
		end
	end 
	
	-- Reset status 
	level_status = {completed = false, errors_remaining = 0, total_number_of_errors = 0};
	
	-- If at the last level, center the go back rect
	--if levels.current_level + 1 > #levels then
	--	go_back_rect.x = go_back_rect.x + go_back_rect_offset;
	--end
	
	-- Set Completed Rectangle position
	complete_rect.x = ((#level[1] + 1) * tile.width) + 125;
	complete_rect.y = ((#level + 1) * tile.height) + 55;
	
	-- Set Hints Rectangle position
	hints_rect.x = 20;
	hints_rect.y = ((#level + 1) * tile.height) + 55;
	
	-- Set error text
	error_text[1] = {x = complete_rect.x + complete_rect.width - 24, y = complete_rect.y - 30, text = 'You have errors or have not used every letter.', show = false};
	error_text[2] = {x = hints_rect.x + hints_rect.width - 24, y = hints_rect.y - 30, text = 'No more hints allowed', show = false};
	
	time.start_time = love.timer.getTime();
end

function state:disable()
	-- Clean up old game/level data
	player_key = {};
	level = {};
	key = {};
	key_lookup = {};
	hints = {};
end

function state:update(dt)
	mouse = {x = love.mouse.getX(), y = love.mouse.getY()};
	
	if (osString == "Windows" or osString == "Linux" or osString == "OS X") then 
		if not level_status.completed and not paused then
			if mouse.x >= x_offset + tile.width and mouse.x <=  (x_offset + tile.width) + (#level[1] * tile.width) and mouse.y >= ((#level + 2) * tile.height) + y_offset and mouse.y <= ((#level + 4) * tile.height) + y_offset then
				love.mouse.setCursor(state.pen_cursor);
			else
				love.mouse.setCursor(state.arrow_cursor);
			end
		else
			love.mouse.setCursor(state.arrow_cursor);
		end
	end
	
	if not level_status.completed and not paused then
		time.current_time = round2(love.timer.getTime() -  time.start_time, 2) + time.old_current_time;
	elseif paused then
		time.old_current_time = time.current_time;
		time.start_time = love.timer.getTime();
	end
end

function state:draw()
	love.graphics.clear(bg_blue);
	
	-- Draw Solid Rects for Background Detail
	love.graphics.setColor(white);
	love.graphics.print('Time: ' .. tostring(time.current_time), 0, 0);
	love.graphics.rectangle('fill', x_offset + tile.width,  ((#level + 2) * tile.height) + y_offset , #level[1] * tile.width, tile.height * 2);	
	love.graphics.rectangle('fill', x_offset + tile.width, y_offset + tile.height, #level[1] * tile.width, #level * tile.height);
	love.graphics.setColor(black);

	love.graphics.setFont(state.normalFont);
  
	for i = 1, #level do
		for j = 1, #level[i] do
			if level[i][j] == 0 then
				love.graphics.draw(state.tiles, state.nil_quad, (j * tile.width) + x_offset, (i * tile.height) + y_offset);
			end
		
			love.graphics.line( (j * tile.width) + x_offset, (1 * tile.height) + y_offset, (j * tile.width) + x_offset, ((#level + 1) * tile.height) + y_offset);
			love.graphics.line( (1 * tile.width) + x_offset, (i * tile.height) + y_offset, (j * tile.width) + tile.width + x_offset, (i * tile.height) + y_offset);
			
			if level[i][j] ~= 0 then
				love.graphics.print(tostring(level[i][j]), (j * tile.width) + x_offset + text_offset, (i * tile.height) + y_offset + text_offset);
				
				if player_key[level[i][j]] ~= nil  then
					
						if player_key[level[i][j]].key == 'i' or player_key[level[i][j]].key == 'j' then
							small_letter_offset.x = 5;
							small_letter_offset.y = 2;
						else
							small_letter_offset.x = 0;
							small_letter_offset.y = 0;
						end
					
						love.graphics.setFont(state.normalFontBig);
						love.graphics.print(string.upper(player_key[level[i][j]].key), ( j * tile.width) + x_offset + text_digit_offset.x + small_letter_offset.x, (i * tile.height) + y_offset + text_digit_offset.y - small_letter_offset.y);
						love.graphics.setFont(state.normalFont);
				end
			end
		end
	end

	love.graphics.line( ((#level[1] + 1) * tile.width) + x_offset, (1 * tile.width) + y_offset, ((#level[1] + 1) * tile.width) + x_offset, ((#level + 1) * tile.height) + y_offset);
	love.graphics.line( (1 * tile.width) + x_offset, ((#level + 1) * tile.width) + y_offset, ((#level[1] + 1) * tile.width) + x_offset, ((#level + 1) * tile.height) + y_offset);

	-- Numbers box grid
	for m = 1, 3 do
		-- Horizontal lines
		love.graphics.line( (1* tile.width) + x_offset, (m * tile.height) + y_offset + ((#level + 1) * tile.height), ((#level[1] + 1) * tile.width)  + x_offset, (m * tile.height) + y_offset + ((#level + 1) * tile.height));
	end
	
	for n = 1,14 do
		-- Vertical Lines
		love.graphics.line( (n* tile.width) + x_offset, (1 * tile.height) + y_offset + ((#level + 1) * tile.height), (n * tile.width)  + x_offset, (3 * tile.height) + y_offset + ((#level + 1) * tile.height));
	end

	-- Draw Numbers & Letters in user input box
	for o,p in ipairs (alpha) do
		love.graphics.print(tostring(o), ((o - math.floor ((o - 1) / half_alpha_count) * half_alpha_count) * tile.width) + x_offset + text_offset, (math.ceil(o / half_alpha_count)  * tile.height) + y_offset + ((#level + 1) * tile.height) + text_offset);
		love.graphics.print(alpha[o], x_offset + mini_text_offset.x + (o * mini_text_offset.space_between), y_offset + ((#level + 1) * tile.height) + mini_text_offset.y);
		
		if key_lookup[string.lower(p)] then
			love.graphics.setLineStyle('smooth')
			-- Draw diagonal line through already taken letters
			love.graphics.line(x_offset + mini_text_offset.x + (o * mini_text_offset.space_between), 
				y_offset + ((#level + 1) * tile.height) + (mini_text_offset.y * 2), 
				x_offset + mini_text_offset.x + (o * mini_text_offset.space_between) + (mini_text_offset.space_between / 2), 
				y_offset + ((#level + 1) * tile.height) + mini_text_offset.y);
			love.graphics.setLineStyle('rough')
		end
		
		if player_key[o] ~= nil then
			
			if player_key[o].key == 'i' or player_key[o].key == 'j' then
				small_letter_offset.x = 5;
				small_letter_offset.y = 2;
			else
				small_letter_offset.x = 0;
				small_letter_offset.y = 0;
			end
			
			love.graphics.setFont(state.normalFontBig);
			love.graphics.print(string.upper(player_key[o].key), ((o - math.floor ((o - 1) / half_alpha_count) * half_alpha_count) * tile.width) + x_offset + text_digit_offset.x + small_letter_offset.x, (math.ceil(o / half_alpha_count)  * tile.height) + y_offset + ((#level + 1) * tile.height) + text_digit_offset.y - small_letter_offset.y)
			love.graphics.setFont(state.normalFont);
		end
	end
	
	if player_key[digit_selected] == nil and digit_selected ~= 0 then
		local delta = (love.timer.getDelta() * 1000);
		flashing_text.counter = flashing_text.counter + delta;
		
		if flashing_text.counter >= flashing_text.flash_counts then
			love.graphics.setFont(state.normalFontBig);
			love.graphics.print('|', ((digit_selected - math.floor ((digit_selected - 1) / half_alpha_count) * half_alpha_count) * tile.width) + x_offset + flashing_text.x_offset, (math.ceil(digit_selected / half_alpha_count)  * tile.height) + ((#level + 1) * tile.height) + flashing_text.y_offset)
			love.graphics.setFont(state.normalFont);
			
			flashing_text.show_time = flashing_text.show_time - delta;
			
			if flashing_text.show_time < 0 then
				flashing_text.counter = 0;
				flashing_text.show_time = flashing_text.old_show_time;
			end
		end
	end
	
	love.graphics.setColor(white);
	love.graphics.rectangle('fill', complete_rect.x, complete_rect.y, complete_rect.width, complete_rect.height, complete_rect.rx, complete_rect.ry);
	love.graphics.setColor(black);
	love.graphics.rectangle('line', complete_rect.x, complete_rect.y, complete_rect.width, complete_rect.height, complete_rect.rx, complete_rect.ry);
	love.graphics.setFont(state.midFont);  
	love.graphics.print(complete_rect.text, complete_rect.x + (complete_rect.width / 2) - helper:getTextLenCenter(complete_rect.text), complete_rect.y + complete_rect.text_offset_y);
	
	love.graphics.setColor(white);
	love.graphics.rectangle('fill', hints_rect.x, hints_rect.y, hints_rect.width, hints_rect.height, hints_rect.rx, hints_rect.ry);
	love.graphics.setColor(black);
	love.graphics.rectangle('line', hints_rect.x, hints_rect.y, hints_rect.width, hints_rect.height, hints_rect.rx, hints_rect.ry);
	love.graphics.setFont(state.midFont);  
	love.graphics.print(hints_rect.text, hints_rect.x + (hints_rect.width / 2) - helper:getTextLenCenter(hints_rect.text), hints_rect.y + hints_rect.text_offset_y);
	
	--[[
	love.graphics.setColor(white);
	for  z = 1, #error_text do
		if error_text[z].show then
			love.graphics.draw(state.error_icon, error_text[z].x, error_text[z].y);
		end
	end
	--]]
	
	if level_status.completed then
		
		-- If at the last level, center the go back rect
		if levels.current_level + 1 > #levels then
			go_back_rect.x = go_back_rect.x + go_back_rect_offset;
		end
		
		love.graphics.setColor(half_white);
		love.graphics.rectangle('fill', 0, 0, conf.window_width, conf.window_height);
		love.graphics.setColor(bg_blue);
		love.graphics.rectangle('fill', 200, 200, conf.window_width / 2, conf.window_height / 2);
		love.graphics.setColor(white);
		love.graphics.setFont(standard_font);
		love.graphics.printf('WELL DONE!', 240, 250, 300, 'center')
		love.graphics.setFont(state.normalFontBig);
		love.graphics.printf( 'You successfully completed this level in ' .. tostring(time.current_time) .. ' seconds and made ' .. tostring(level_status.total_number_of_errors) .. ' errors whilst attempting to complete this level. ', 230, 300, 350, 'center')
		
		love.graphics.setColor(white);
		love.graphics.rectangle('fill', go_back_rect.x, go_back_rect.y, go_back_rect.width, go_back_rect.height, go_back_rect.rx, go_back_rect.ry);
		love.graphics.setColor(black);
		love.graphics.rectangle('line', go_back_rect.x, go_back_rect.y, go_back_rect.width, go_back_rect.height, go_back_rect.rx, go_back_rect.ry);
		love.graphics.setFont(state.midFont);  
		love.graphics.print(go_back_rect.text, go_back_rect.x + (go_back_rect.width / 2) - helper:getTextLenCenter(go_back_rect.text), go_back_rect.y + go_back_rect.text_offset_y);
		
		if levels.current_level + 1 <= #levels then
			love.graphics.setColor(white);
			love.graphics.rectangle('fill', nxt_level_rect.x, nxt_level_rect.y, nxt_level_rect.width, nxt_level_rect.height, nxt_level_rect.rx, nxt_level_rect.ry);
			love.graphics.setColor(black);
			love.graphics.rectangle('line', nxt_level_rect.x, nxt_level_rect.y, nxt_level_rect.width, nxt_level_rect.height, nxt_level_rect.rx, nxt_level_rect.ry);
			love.graphics.setFont(state.midFont);  --- need a new font here
			love.graphics.print(nxt_level_rect.text, nxt_level_rect.x + (nxt_level_rect.width / 2) - helper:getTextLenCenter(nxt_level_rect.text), nxt_level_rect.y + nxt_level_rect.text_offset_y);
		end
	end
	
	if paused then
		love.graphics.setColor(half_white);
		love.graphics.rectangle('fill', 0, 0, conf.window_width, conf.window_height);
		love.graphics.setColor(bg_blue);
		love.graphics.rectangle('fill', 200, 200, conf.window_width / 2, conf.window_height / 2);
		love.graphics.setColor(white);
		love.graphics.setFont(standard_font);
		love.graphics.printf('ERROR', 240, 250, 300, 'center')
		love.graphics.setFont(state.normalFontBig);
		love.graphics.printf( error_text[current_error].text, 230, 300, 350, 'center')
		
		love.graphics.setColor(white);
		love.graphics.rectangle('fill', go_back_rect.x + go_back_rect_offset, go_back_rect.y, go_back_rect.width, go_back_rect.height, go_back_rect.rx, go_back_rect.ry);
		love.graphics.setColor(black);
		love.graphics.rectangle('line', go_back_rect.x + go_back_rect_offset, go_back_rect.y, go_back_rect.width, go_back_rect.height, go_back_rect.rx, go_back_rect.ry);
		love.graphics.setFont(state.midFont); 
		love.graphics.print(go_back_rect.text, go_back_rect.x + go_back_rect_offset + (go_back_rect.width / 2) - helper:getTextLenCenter(go_back_rect.text), go_back_rect.y + go_back_rect.text_offset_y);
	end
end

function state:keypressed(key, scancode, isrepeat)
	if (digit_selected > 0 and #key == 1) then
		if (string.byte(key) >= a_lower_ascii_code and string.byte(key) <= z_lower_ascii_code) or 
			(string.byte(key) >= a_upper_ascii_code and string.byte(key) <= z_upper_ascii_code) then
			
			if not key_lookup[key] then
				if player_key[digit_selected] ~= nil then
					if player_key[digit_selected].changeable then
						-- remove lookup key from table before player_key
						if key_lookup[player_key[digit_selected].key] ~= nil then
							key_lookup[player_key[digit_selected].key] = nil;
						end
				
						player_key[digit_selected] = nil;
						-- set new info
						player_key[digit_selected] = { key = key, changeable = true};
						key_lookup[key] = true;
					end
				else
					player_key[digit_selected] = { key = key, changeable = true};
					key_lookup[key] = true;
				end
			end
		end
	end
	
	if key == 'delete' or key == 'backspace' then
		if player_key[digit_selected] ~= nil then
			if player_key[digit_selected].changeable then
				-- remove lookup key from table before player_key
				if key_lookup[player_key[digit_selected].key] ~= nil then
					key_lookup[player_key[digit_selected].key] = nil;
				end
				
				player_key[digit_selected] = nil;
			end
		end
	end
end

function state:keyreleased(key, scancode)

end

function state:mousepressed(x, y, button)
	mouse.x = x;
	mouse.y = y;
	
	if not paused then
		if not  level_status.completed  then
			check_user_input (x, y);
			
			-- Check for user press on button completion
			if mouse.x >= complete_rect.x and mouse.x <= complete_rect.x + complete_rect.width and mouse.y >= complete_rect.y and mouse.y <= complete_rect.y + complete_rect.height then
				complete_level ();
			elseif mouse.x >= hints_rect.x and mouse.x <= hints_rect.x + hints_rect.width and mouse.y >= hints_rect.y and mouse.y <= hints_rect.y + hints_rect.height then
				apply_hint();
			end
			
			for  z = 1, #error_text do
				if error_text[z].show then
					current_error = z;
					paused = true;
				end
			end
		else
			-- Check for user press on button completion
			if mouse.x >= go_back_rect.x and mouse.x <= go_back_rect.x + go_back_rect.width and mouse.y >= go_back_rect.y and mouse.y <= go_back_rect.y + go_back_rect.height then
				lovelyMoon.switchState("game", "menu");
			elseif mouse.x >= nxt_level_rect.x and mouse.x <= nxt_level_rect.x + nxt_level_rect.width and mouse.y >= nxt_level_rect.y and mouse.y <= nxt_level_rect.y + nxt_level_rect.height then
				if levels[levels.current_level + 1]._id ~= nil then
					levels.current_level = levels.current_level + 1;
					lovelyMoon.disableState("game");
					lovelyMoon.enableState(levels[levels.current_level]._id);
					lovelyMoon.enableState("game");
				end
			end
		end
	else
		
		-- Check for user press on button completion
		if mouse.x >= go_back_rect.x + go_back_rect_offset and mouse.x <= go_back_rect.x + go_back_rect_offset + go_back_rect.width and mouse.y >= go_back_rect.y and mouse.y <= go_back_rect.y + go_back_rect.height then
			error_text[current_error].show = false;
			paused = not paused;
		end
		
	end
end

function check_user_input ( mouse_x, mouse_y )
local selected_digit = nil;
local max_rows = alpha_count / half_alpha_count;
local max_columns = half_alpha_count;

	for k = 1, max_rows do
		for l = 1, max_columns do
			
			if k == 1 then
				start_digit = 0;
			else
				start_digit = max_columns;
			end 
			
			selected_digit = start_digit + l;
			
			if mouse_x >= (l * tile.width) + x_offset and mouse_x <= ( (l+1) * tile.width) + x_offset and
				mouse_y >= (k * tile.height) + y_offset + ((#level + 1) * tile.height) and mouse_y <= (k * tile.height) + y_offset + ((#level + 2) * tile.height)  then
					digit_selected = selected_digit;
			end
		end
	end
end

function complete_level ( p_err_count )
	local l_count = 0;
	local l_correct_count = 0;
	level_status.errors_remaining = 0
	complete_rect.clicked = true;
	
	for z = 1, #alpha do
		l_count = l_count + 1;
		
		if player_key[z] == nil then
			level_status.errors_remaining = level_status.errors_remaining + 1;
		else
			if player_key[z].key == key[z] then
				l_correct_count = l_correct_count + 1;
			else
				level_status.errors_remaining = level_status.errors_remaining + 1;
			end
		end
	end
	
	level_status.total_number_of_errors = level_status.total_number_of_errors + level_status.errors_remaining;
	
	if level_status.errors_remaining == 0 then
		if l_correct_count == #alpha then
			level_status.completed = true;
		end
	else
		level_status.completed = false;
		error_text[1].show = true;
	end	
end

function apply_hint ( )
	if hints.current_hint < hints.max_num_of_hints then
		hints.current_hint = hints.current_hint + 1;
		player_key[hints[hints.current_hint].key] = { key = hints[hints.current_hint].value, changeable = false};
	else
		error_text[2].show = true;
	end
end

return state