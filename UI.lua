local version = "0.0.1"
local title = "Time Skip v" .. version

-- Load main.lua
loadstring(game:HttpGet("https://github.com/ImMejor35/BloxFruits/raw/refs/heads/main/main.lua"))()

local ImGui = loadstring(game:HttpGet('https://github.com/depthso/Roblox-ImGUI/raw/main/ImGui.lua'))()

local MainWindow = ImGui:CreateWindow({
	Title = title,
	Size = UDim2.fromOffset(350, 300), --// Roblox property 
	Position = UDim2.new(0.5, 0, 0, 70), --// Roblox property 
})

local AutomationTab = MainWindow:CreateTab({
	Name = "Automation",
	Visible = true 
})


AutomationTab:Checkbox({
	Label = "Chest Autofarm",
	Value = false,
	Callback = function(self, Value)
		OptionsAPI.setOption("ChestAutoFarm", Value)
	end,
})
