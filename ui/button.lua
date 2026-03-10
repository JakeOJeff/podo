Button = {}
Button.__index = Button
ActiveButtons = {}

function Button.new(func, x, y, dataType, data, font, padding, radius, strokeSize, color, stroke, colorHover, strokeHover, duration)
    local self = setmetatable({}, Button)

    self.func = func or function ()
        
    end

    self.x = x or 10
    self.y = y or 10

    self.dataType = dataType or "Text"

    if dataType == "Image" then
        self.data = LG.newImage("assets/"..data)
    elseif dataType == "Text" then
        self.data = data or "Button"
    end
    

    self.font = font or fonts.h

    self.padding = padding or 10
    self.radius = radius or 5
    
    self.strokeSize = strokeSize or 2

    self.w = (self.dataType == "Text" and self.font:getWidth(self.data) or (self.dataType == "Image" and self.data:getWidth())) + self.padding + self.strokeSize
    self.h = (self.dataType == "Text" and self.font:getHeight()) or (self.dataType == "Image" and self.data:getHeight() )+ self.padding
    
    self.color = color or {1, 1, 1}
    self.stroke = stroke or {0, 0, 0}
    self.colorHover = colorHover or {0.7, 0.7, 0.7}
    self.strokeHover = strokeHover or {0.3, 0.3, 0.3}

    self.hovered = false

    table.insert(ActiveButtons, self)
    return self
end

function Button:update(dt)
    local mx, my = love.mouse.getPosition()

    if mx > self.x and mx < self.x + self.w and my > self.y and my < self.y + self.h then
        self.hovered = true
    else
        self.hovered = false
    end
end

function Button:draw()
    local bg = self.hovered and self.colorHover or self.color
    local fg = self.hovered and self.strokeHover or self.stroke

    LG.setFont(self.font)

    LG.setColor(bg)
    LG.rectangle("fill", self.x, self.y, self.w, self.h, self.radius, self.radius)

    LG.setColor(fg)
    LG.setLineWidth(self.strokeSize)
    LG.rectangle("line", self.x, self.y, self.w, self.h, self.radius, self.radius)

    if self.dataType == "Text" then
        local tx = self.x + (self.w / 2) - (self.font:getWidth(self.data) / 2)
        local ty = self.y + (self.h / 2) - (self.font:getHeight() / 2)
        LG.print(self.data, tx, ty)
    else
        local cx = self.x + (self.w / 2) - self.data:getWidth()/2
        local cy = self.x + (self.h / 2) - self.data:getHeight()/2
        LG.draw(self.data, cx, cy)
    end
    
    LG.setColor(1,1,1)
end

function Button:mousepressed()
    if self.hovered then
        self.func()        
    end
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
