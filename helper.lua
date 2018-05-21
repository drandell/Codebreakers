helper = {}

function helper:getTextLen(p_text) 
	return love.graphics.getFont():getWidth(p_text);
end

function helper:getTextLenCenter(p_text) 
	return love.graphics.getFont():getWidth(p_text) / 2;
end