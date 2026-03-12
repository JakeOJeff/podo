function love.load()
    LG            = love.graphics

    -- Declaring Global variables
    TIMER         = 0
    STATUS        = "PAUSED"
    MODE          = "POMO" -- [ POMO, SBR, LBR ]
    TIMERS        = {
        ["POMO"] = 25 * 60,
        ["SBR"] = 5 * 60,
        ["LBR"] = 10 * 60
    }

    wW, wH        = love.graphics.getDimensions()

    fonts         = {
        xH = love.graphics.newFont("fonts/StardosStencil-Bold.ttf", 100),
        h = love.graphics.newFont("fonts/StardosStencil-Bold.ttf", 40),
        m = love.graphics.newFont("fonts/StardosStencil-Bold.ttf", 25),
        s = love.graphics.newFont("fonts/StardosStencil-Bold.ttf", 10),

    }

    currentKey    = ""

    Button        = require "ui.button"
    Group         = require "ui.group"
    
    effects       = require "effects"

    TIMER         = TIMERS[MODE]



    countDisplays = {
        {
            completed = false,
            completing = true,
        },
        {
            completed = false,
            completing = false,
        },
        {
            completed = false,
            completing = false,
        },
        {
            completed = false,
            completing = false,
        },
    }

    displayBox    = {
        w = wW / 1.5,
        h = wH / 2
    }
    displayBox.x  = wW / 2 - displayBox.w / 2
    displayBox.y  = 70

    Butt          = Button.new(SwitchStatus, 200, 300, "Image", "play.png", fonts.m, 20, 200)
    Butt.x        = wW / 2 - Butt.w / 2
    Butt.y        = wH / 1.2 - Butt.h / 2

    POMO          = Button.new(function()
        MODE = "POMO"
        updateTimer()
    end, 10, 10, "Text", "POMO", fonts.m)
    SBR           = Button.new(function()
        MODE = "SBR"
        updateTimer()
    end, 10, 10, "Text", "SBR", fonts.m)
    LBR           = Button.new(function()
        MODE = "LBR"
        updateTimer()
    end, 10, 10, "Text", "LBR", fonts.m)

    TimerGroup    = Group.new(10, 20, 10, { POMO, SBR, LBR })
    TimerGroup:setPosition(wW / 2 - TimerGroup.w / 2, 25)

    effects:load()

end

function updateTimer()
    TIMER = TIMERS[MODE]
end

function love.update(dt)
    if STATUS ~= "PAUSED" and TIMER > 0 then
        TIMER = math.max(0, TIMER - 500 * dt)
    end

    effects:update(dt)

    if TIMER <= 0 then
        if MODE == "POMO" then
            MODE = "SBR"
            TIMER = TIMERS[MODE]
        elseif MODE == "SBR" or MODE == "LBR" then
            MODE = "POMO"
            TIMER = TIMERS[MODE]
            LoopComplete()
        end
    end

    for i, v in ipairs(TimerGroup.items) do
        if v.data == MODE then
            v.color = { 0.7, 0.7, 0.7 }
        else
            v.color = { 1, 1, 1 }
        end
    end

    UpdateButtons(dt)
end

function LoopComplete()
    local foundIncomplete = false
    for i, v in ipairs(countDisplays) do
        if v.completing and not v.completed then
            v.completed = true
        end

        if not v.completing and not foundIncomplete then
            v.completing = true
            foundIncomplete = true
        end
    end
end

function love.keypressed(key)
    if key == "space" then
        SwitchStatus()
        currentKey = key
    elseif key == "r" then
        for _, v in ipairs(countDisplays) do
            v.completed = false
            v.completing = false
        end
        countDisplays[1].completing = true
        currentKey = key
    elseif key == "e" then
        if #countDisplays < 10 then
            table.insert(countDisplays, {
                completed = false,
                completing = false
            })
        end
        currentKey = key
    elseif key == "q" then
        if #countDisplays > 2 then
            table.remove(countDisplays, #countDisplays)
        end
        currentKey = key
    elseif key == "w" then
        if TIMERS[MODE] < 999 * 60 then
            TIMERS[MODE] = TIMERS[MODE] + 60
            updateTimer()
        end
        currentKey = key
    elseif key == "s" then
        if TIMERS[MODE] > 60 then
            TIMERS[MODE] = TIMERS[MODE] - 60
            updateTimer()
        end
        currentKey = key
    elseif key == "t" then
        MODE = "POMO"
        TIMER = TIMERS[MODE]
        updateTimer()
        currentKey = key
    elseif key == "y" then
        MODE = "SBR"
        TIMER = TIMERS[MODE]
        updateTimer()
        currentKey = key
    elseif key == "u" then
        MODE = "LBR"
        TIMER = TIMERS[MODE]
        updateTimer()
        currentKey = key
    end
end

function love.mousepressed(x, y, button)
    MousePressedButtons(x, y, button)
end

function love.draw()
    LG.setColor(0.5, 0.5, 0.5)
    LG.rectangle("fill", displayBox.x, displayBox.y, displayBox.w, displayBox.h, 20, 20)

    LG.setColor(1, 1, 1)
    LG.setFont(fonts.h)
    LG.print(currentKey, 15, 10)
    LG.setColor(1, 1, 1)
    LG.setFont(fonts.xH)
    local time = string.format("%02d:%02d", math.floor(TIMER / 60), math.floor(TIMER % 60))
    LG.print(time, wW / 2 - fonts.xH:getWidth(time) / 2, displayBox.y + displayBox.h / 2 - fonts.xH:getHeight() / 2)


    local cDW = 5
    local cDM = 8

    local totalWidth = (#countDisplays * cDW) + ((#countDisplays - 1) * cDM)
    local cDX = wW / 2 - totalWidth / 2

    effects:draw()
    for i, v in ipairs(countDisplays) do
        local x = cDX + (i - 1) * (cDW + cDM)

        local mode = "line"

        if v.completed then
            mode = "fill"
        elseif v.completing and STATUS == "STARTED" then
            if math.floor(love.timer.getTime() * 2) % 2 == 0 then
                mode = "fill"
            else
                mode = "line"
            end
        end
        LG.circle(mode, x, Butt.y - 20, cDW)
    end
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
