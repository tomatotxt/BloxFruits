local Enemies = workspace.Enemies
local LocalPlayer = game.Players.LocalPlayer

local function getEnemy()
    for i, PotentialEnemy in pairs(Enemies:GetChildren()) do
        if PotentialEnemy.ClassName == "Model" and not (PotentialEnemy:GetAttribute("IsBoss") == true) then
            return PotentialEnemy
        end
    end
end

while task.wait() do
    local Enemy = getEnemy()
    local Offset = Enemy.Head.Size.Y / 2
    LocalPlayer.Character.Humanoid.RootPart.CFrame = CFrame.new(Enemy.Head.Position) * CFrame.new(0, 4.5 + Offset, 0)
    LocalPlayer.Character.Humanoid.RootPart.Velocity = Vector3.zero
    if Enemy.Humanoid.Health <= 0 then
        break
    end
end