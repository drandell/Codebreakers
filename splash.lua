local state = {}

local splashes = {
  ["o-ten-one: lighten"]   = {module="content/o-ten-one", {fill="lighten"}}
}

local current, splash;

local function next_splash()
  current = next(splashes, current) or next(splashes)
  splash = splashes[current]()
  splash.onDone = function () lovelyMoon.switchState("splash", "logo_splash"); end
end

function state:new()
	return lovelyMoon.new(self)
end

function state:load()
	for name, entry in pairs(splashes) do
		entry.module = require(entry.module)
		splashes[name] = function ()
		return entry.module(unpack(entry))
    end
  end

  next_splash()
end

function state:close()
	
end

function state:enable()
	
end

function state:disable()
	
end

function state:update(dt)
	splash:update(dt);
end

function state:draw()
	splash:draw();
end

function state:keypressed(key, scancode, isrepeat)
	
end

function state:keyreleased(key, scancode)
end

return state