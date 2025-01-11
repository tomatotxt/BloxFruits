local Map         = workspace.Map
local Jungle      = Map.Jungle
local Torch = Jungle.Torch
local QuestPlates = Jungle.QuestPlates
local Character = PlayerAPI.getCharacter()
local RootPart = Character.Humanoid.RootPart

local function pressPlates(): boolean
    for i, Plate in pairs(QuestPlates:GetChildren()) do
        local Button = Plate.Button
        local Touch  = Button:FindFirstChild("TouchInterest") ~= nil
        if Touch then
            firetouchinterest(RootPart, Button, 0)
            firetouchinterest(RootPart, Button, 1)
        end
    end
    print("All plates touched")
    return true
end

local function grabTorch(): boolean
    RootPart.CFrame = Torch.CFrame
    local Torch = Character:FindFirstChildWhichIsA("Tool")
    return Torch and Torch.Name == "Torch"
end