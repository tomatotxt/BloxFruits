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

API.Teleport = function(Goal: CFrame, Speed)
    if API.IsTeleporting then
        warn("Already teleporting.")
        return
    end
    if not Speed then
        Speed = API.DefaultSpeed
    end
    API.toggleNoclip(true)
    local RootPart = PlayerAPI.getCharacter().HumanoidRootPart
    -- Set the Y position of the Character to the Y position of the Goal.
    RootPart.CFrame = CFrame.new( (RootPart.Position - Vector3.new(0, RootPart.Position.Y, 0)) + Vector3.new(0, Goal.Position.Y, 0) )
    local Magnitude = (RootPart.Position - Goal.Position).Magnitude

    API.IsTeleporting = true
    local Loop = ServicesAPI.RunService.RenderStepped:Connect(function(deltaTime)
        local Direction = (Goal.Position - RootPart.Position).unit
        RootPart.CFrame = RootPart.CFrame + Direction * (Speed * deltaTime)
        RootPart.Velocity = Vector3.zero --Stop Character from moving specifically in the Y axis.
        Magnitude = (RootPart.Position - Goal.Position).Magnitude
    end)

    while Magnitude >= 1 do
        wait(.1)
    end
    Loop:Disconnect()
    API.IsTeleporting = false

    API.toggleNoclip(false)
end

return API
