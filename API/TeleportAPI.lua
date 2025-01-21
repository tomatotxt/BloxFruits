local API = {}

local toggleNoclip = function(Toggle: boolean)
    for i,v in pairs(DynamicAPI.getCharacter():GetChildren()) do
        if v.ClassName == "Part" then
            v.CanCollide = not Toggle
        end
    end
end
API.toggleNoclip = toggleNoclip
API.DefaultSpeed = 300
API.IsTeleporting = false

API.Teleport = function(Goal, Speed)
    if not Speed then
        Speed = API.DefaultSpeed 
    end
    toggleNoclip(true)
    local RootPart = DynamicAPI.getCharacter().HumanoidRootPart
    local Magnitude = (RootPart.Position - Goal.Position).Magnitude

    while not (Magnitude < 1) do
        local Direction = (Goal.Position - RootPart.Position).unit
        RootPart.CFrame = RootPart.CFrame + Direction * (Speed * wait())
        RootPart.Velocity = Vector3.zero
        Magnitude = (RootPart.Position - Goal.Position).Magnitude
    end
    toggleNoclip(false)
end

return API
