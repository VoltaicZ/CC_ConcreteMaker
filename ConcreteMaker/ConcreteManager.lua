--//Modules
local ButtonManager = require("ButtonManager")

--//Vars
local Monitor = peripheral.find("monitor")

Monitor.CreateButton({0,0}, {5,5}, true, "blue")