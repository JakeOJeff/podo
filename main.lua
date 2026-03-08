

-- Declaring Global variables
TIMER = 0
STATUS = "PAUSED"
MODE = "POMO" -- [ POMO, SBR, LBR ]
TIMERS  = {
    ["POMO"] = 25 * 60,
    ["SBR"] = 5 * 60,
    ["LBR"] = 10 * 60
}



function love.update()
    
    if STATUS ~= "PAUSED" and TIMER > 0 then
        TIMER = math.max(0, TIMER - 1 * dt)
    end

end