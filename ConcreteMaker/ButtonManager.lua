
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
            
            for _, ButtonObject in pairs(CurrentButtons) do
                local ButtonPositionX = ButtonObject.Position[1]
                local ButtonPositionY = ButtonObject.Position[2]
                local ButtonSizeX = ButtonObject.Size[1]
                local ButtonSizeY = ButtonObject.Size[2]

                if XPos > ButtonPositionX and XPos < ButtonPositionX+ButtonSizeX then -- within x bounds
                    if YPos > ButtonPositionY and YPos < ButtonPositionY+ButtonSizeY then -- within y bounds
                        --// Button was pressed
                        ButtonObject.Callback()
                        NewButtonObject.WindowInstance.setBackgroundColor(colors.white)
                        os.sleep(0.1)
                        NewButtonObject.WindowInstance.setBackgroundColor(colors[NewButtonObject.Color])
                    end
                end
            end
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
function ButtonManager.CreateButton(Position, Size, IsVisible, Color, Text, Callback)
    local Monitor = peripheral.wrap(MonitorSide)
    if not Monitor then
        print("Monitor not found on: "..MonitorSide)
    end

    local NewButtonObject = setmetatable({}, ButtonClass)
    NewButtonObject.WindowInstance = window.create(Monitor, Position[1], Position[2], Size[1], Size[2], IsVisible)
    NewButtonObject.WindowInstance.setTextColor(colors.black)
    NewButtonObject.WindowInstance.setBackgroundColor(colors[Color])
    NewButtonObject.WindowInstance.write(Text)
    NewButtonObject.Size = Size
    NewButtonObject.Position = Position
    NewButtonObject.Callback = Callback
    NewButtonObject.Color = Color

    table.insert(CurrentButtons, NewButtonObject)

    return NewButtonObject
end

return ButtonManager