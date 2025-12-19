-- install.lua for CC_ConcreteMaker

local BASE_URL = "https://raw.githubusercontent.com/VoltaicZ/CC_ConcreteMaker/"

-- List of files to download
local FILES = {
    "ConcreteManager.lua",
    "ButtonManager.lua"
}

-- Create necessary directories
if not fs.exists("CC_ConcreteMaker") then fs.makeDir("CC_ConcreteMaker") end

for _, file in ipairs(FILES) do
    -- Remove old file
    if fs.exists("CC_ConcreteMaker/" .. file) then
        fs.delete("CC_ConcreteMaker/" .. file)
    end

    -- Make sure parent folders exist
    local pathParts = {}
    for part in string.gmatch(file, "[^/]+") do table.insert(pathParts, part) end
    if #pathParts > 1 then
        local path = "CC_ConcreteMaker"
        for i = 1, #pathParts-1 do
            path = path .. "/" .. pathParts[i]
            if not fs.exists(path) then fs.makeDir(path) end
        end
    end

    print("Downloading " .. file .. " ...")
    shell.run("wget", BASE_URL .. file, "CC_ConcreteMaker/" .. file)
end

-- Create launcher in root for one-command run
local launcher = [[
-- Launcher for CC_ConcreteMaker
shell.run("CC_ConcreteMaker/concretemanager.lua")
]]
if fs.exists("concretemanager") then fs.delete("concretemanager") end
local f = fs.open("concretemanager", "w")
f.write(launcher)
f.close()

print("Installation complete!")
print("Run your program from anywhere with:")
print("concretemanager")
