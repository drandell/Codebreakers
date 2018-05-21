local state = {}

local logo;
local alpha = 0;
local dev_text = 'WIZARDRY GAMES';
local show = {start_time = 0, current_time = 0, max_show_time = 1, timer_started = false, shown  = false};

function state:new()
	return lovelyMoon.new(self)
end

function state:load()
	logo = love.graphics.newImage('content/logo400x400.png');
end

function state:close()
	
end

function state:enable()
	
end

function state:disable()
	
end

function state:update(dt)
	local result; 
	
	if not show.shown then
		alpha = alpha + (dt * 0.5);
		
		if alpha >= 1 then
			alpha = 1;
			
			if not show.time_started then
				show.start_time = love.timer.getTime();
				show.time_started = not show.time_started;
			end
			
			show.current_time = love.timer.getTime() - show.start_time;

			if show.current_time > show.max_show_time then
				show.shown = not show.shown;
			end
		end
	else
		alpha = alpha - (dt * 0.75);
		
		if alpha <= 0 then
			lovelyMoon.switchState("logo_splash", "menu"); 
		end
	end
end

function state:draw()
	love.graphics.clear(bg_blue);
	
	love.graphics.setColor(white[1], white[2], white[3], alpha);
	love.graphics.draw (logo, (conf.game_width - logo:getWidth()) / 2, (conf.game_width - logo:getHeight()) / 2);
end

function state:keypressed(key, unicode)
	
end

function state:keyreleased(key, unicode)
	
end

return state