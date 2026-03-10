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

fonts = {
    h = love.graphics.newFont("StardosStencil-Bold.ttf", 45)
}

Button = require "ui.button"


function love.load()
    TIMER = TIMERS[MODE]
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

function love.draw()
    LG.print(string.format("%02d:%02d", math.floor(TIMER / 60), math.floor(TIMER % 60)))

    DrawButtons()
end

function SwitchStatus()
    if STATUS == "PAUSED" then
        STATUS = "STARTED"
    else
        STATUS = "PAUSED"
    end
end
