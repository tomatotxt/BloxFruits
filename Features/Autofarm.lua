local function getEnemy()
    local Enemies = workspace.Enemies
    for i, PotentialEnemy in pairs(Enemies:GetChildren()) do
        if PotentialEnemy:FindFirstChild("Humanoid") and PotentialEnemy.Humanoid.Health > 0 and PotentialEnemy.ClassName == "Model" and not (PotentialEnemy:GetAttribute("IsBoss") == true) then
            return PotentialEnemy
        end
    end
end

while task.wait() do
    local Enemy = getEnemy()
    if Enemy then 
        local Offset = Enemy.Head.Size.Y / 2
        local SafeSpot = CFrame.new(Enemy.Head.Position) * CFrame.new(0, 4.5 + Offset, 0)
        TeleportAPI.Teleport(SafeSpot, 1000)
        PlayerAPI.getCharacter().Humanoid.RootPart.Velocity = Vector3.zero
    end
end