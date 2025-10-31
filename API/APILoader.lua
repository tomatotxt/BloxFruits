local API_VERSION = 1.57

getgenv().TimeSkipBranch = getgenv().TimeSkipBranch or "main"
getgenv().gitowner = getgenv().gitowner or "ImMejor35"

local git = function(path)
	print(path)	
    local url = string.format("https://github.com/%s/BloxFruits/raw/refs/heads/%s/%s", getgenv().gitowner, getgenv().TimeSkipBranch, path)
    result = game:HttpGet(url)

    -- Return API
    return loadstring(result)()
end

getgenv().OptionsAPI = git("API/OptionsAPI.lua")
getgenv().ServicesAPI = git("API/ServicesAPI.lua")
getgenv().DynamicAPI = git("API/DynamicAPI.lua")
getgenv().TeleportAPI = git("API/TeleportAPI.lua")
getgenv().RemoteAPI = git("API/RemoteAPI.lua")
print("API's Loaded")