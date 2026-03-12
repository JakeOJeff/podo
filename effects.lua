local effects = {}


function effects:load()
    self.squares = {}

    self.square_width = displayBox.w/20
    self.square_rows = 20
    self.square_height = displayBox.h/20
    self.square_columns = 20

    self.duration = 2

end

local function get_keys(tbl)
    local keys, len = {}, 0

    for k in pairs(tbl) do
        len = len + 1
        keys[len] = k
    end

    return keys
end

function effects:update(dt)
    
end

function effects:draw()
    
end

return effects