local API = {}

local Net = ServicesAPI.ReplicatedStorage.Modules.Net
local RegisterAttack = Net["RE/RegisterAttack"]
local RegisterHit = Net["RE/RegisterHit"]

local UserId = ServicesAPI.Players.LocalPlayer.UserId

local function GetSessionID()
    -- Get Combat Thread
    local SendHitsToServer = getrenv()._G.SendHitsToServer
    local CombatThread = getupvalues(SendHitsToServer)[1]
    -- Construct Session ID
    local UserIDSlice = tostring(UserId):sub(2, 4)
    local MemorySlice = tostring(CombatThread):sub(11, 15)
    -- Combine The Two Parts
    local SessionID = UserIDSlice .. MemorySlice

    return SessionID
end

local function Attack(TargetCharacter)
    RegisterAttack:FireServer(0.5)
    local dataTable = {
        TargetCharacter:WaitForChild("RightLowerLeg"),
        {},
        nil,
        GetSessionID()
    }
    RegisterHit:FireServer(unpack(dataTable))
end

local function Kill(EnemyCharacter)
    repeat task.wait()
        Attack(EnemyCharacter)
    until EnemyCharacter.Humanoid.Health == 0
end

local function KillAsync(EnemyCharacter)
    task.spawn(Kill, EnemyCharacter)
end

-- NPC / Quest helpers (pulled from BETA/npc-api.luau)
-- These use environment introspection (getgc/getupvalues) and CommF_ remote
local function findNpcDirectory()
    if not getgc or not islclosure or not getupvalues then
        return nil
    end
    local targetScriptName = "NPC"
    for _, func in ipairs(getgc()) do
        if islclosure(func) then
            local success, info = pcall(debug.getinfo, func, "s")
            if success and info and info.source and info.source:match(targetScriptName) then
                local ok, upvalues = pcall(getupvalues, func)
                if ok and type(upvalues) == "table" then
                    local potentialDirectory = upvalues[2]
                    if type(potentialDirectory) == "table" and #potentialDirectory > 100 then
                        return potentialDirectory
                    end
                end
            end
        end
    end
    return nil
end

local function GetNPC(TargetName)
    local NPCDirectory = findNpcDirectory()
    if not NPCDirectory then return nil end
    for i, NPCRef in pairs(NPCDirectory) do
        local NPCObject = NPCRef.Object
        if NPCObject and NPCObject.Name == TargetName then
            return NPCRef
        end
    end
    return nil
end

local function GetQuestInfo(NPCRef)
    if not NPCRef or not NPCRef.Object then return nil end
    local Object = NPCRef.Object
    local Player = DynamicAPI and DynamicAPI.LocalPlayer or ServicesAPI.Players.LocalPlayer
    local Dialogue = Object.GetDialogue(Object, Player)

    return {
        ["InternalQuestName"] = Dialogue.InternalQuestName,
        ["QuestInfo"] = Dialogue.Get(Dialogue)
    }
end

local function StartQuest(NPCName, QuestNumber)
    local NPCRef = GetNPC(NPCName)
    if not NPCRef then
        warn("RemoteAPI.StartQuest: NPC not found - " .. tostring(NPCName))
        return false
    end
    local QuestInfo = GetQuestInfo(NPCRef)
    if not QuestInfo or not ServicesAPI.ReplicatedStorage then
        warn("RemoteAPI.StartQuest: missing quest info or ReplicatedStorage")
        return false
    end
    local CommF = ServicesAPI.ReplicatedStorage:FindFirstChild("Remotes") and ServicesAPI.ReplicatedStorage.Remotes:FindFirstChild("CommF_")
    if not CommF then
        warn("RemoteAPI.StartQuest: CommF_ remote not found")
        return false
    end
    CommF:InvokeServer("StartQuest", QuestInfo.InternalQuestName, QuestNumber)
    return true
end

API.GetSessionID = GetSessionID
API.Attack = Attack
API.Kill = Kill
API.KillAsync = KillAsync

-- Expose NPC helpers
API.findNpcDirectory = findNpcDirectory
API.GetNPC = GetNPC
API.GetQuestInfo = GetQuestInfo
API.StartQuest = StartQuest

API.CurrentWeapon = nil

return API