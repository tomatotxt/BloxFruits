-- Constants


-- Auto Chest Utils
local UncheckedChests = {}
local FirstRun = true

local function DistanceFromPlrSort(ObjectList: table)
    local RootPart = PlayerAPI.getCharacter().LowerTorso
    table.sort(ObjectList, function(ChestA, ChestB)
        local RootPos = RootPart.Position
        local DistanceA = (RootPos - ChestA.Position).Magnitude
        local DistanceB = (RootPos - ChestB.Position).Magnitude
        return DistanceA < DistanceB
    end)
end

local function getChestsSorted()
    if FirstRun then
        FirstRun = false
        local Objects = game:GetDescendants()
        for i, Object in pairs(Objects) do
            if Object.Name:find("Chest") and Object.ClassName == "Part" then
                table.insert(UncheckedChests, Object)
            end
        end
    end
    local Chests = {}
    for i, Chest in pairs(UncheckedChests) do
        if Chest:FindFirstChild("TouchInterest") then
            table.insert(Chests, Chest)
        end
    end
    DistanceFromPlrSort(Chests)
    return Chests
end

local function SafeExecute(Function, OptionName)
    local Success, Error = pcall(Function)
    if not Success then
        OptionsAPI.setOption(OptionName, false)
        warn("Error in " .. OptionName .. ":", Error)
    end
end

-- Auto Chest Farm Thread
task.spawn(function()
    while wait() do
        if OptionsAPI.getOption("ChestAutoFarm") then
            SafeExecute(function() 
                local Chests = getChestsSorted()
                if #Chests > 0 then
                    TeleportAPI.Teleport(Chests[1].CFrame)
                end
            end, "ChestAutoFarm")
        end
    end
end)


-- Main
local function main()
    -- AUTO OPTIONS
    OptionsAPI.setOption("AutoEquipWeapon", false)
    OptionsAPI.setOption("ChestAutoFarm", false)
    OptionsAPI.setOption("AutoFarm", false)
    OptionsAPI.setOption("FruitSniper", false)
    OptionsAPI.setOption("WeaponType", "Melee") -- Options are "Melee", "Blox Fruit", "Sword" Captilization Sensitive
    
    return true
end
-- Main Loop
local function mainloop() 
    if OptionsAPI.getOption("AutoEquipWeapon") then
        SafeExecute(function() 
            local Character = PlayerAPI.getCharacter()
            for i, Tool: Tool in pairs(PlayerAPI.LocalPlayer.Backpack:GetChildren()) do
                if Tool.ToolTip == OptionsAPI.getOption("WeaponType") then
                    Tool.Parent = Character
                end
            end
        end, "AutoEquipWeapon")
    end
end

loadstring(game:HttpGet("https://github.com/ImMejor35/BloxFruits/raw/refs/heads/main/API/APILoader.lua"))()
main()
task.spawn(function() while wait() do mainloop(); end end)
print("Main Loaded.")