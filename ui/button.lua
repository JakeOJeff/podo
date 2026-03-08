Button = {}
Button.__index = Button
ActiveButtons = {}

function Button.new(x, y, data, font, padding, radius, strokeSize, color, stroke, colorHover, strokeHover, duration)
    local self = setmetatable({}, Button)


    self.x = x or 10
    self.y = y or 10

    self.font = LG.getFont()

    self.padding = padding or 10
    self.radius = radius or 5
    
    self.strokeSize = strokeSize or 2

    self.w = self.font:getWidth()
    
    self.color = color or {1, 1, 1}
    self.stroke = stroke or nil
    self.colorHover = colorHover or {0.7, 0.7, 0.7}
    self.strokeHover = strokeHover or nil


    table.insert(ActiveButtons, self)
    return self
end

function Button.update(dt)
    
end

function Button.draw()
    LG.setFont(self.font)
    LG.rectangle()
end

return Button
