Button = {} Button.__index = Button ActiveButtons = {} local tween = require 'libs.tween'

function Button.new(func, x, y, dataType, data, font, padding, radius, strokeSize, color, stroke, colorHover, strokeHover, duration, scaleHover)
    local self = setmetatable({}, Button)
    self.func = func or function () end
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
    
    -- Tween and scale properties
    self.duration = duration or 0.2
    self.scaleHover = scaleHover or 1.1
    self.scale = 1
    self.scaleTween = nil
    
    table.insert(ActiveButtons, self)
    return self
end

function Button:update(dt)
    local mx, my = love.mouse.getPosition()
    local wasHovered = self.hovered
    
    if mx > self.x and mx < self.x + self.w and my > self.y and my < self.y + self.h then
        self.hovered = true
    else
        self.hovered = false
    end
    
    if self.hovered and not wasHovered then
        self.scaleTween = tween.new(self.duration, self, {scale = self.scaleHover}, tween.easing.outQuad)
    elseif not self.hovered and wasHovered then
        self.scaleTween = tween.new(self.duration, self, {scale = 1}, tween.easing.inQuad)
    end
    
    -- Update tween
    if self.scaleTween then
        local isDone = self.scaleTween:update(dt)
        if isDone then
            self.scaleTween = nil
        end
    end
end

function Button:draw()
    local bg = self.hovered and self.colorHover or self.color
    local fg = self.hovered and self.strokeHover or self.stroke
    LG.setFont(self.font)
    LG.setColor(bg)
    
    -- Calculate center for scaling
    local centerX = self.x + self.w / 2
    local centerY = self.y + self.h / 2
    
    -- Draw with scale transform
    LG.push()
    LG.translate(centerX, centerY)
    LG.scale(self.scale, self.scale)
    LG.translate(-self.w / 2, -self.h / 2)
    
    LG.rectangle("fill", 0, 0, self.w, self.h, self.radius, self.radius)
    LG.setColor(fg)
    LG.setLineWidth(self.strokeSize)
    LG.rectangle("line", 0, 0, self.w, self.h, self.radius, self.radius)
    
    if self.dataType == "Text" then
        local tx = (self.w / 2) - (self.font:getWidth(self.data) / 2)
        local ty = (self.h / 2) - (self.font:getHeight() / 2)
        LG.print(self.data, tx, ty)
    else
        local cx = (self.w / 2) - self.data:getWidth()/2
        local cy = (self.h / 2) - self.data:getHeight()/2
        LG.draw(self.data, cx, cy)
    end
    
    LG.pop()
    LG.setColor(1,1,1)
end

function Button:mousepressed(button)
    if self.hovered and button == 1 then
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

function MousePressedButtons(x, y, button)
    for _, v in ipairs(ActiveButtons) do
        v:mousepressed(button)
    end
end

return Button