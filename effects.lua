local effects = {}

local tween = require "libs.tween"


function effects:load()
    self.squares = {}

    self.square_width = displayBox.w/20
    self.square_rows = 20
    self.square_height = displayBox.h/20
    self.square_columns = 20


    for i = 1, self.square_rows do
        for j = 1, self.square_columns do
            local a = {
                x = 0,
                y = 0,
                sX = love.math.random(0, wW),
                sY = love.math.random(0, wH),
                tX = (i - 1) * self.square_rows,
                tY = (j - 1) * self.square_columns,
                duration = (i * j)/(self.square_rows * self.square_columns),
            }
            a.x = a.sX
            a.y = a.sY
            a.tween = tween.new(a.duration, a, {x = a.tX, y = a.tY})
            
            table.insert(self.squares, a)
        end
    end

end

function effects:update(dt)
    
end

function effects:draw()
    
end

return effects