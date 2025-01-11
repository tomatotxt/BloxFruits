local API = {}

local Options = {}

API.setOption = function(Option: string, Value: any)
    Options[Option] = Value
end

API.getOption = function(Option: string)
    return Options[Option]
end


-- AUTO OPTIONS
API.setOption("AutoFarm", false)
API.setOption("ChestAutoFarm", false)
API.setOption("FruitSniper", false)
API.setOption("AutoAttack", false)
API.setOption("Weapon", "Melee") -- Options are "Melee", "Blox Fruit", "Sword" Captilization Sensitive

print(API)