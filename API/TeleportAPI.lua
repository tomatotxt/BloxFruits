local API = {}

API.toggleNoclip = function(Toggle: boolean)
    for i,v in pairs(PlayerAPI.getCharacter():GetChildren()) do
        if v.ClassName == "Part" then
            v.CanCollide = not Toggle
        end
    end
end

API.DefaultSpeed = 300
API.IsTeleporting = false

local INTERRUPT = false
API.Teleport = function(Goal: CFrame, Speed)
    if not Speed then
        Speed = API.DefaultSpeed
    end
    API.toggleNoclip(true)
    local RootPart = PlayerAPI.getCharacter().HumanoidRootPart
    RootPart.CFrame = CFrame.new( (RootPart.Position - Vector3.new(0, RootPart.Position.Y, 0)) + Vector3.new(0, Goal.Position.Y, 0) ) -- Set RootPart Height to Height of Goal
    local Magnitude = (RootPart.Position - Goal.Position).Magnitude

    while Magnitude >= 1 and INTERRUPT == false do
        API.IsTeleporting = true
        local Direction = (Goal.Position - RootPart.Position).unit
        RootPart.CFrame = RootPart.CFrame + Direction * (Speed * wait())
        Magnitude = (RootPart.Position - Goal.Position).Magnitude
    end
    API.IsTeleporting = false
    INTERRUPT = false
    API.toggleNoclip(false)
end

API.InterruptTeleport = function()
    INTERRUPT = true
end

return API
