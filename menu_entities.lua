local state = {}

local entities = {};
local text_offset = 2;
local small_letter_offset = {x = 0, y = 0};
local text_digit_offset = {x = 11, y = 10};

function state:new()
	return lovelyMoon.new(self)
end

function state:load()
	state.normalFont = love.graphics.newFont(10);
	state.midFont = love.graphics.newFont(14);
	state.normalFontBig = love.graphics.newFont(24);
end

function state:close()
	
end

function state:enable()
	math.randomseed(os.time());
	
	-- Clean up
	for i = 1, #entities do
		entities[i] = nil;
	end 
	
	entities = {}
	
	for i = 1, 20 do
		generate_entities();
	end
end

function state:disable()
	-- Clean up
	for i = 1, #entities do
		entities[i] = nil;
	end 
	
	entities = {}
end

function state:update(dt)
	for i = 1, #entities do
		entities[i].x = entities[i].x + entities[i].speedX;
		entities[i].y = entities[i].y + entities[i].speedY;
		
		if entities[i].speedX > 0 then
			if entities[i].x >= entities[i].goal_x then
				generate_entities(i);
			end
		elseif entities[i].speedX < 0 then
			if entities[i].x <= entities[i].goal_x then
				generate_entities(i);
			end
		end
		
		if entities[i].speedY < 0 then
			if entities[i].y < -100 then
				generate_entities(i);
			end
		elseif entities[i].speedY > 0 then
			if entities[i].y > conf.window_height + 200 then
				generate_entities(i);
			end
		end
	end 
end

function state:draw()
	love.graphics.setLineStyle('rough');
	
	for i = 1, #entities do
		love.graphics.setColor(white);
		love.graphics.rectangle('fill', entities[i].x, entities[i].y, entities[i].width-1, entities[i].height-1);
		love.graphics.setColor(black);
		love.graphics.rectangle('line', entities[i].x, entities[i].y, entities[i].width, entities[i].height);
		
		if entities[i].letter == 'I' or entities[i].letter == 'J' then
			small_letter_offset.x = 5;
			small_letter_offset.y = 2;
		else
			small_letter_offset.x = 0;
			small_letter_offset.y = 0;
		end
		
		love.graphics.setFont(state.normalFontBig);
		love.graphics.print(string.upper(entities[i].letter), entities[i].x + text_digit_offset.x + small_letter_offset.x, entities[i].y + text_digit_offset.y - small_letter_offset.y);
		love.graphics.setFont(state.normalFont);
		love.graphics.print(tostring(entities[i].key), entities[i].x + text_offset, entities[i].y + text_offset);
	end
end

function state:keypressed(key, unicode)
	
end

function state:keyreleased(key, unicode)
	
end

function generate_entities(index)
	index = index or (#entities+1)
	local i = math.random(1, 2);
	
	if i == 1 then
		entities[index] = {x = math.random(-200, -50), y = math.random(80, conf.window_height - 60), width = 40, height = 40, key = math.random(1, 26), letter = alpha[math.random(1, 26)], speedY = math.random(-2, 2), goal_x = conf.game_width + 100, speedX = math.random(1, 2)};
	else
		entities[index] = {x = math.random(conf.window_width, conf.window_width + 200), y = math.random(80, conf.window_height - 60), width = 40, height = 40, key = math.random(1, 26), letter = alpha[math.random(1, 26)], speedY = math.random(-2, 2), goal_x = -100, speedX = math.random(-1, -2)};
	end
end

return state