local API = {}

API.LocalPlayer = game:GetService("Players").LocalPlayer

local function getCharacter()
    if not API.LocalPlayer.Character then
        API.LocalPlayer.CharacterAdded:Wait()
    end
    API.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    return API.LocalPlayer.Character
end

API.getCharacter = getCharacter

return API