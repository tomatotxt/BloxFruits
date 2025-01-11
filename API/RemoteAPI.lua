local API = {}

local rawAttackMelee = nil
API.attackMelee    = nil
for i,v in pairs(getgc()) do
   if type(v) == "function" and getinfo(v).name == "attackMelee" then
      rawAttackMelee = v
      API.attackMelee    = function(...)
        setthreadidentity(2) -- Weird Error if you don't set the thread identity
        rawAttackMelee(...)
        setthreadidentity(8)
      end
   end 
end

API.CombatFramework = require(ServicesAPI.ReplicatedStorage.Controllers.CombatController)
API.CameraShaker = require(ServicesAPI.ReplicatedStorage.Util.CameraShaker.Main)

-- CONSTRUCT getWeapon FUNCTION

local function getWeapon()
    local Backpack = PlayerAPI.LocalPlayer.Backpack

end

getgenv().Attack = false
getgenv().FastAttack = false

API.ToggleAttack = function()
    Attack = not Attack
    return Attack
end

ServicesAPI.RunService.RenderStepped:Connect(function()
    if FastAttack then
        local Character = PlayerAPI.getCharacter()
    end
    if Attack then
        PlayerAPI.getCharacter().Stun.Value = 0
        PlayerAPI.getCharacter().Humanoid.Sit = false
        API.attackMelee(getWeapon())
        API.CameraShaker:Stop()
    end
end)

API.ToggleFastAttack = function()
    FastAttack = not FastAttack
    return FastAttack
end

return API