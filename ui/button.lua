Button = {}
Button.__index = Button
ActiveButtons = {}

function Button.new(x, y)
    local self = setmetatable({}, Button)



    table.insert(ActiveButtons, self)
    return self
end

return Button
