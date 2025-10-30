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

API.GetSessionID = GetSessionID
API.Attack = Attack
API.Kill = Kill
API.KillAsync = KillAsync

API.CurrentWeapon = nil

return API