local effects = {}

local tween = require "libs.tween"


function effects:load()
    self.squares = {}

    self.square_width = displayBox.w/20
    self.square_rows = 20
    self.square_height = displayBox.h/20
    self.square_columns = 20


    for i = 1, self.square_rows do

        self.squares[i] = {}
        for j = 1, self.square_columns do
            local a = {
                x = 0,
                y = 0,
                sX = love.math.random(0, wW),
                sY = love.math.random(0, wH),
                tX = displayBox.x + (i - 1) * self.square_width,
                tY = displayBox.y +(j - 1) * self.square_height,
                duration = (i * j)/(self.square_rows * self.square_columns) * 3,
            }
            a.x = a.sX
            a.y = a.sY
            a.tween = tween.new(a.duration, a, {x = a.tX, y = a.tY})
            
            self.squares[i][j] = a
        end
    end

end

function effects:update(dt)
    for i = 1, self.square_rows do
        for j = 1, self.square_columns do
            self.squares[i][j].tween:update(dt)
        end
    end
end

function effects:draw()
    LG.setColor(0.9, 0.9, 0.9, 0.5)
    for i = 1, self.square_rows do
        for j = 1, self.square_columns do
            local sq = self.squares[i][j]
            LG.rectangle("fill", math.floor(sq.x), math.floor(sq.y), self.square_width, self.square_height, 40, 40)
        end
    end
end

return effects