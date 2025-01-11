getgenv().branch = "main"
getgenv().owner = "ImMejor35"
local git = function(path: string)
    local result = "https://github.com/" .. owner .. "/BloxFruits/raw/refs/heads/" .. branch .. "/" .. path
    return loadstring(game:HttpGet(result))()
end

getgenv().PlayerAPI = git("API/DynamicAPI.lua")
getgenv().TeleportAPI = git("API/TeleportAPI.lua")
getgenv().RemoteAPI = git("API/RemoteAPI.lua")

getgenv().Options = {
    ChestAutoFarm = false,
    AutoAttack = false,
    Weapon = "Melee" -- Options are "Melee", "Blox Fruit" Captilization Sensitive
}