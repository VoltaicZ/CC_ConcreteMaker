
local ButtonManager = {}
local CurrentButtons = {}

local MonitorSide = ""
local ButtonPressThread 

local ButtonClass = {}
ButtonClass.__index = ButtonClass

local function ListenForPress()
    while true do
        local _, Side, XPos, YPos = os.pullEvent("monitor_touch")
        if Side == MonitorSide then
            
        end
    end
end

function ButtonManager.Init(NewMonitorSide)
    if ButtonPressThread then
        coroutine.close(ButtonPressThread)
    end

    MonitorSide = NewMonitorSide
    ButtonPressThread = coroutine.create(ListenForPress)
    coroutine.resume(ButtonPressThread)
end

--[[
Position will be a table {x,y}
Size will also be a table {x,y}
IsVisible is just a boolean to sya if the button will immediately be visible
Color is a string color from the global color library
]]
function ButtonManager.CreateButton(Position, Size, IsVisible, Color)
    local Monitor = peripheral.wrap(MonitorSide)
    if not Monitor then
        print("Monitor not found on: "..MonitorSide)
    end

    local NewButtonObject = setmetatable({}, ButtonClass)
    NewButtonObject.Window = window.create(Monitor, Position[1], Position[2], Size[1], Size[2], IsVisible)
    NewButtonObject.Window.setTextColor(colors.black)
    NewButtonObject.Window.setBackgroundColor(colors[Color])

    return NewButtonObject
end

return ButtonManager