local effects = {}

local tween = require "libs.tween"

local function get_keys(tbl)
    local keys, len = {}, 0

    for k in pairs(tbl) do
        len = len + 1
        keys[len] = k
    end

    return keys
end

local easing_keys = get_keys(tween.easing)

local function pad(x, min, max)
    return math.max(math.min(x, max), min)
end

local function getSquareTarget(column, row)
    local x = wW/2 - effects.square_width * effects.square_columns + effects.square_width * column * 2
    local y = wH/2 - effects.square_height * effects.square_rows + effects.square_height * row * 2

    return {x=x, y=y, radius = effects.square_width}

end

function effects:load()
    self.squares = {}

    self.square_width = displayBox.w/20
    self.square_rows = 20
    self.square_height = displayBox.h/20
    self.square_columns = 20

    self.duration = 2


    for i = 1, self.square_columns do
        for j = 1, self.square_rows do
            table.insert(self.squares, {
                x = love.math.random(0, wW),
                y = love.math.random(0, wH),
                tX = (i - 1) * self.square_rows,
                tY = (j - 1) * self.square_columns
            })
        end
    end

end

function effects:update(dt)
    
end

function effects:draw()
    
end

return effects