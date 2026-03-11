function love.load()
    LG     = love.graphics

    -- Declaring Global variables
    TIMER  = 0
    STATUS = "PAUSED"
    MODE   = "POMO" -- [ POMO, SBR, LBR ]
    TIMERS = {
        ["POMO"] = 25 * 60,
        ["SBR"] = 5 * 60,
        ["LBR"] = 10 * 60
    }

    wW, wH = love.graphics.getDimensions()

    fonts  = {
        xH = love.graphics.newFont("fonts/StardosStencil-Bold.ttf", 55),
        h = love.graphics.newFont("fonts/StardosStencil-Bold.ttf", 40),
        m = love.graphics.newFont("fonts/StardosStencil-Bold.ttf", 25),
        s = love.graphics.newFont("fonts/StardosStencil-Bold.ttf", 10),

    }

    Button = require "ui.button"
    TIMER  = TIMERS[MODE]

    Butt   = Button.new(SwitchStatus, 200, 300, "Image", "play.png", fonts.m, 20, 200)
    Butt.x = wW / 2 - Butt.w / 2
    Butt.y = wH / 1.3 - Butt.h / 2
end

function love.update(dt)
    if STATUS ~= "PAUSED" and TIMER > 0 then
        TIMER = math.max(0, TIMER - 1 * dt)
    end

    UpdateButtons(dt)
end

function love.keypressed(key)
    if key == "space" then
        SwitchStatus()
    end
end

function love.mousepressed(x, y, button)
    MousePressedButtons(x, y, button)
end

function love.draw()
    local displayBox = {

    }
    -- LG.rectangle("fill", )

    LG.setFont(fonts.xH)
    local time = string.format("%02d:%02d", math.floor(TIMER / 60), math.floor(TIMER % 60))
    LG.print(time, wW / 2 - fonts.xH:getWidth(time) / 2, 200)

    DrawButtons()
end

function SwitchStatus()
    if STATUS == "PAUSED" then
        STATUS = "STARTED"
        Butt.data = LG.newImage("assets/pause.png")
    elseif STATUS == "STARTED" then
        STATUS = "PAUSED"
        Butt.data = LG.newImage("assets/play.png")
    end
end

function love.resize(w, h)
    wW = w
    wH = h
    ActiveButtons = {}
    love.load()
end
