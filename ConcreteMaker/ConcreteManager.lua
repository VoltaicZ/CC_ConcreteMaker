--//Modules
local ButtonManager = require("ButtonManager")

--//Vars

ButtonManager.Init("back")
ButtonManager.CreateButton({1,1}, {6,6}, true, "blue", "Hello World", 
function() 
    print("Button Pressed") 
end)

parallel.waitForAny(
    ButtonManager.ListenForPress
)