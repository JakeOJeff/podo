local effects = {}

function effects:load()
    self.squares = {}

    self.square_width = displayBox.w / 20
    self.square_rows = 20
    self.square_height = displayBox.h / 20
    self.square_columns = 20

    self.initial_timer = TIMER

    for i = 1, self.square_rows do
        self.squares[i] = {}
        for j = 1, self.square_columns do
            local a = {
                x = 0,
                y = 0,
                sX = love.math.random(displayBox.x, displayBox.x + displayBox.w - self.square_width),
                sY = love.math.random(displayBox.y, displayBox.y + displayBox.h - self.square_height),
                tX = displayBox.x + (i - 1) * self.square_width,
                tY = displayBox.y + (j - 1) * self.square_height,
            }
            a.x = a.sX
            a.y = a.sY

            self.squares[i][j] = a
        end
    end
end

function effects:update(dt)
end

function effects:draw()
    LG.setColor(1,1,1,0.2)

    for i = 1, self.square_rows do
        for j = 1, self.square_columns do
            local sq = self.squares[i][j]

            local progress = 1.0 - (TIMER / self.initial_timer)
            progress = math.max(0, math.min(1, progress))

            local delay = (i * j) / (self.square_rows * self.square_columns)

            local adjusted_progress = math.max(0, progress - (1 - delay)) / delay
            adjusted_progress = math.max(0, math.min(1, adjusted_progress))

            sq.x = sq.sX + (sq.tX - sq.sX) * adjusted_progress
            sq.y = sq.sY + (sq.tY - sq.sY) * adjusted_progress

            LG.rectangle("fill", math.floor(sq.x), math.floor(sq.y), self.square_width, self.square_height, 40, 40)
        end
    end
end

return effects
