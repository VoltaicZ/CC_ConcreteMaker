-- install.lua for CC_ConcreteMaker
-- Usage: wget run <raw-url-to-install.lua>

local BASE_URL = "https://raw.githubusercontent.com/VoltaicZ/CC_ConcreteMaker/"
local CACHE_BUST = "?ts=" .. os.time()  -- force fresh download

-- List of files to download (update this if you add more)
local FILES = {
    "ConcreteManager.lua",
    "ButtonManager.lua"
}

-- Create necessary directories
if not fs.exists("CC_ConcreteMaker") then
    fs.makeDir("CC_ConcreteMaker")
end

-- Download each file
for _, file in ipairs(FILES) do
    -- remove old version if exists
    if fs.exists("CC_ConcreteMaker/" .. file) then
        fs.delete("CC_ConcreteMaker/" .. file)
    end

    -- Ensure parent folder exists for subfiles
    local parts = {}
    for part in string.gmatch(file, "[^/]+") do
        table.insert(parts, part)
    end
    if #parts > 1 then
        local path = "CC_ConcreteMaker"
        for i = 1, #parts - 1 do
            path = path .. "/" .. parts[i]
            if not fs.exists(path) then
                fs.makeDir(path)
            end
        end
    end

    print("Downloading " .. file .. " ...")
    local success = shell.run("wget ".. BASE_URL .. file .. CACHE_BUST, "CC_ConcreteMaker/" .. file)
    if not success then
        print("Failed to download: " .. file)
    end
end
