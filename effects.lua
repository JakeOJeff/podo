local effects = {}

local tween = require "libs.tween"


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
                x = 0,
                y = 0,
                sX = love.math.random(0, wW),
                sY = love.math.random(0, wH),
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