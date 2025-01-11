local function toggleNoclip(Toggle: boolean)
    for i,v in pairs(PlayerAPI.getCharacter():GetChildren()) do
        if v.ClassName == "Part" then
            v.CanCollide = not Toggle
        end
    end
end

local API = {}
API.DefaultSpeed = 300

API.Teleport = function(Goal: CFrame, Speed)
    if not Speed then
        Speed = API.DefaultSpeed
    end
    toggleNoclip(true)
    local RootPart = PlayerAPI.getCharacter().HumanoidRootPart
    RootPart.CFrame = CFrame.new( (RootPart.Position - Vector3.new(0, RootPart.Position.Y, 0)) + Vector3.new(0, Goal.Position.Y, 0) ) -- Set RootPart Height to Height of Goal
    local Magnitude = (RootPart.Position - Goal.Position).Magnitude

    while not (Magnitude < 1) do
        local Direction = (Goal.Position - RootPart.Position).unit
        RootPart.CFrame = RootPart.CFrame + Direction * (Speed * wait())
        Magnitude = (RootPart.Position - Goal.Position).Magnitude
    end
    toggleNoclip(false)
end

wait = task.wait
return API
