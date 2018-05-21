require "libs/colors";
require "helper";

lovelyMoon = require "libs/lovelyMoon";

local states = {}
alpha = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
player_key = {}
levels = {};
osString = love.system.getOS();

conf = {
	game_width = 800,
	game_height = 800,
	window_width = 800,
	window_height = 800,
	tile_size = 32,
	tx = 0,
	ty = 0,
	scale_x = 0,
	scale_y = 0,
	debug = false
};

-- Load
function love.load( arg )
	-- ZeroBrane Debug requirement
	if arg[#arg] == "-debug" then require("mobdebug").start(); end
	
	states.splash = lovelyMoon.addState("splash", "splash");
	states.logo_splash = lovelyMoon.addState("logo_splash", "logo_splash");
	states.menu = lovelyMoon.addState("menu", "menu");
	states.level_selection =  lovelyMoon.addState("level_selection", "level_selection");
	states.menu_entities = lovelyMoon.addState("menu_entities", "menu_entities");
	states.game = lovelyMoon.addState("game", "game");
	
	levels = {
		lovelyMoon.addState("levels/1", "level_1"),
		lovelyMoon.addState("levels/2", "level_2"),
		lovelyMoon.addState("levels/3", "level_3"),
		lovelyMoon.addState("levels/4", "level_4"),
		lovelyMoon.addState("levels/5", "level_5")
	};
	levels.current_level = 1;
	
	standard_font = love.graphics.newFont('content/o-ten-one/handy-andy.otf', 30);
	
	major, minor, revision, codename = love.getVersion();
	
	--lovelyMoon.enableState("level_1");
	--lovelyMoon.enableState("game");
	--lovelyMoon.enableState("level_selection");
	lovelyMoon.enableState("splash");
	--lovelyMoon.enableState("menu");
end

-- Update
function love.update(dt)
	lovelyMoon.event.update(dt);
end

-- Draw
function love.draw()
	lovelyMoon.event.draw();
	
	if conf.debug then
		love.graphics.setColor(white);
		love.graphics.setFont(standard_font);
		love.graphics.print("FPS: " .. tostring(love.timer.getFPS( )), 2, conf.window_height - 35);
	end
	
end

-- Key pressed
function love.keypressed( key, scancode, isrepeat )
	if (osString == "Windows" or osString == "Linux" or osString == "OS X") then
		if ( key == "escape" ) then love.event.quit(); end
		
		lovelyMoon.event.keypressed(key, scancode, isrepeat);
		if ( key == "f1" ) then conf.debug = not conf.debug; end
	end
end

-- Key released
function love.keyreleased( key, scancode )
	lovelyMoon.event.keyreleased(key, scancode);
end

-- Mouse Pressed
function love.mousepressed (x, y, button )
	lovelyMoon.event.mousepressed (x, y, button);
end

function love.quit()
	for i = 1, #states do
		lovelyMoon.destroyState(states[i]);
	end
	
	for j = 1, #levels do
		lovelyMoon.destroyState(levels[j]);
	end
end;