Button = {}
Button.__index = Button
ActiveButtons = {}

function Button.new(x, y, data, font, padding, radius, strokeSize, color, stroke, colorHover, strokeHover, duration)
    local self = setmetatable({}, Button)


    self.x = x or 10
    self.y = y or 10

    self.data = data or "Button"

    self.font = font or LG.getFont()

    self.padding = padding or 10
    self.radius = radius or 5
    
    self.strokeSize = strokeSize or 2

    self.w = self.font:getWidth(self.data) + self.padding + self.strokeSize
    self.h = self.font:getHeight() + self.padding
    
    self.color = color or {1, 1, 1}
    self.stroke = stroke or nil
    self.colorHover = colorHover or {0.7, 0.7, 0.7}
    self.strokeHover = strokeHover or nil


    table.insert(ActiveButtons, self)
    return self
end

function Button:update(dt)
    
end

function Button:draw()
    LG.setFont(self.font)

    LG.setColor(self.color)
    LG.rectangle("fill",self.x, self.y, self.w, self.h)

    LG.setColor(self.stroke)
    LG.print(self.data, self.x + self.w/2, self.y + self.h/2 )
end


function UpdateButtons(dt)
    for _, v in ipairs(ActiveButtons) do
        v:update(dt)
    end
end

function DrawButtons()
    for _, v in ipairs(ActiveButtons) do
        v:draw()
    end
end

return Button
