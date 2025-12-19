--//Modules
local ButtonManager = require("ButtonManager")

--//Vars
local Monitor = peripheral.wrap("back")
local Width, Height = Monitor.getSize()
local ButtonWidth = 6
local ButtonHeight = 2

local ActualDimenstions = {
    Width-ButtonWidth+1,
    Height-ButtonHeight+1
}

ButtonManager.Init("back")
ButtonManager.CreateButton({1,1}, ActualDimenstions, true, "blue", "Hello World", 
function() 
    print("Button Pressed") 
end)

parallel.waitForAny(
    ButtonManager.ListenForPress
)