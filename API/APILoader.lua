local API_VERSION = 1.4 -- DO NOT FORGET TO UPDATE THIS OTHERWISE ALL FOR NOT

-- Intialize BloxFruits Folder if missing..
if not isfolder("BloxFruits") then makefolder("BloxFruits") end

local git = function(path)
    -- Enter BloxFruits Folder
    local realpath = "BloxFruits/" .. path

    -- Create API Folder if missing..
    if not isfolder("BloxFruits/API") then makefolder("BloxFruits/API") end

    -- Check if API is up-to-date.
    local Change = false
    if not isfile("BloxFruits/API/version.txt") then
        writefile("BloxFruits/API/version.txt", tostring(API_VERSION))
    elseif readfile("BloxFruits/API/version.txt") ~= tostring(API_VERSION) then
        writefile("BloxFruits/API/version.txt", tostring(API_VERSION))
        Change = true
    end

    -- Write API to file if missing or if change is needed.
    local result = nil;
    if not isfile(realpath) or Change then
        local url = string.format("https://github.com/%s/BloxFruits/raw/refs/heads/%s/%s", getgenv().gitowner, getgenv().TimeSkipBranch, path)
        result = game:HttpGet(url)
        writefile(realpath, result)
    end

    -- Return API
    if Change then
        return loadstring(result)()
    end
    return loadstring(readfile(realpath))()
end

getgenv().OptionsAPI = git("API/OptionsAPI.lua")
getgenv().ServicesAPI = git("API/ServicesAPI.lua")
getgenv().DynamicAPI = git("API/DynamicAPI.lua")
getgenv().TeleportAPI = git("API/TeleportAPI.lua")
getgenv().RemoteAPI = git("API/RemoteAPI.lua")
print("API's Loaded")