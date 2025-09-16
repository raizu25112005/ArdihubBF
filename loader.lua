--[[
    Ardi Hub Loader
    Version: 1.0.0
    Game: Blox Fruits
    Discord: [Your Discord Link]
]]

local CurrentVersion = "1.0.0"

-- Notification Function
local function Notify(title, text, duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 5
    })
end

-- Check if game is supported
if game.PlaceId ~= 2753915549 and game.PlaceId ~= 4442272183 and game.PlaceId ~= 7449423635 then
    Notify("Ardi Hub", "Game not supported!", 5)
    return
end

-- Loading UI
Notify("Ardi Hub", "Loading script...", 3)

-- Anti-Ban Setup
local function setupProtection()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" then
            return wait(9e9)
        end
        return old(self, unpack(args))
    end)
    setreadonly(mt, true)
end

-- Check for updates
local function checkUpdate()
    local success, latestVersion = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/raizu25112005/ArdihubBF/main/version.txt")
    end)
    
    if success and latestVersion ~= CurrentVersion then
        Notify("Ardi Hub", "Update available! Loading latest version...", 3)
    end
end

-- Main Script Loader
local function loadScript()
    local success, error = pcall(function()
        setupProtection()
        checkUpdate()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/raizu25112005/ArdihubBF/main/script.lua'))()
    end)

    if not success then
        Notify("Ardi Hub", "Error loading script: " .. tostring(error), 5)
    end
end

-- Execute
loadScript()