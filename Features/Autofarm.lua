-- Remote before adding to main script
loadstring(game:HttpGet("https://github.com/ImMejor35/BloxFruits/raw/refs/heads/main/API/APILoader.lua"))()

local QuestGUI = DynamicAPI.LocalPlayer.PlayerGui.Main.Quest
local Dialogue = DynamicAPI.LocalPlayer.PlayerGui.Main.Dialogue
local EnemySpawns = workspace._WorldOrigin.EnemySpawns

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
    return NPCs:FindFirstChild("QUEST", true).Parent.Parent
end

local function startQuest(NPC)
    if QuestGUI.Visible == true then return end
    DynamicAPI.getCharacter().Humanoid.RootPart.CFrame = NPC.PrimaryPart.CFrame
    wait()
    mousemoveabs(960, 540)
    mouse1click()
end

--while wait() do
    -- Start Quest
    local NPC = getNPC()
    print("NPC", NPC)
    startQuest(NPC)
    -- Get Quest Info
    local QuestString = QuestGUI.Container.QuestTitle.Title.Text
    local QuestCount = tonumber(QuestString:sub(8, 9))
    local Option1 = Dialogue.Option1.TextLabel.Text
    local Option2 = Dialogue.Option2.TextLabel.Text
    local Option3 = Dialogue.Option3.TextLabel.Text

    local NPC1 = nil
    local NPC2 = nil
    local BOSS = nil
    if Option3 == "Option" then
        NPC1 = Option1
        BOSS = Option2
    else
        NPC1 = Option1
        NPC2 = Option2
        BOSS = Option3
    end

    -- Kill Enemies
    for i = 1, QuestCount do
        local Enemy = getEnemy()
        while wait() and Enemy do 
            local SafeSpot = CFrame.new(Enemy.HumanoidRootPart.Position) * CFrame.new(0, 57, 0)
            TeleportAPI.Teleport(SafeSpot, 1000)
        end
        wait()
    end
--end

