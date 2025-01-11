local API = {}

local toggleNoclip = function(Toggle: boolean)
    for i,v in pairs(PlayerAPI.getCharacter():GetChildren()) do
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
    local RootPart = PlayerAPI.getCharacter().HumanoidRootPart
    local Magnitude = (RootPart.Position - Goal.Position).Magnitude
    -- Move RootPart to Goal Height
    RootPart.CFrame = RootPart.CFrame * CFrame.new(0, RootPart.Position.Y - Goal.Position.Y, 0)

    while not (Magnitude < 1) do
        local Direction = (Goal.Position - RootPart.Position).unit
        RootPart.CFrame = RootPart.CFrame + Direction * (Speed * wait())
        RootPart.Velocity = Vector3.zero
        Magnitude = (RootPart.Position - Goal.Position).Magnitude
    end
    toggleNoclip(false)
end

return API
