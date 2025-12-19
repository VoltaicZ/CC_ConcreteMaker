--//Modules
local ButtonManager = require("ButtonManager")

--//Vars
local Monitor = peripheral.wrap("back")
local Width, Height = Monitor.getSize()


ButtonManager.Init("back")
ButtonManager.CreateButton({1,1}, {6,1}, true, "blue", "Hello World", 
function() 
    print("Button Pressed") 
end)

parallel.waitForAny(
    ButtonManager.ListenForPress
)