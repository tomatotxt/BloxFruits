getgenv().branch = "main"
getgenv().owner = "ImMejor35"
getgenv().git = function(path: string)
    local result = "https://github.com/" .. owner .. "/Blox-Fruits/raw/refs/heads/" .. branch .. "/" .. path
    return loadstring(game:HttpGet(result))()
end

getgenv().PlayerAPI = git("API/PlayerAPI.lua")
getgenv().TeleportAPI = git("API/TeleportAPI.lua")
getgenv().RemoteAPI = git("API/RemoteAPI.lua")