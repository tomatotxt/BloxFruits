-- Remote before adding to main script
loadstring(game:HttpGet("https://github.com/ImMejor35/BloxFruits/raw/refs/heads/main/API/APILoader.lua"))()

local QuestGUI = DynamicAPI.LocalPlayer.PlayerGui.Main.Quest

local function getEnemy()
    local Enemies = workspace.Enemies
    for i, PotentialEnemy in pairs(Enemies:GetChildren()) do
        if PotentialEnemy:FindFirstChild("Humanoid") and PotentialEnemy.Humanoid.Health > 0 and PotentialEnemy.ClassName == "Model" and not (PotentialEnemy:GetAttribute("IsBoss") == true) then
            return PotentialEnemy
        end
    end
end
local function getNPC()
    local NPCs = workspace.NPCs
    for i, PotentialNPC in pairs(NPCs:GetChildren()) do
        if PotentialNPC.ClassName == "Model" and PotentialNPC:GetAttribute("DistanceCulled") == false then
            return PotentialNPC
        end
    end
end

local function startQuest(npcName, num)
    if QuestGUI.Visible == true then return end
    local args = {
        [1] = "StartQuest",
        [2] = npcName .. "Quest" .. tostring(num),
        [3] = num
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
end

--while task.wait() do
    -- Start Quest
    local NPC = getNPC()
    DynamicAPI.getCharacter().Humanoid.RootPart.CFrame = NPC.PrimaryPart.CFrame
    startQuest(NPC.Name, 1)
    -- Get Quest Info
    local QuestString = QuestGUI.Container.QuestTitle.Title.Text
    local QuestCount = tonumber(string.match(QuestString, "DEFEAT %d+%s")):sub(8, -1)

    -- Kill Enemies
    for i = 1, QuestCount do
        local Enemy = getEnemy()
        repeat
            if Enemy then 
                local Offset = Enemy.Head.Size.Y / 2
                local SafeSpot = CFrame.new(Enemy.Head.Position) * CFrame.new(0, 4.5 + Offset, 0)
                TeleportAPI.Teleport(SafeSpot, 1000)
                DynamicAPI.getCharacter().Humanoid.RootPart.Velocity = Vector3.zero
            end
            wait()
        until not Enemy or Enemy.Humanoid.Health <= 0
    end
--end

