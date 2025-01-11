local version = "0.0.2"
local title = "Time Skip r" .. version

-- Load main.lua
loadstring(game:HttpGet("https://github.com/ImMejor35/BloxFruits/raw/refs/heads/main/main.lua"))()

local ImGui = loadstring(game:HttpGet('https://github.com/depthso/Roblox-ImGUI/raw/main/ImGui.lua'))()

local MainWindow = ImGui:CreateWindow({Title=title,Size=UDim2.fromOffset(350,300),Position=UDim2.new(0.5,0,0,70),NoGradientAll=true,Colors={Window={BackgroundColor3=Color3.fromRGB(40,40,40),BackgroundTransparency=0.1,ResizeGrip={TextColor3=Color3.fromRGB(80,80,80)},TitleBar={BackgroundColor3=Color3.fromRGB(25,25,25),[{Recursive=true,Name="ToggleButton"}]={BackgroundColor3=Color3.fromRGB(80,80,80)}},ToolBar={TabButton={BackgroundColor3=Color3.fromRGB(80,80,80)}}},CheckBox={Tickbox={BackgroundColor3=Color3.fromRGB(20,20,20),Tick={ImageColor3=Color3.fromRGB(255,255,255)}}},Slider={Grab={BackgroundColor3=Color3.fromRGB(60,60,60)},BackgroundColor3=Color3.fromRGB(20,20,20)},CollapsingHeader={TitleBar={BackgroundColor3=Color3.fromRGB(20,20,20)}}}})
MainWindow:Center()

local AutomationTab = MainWindow:CreateTab({
	Name = "Automation",
	Visible = true 
})

local ChestAutoFarm = AutomationTab:Checkbox({
	Label = "Chest Autofarm",
	Value = false,
	Callback = function(self, Value)
		OptionsAPI.setOption("ChestAutoFarm", Value)
	end,
})

local AutoEquipWeapon = AutomationTab:Checkbox({
	Label = "Auto Equip Weapon",
	Value = false,
	Callback = function(self, Value)
		OptionsAPI.setOption("AutoEquipWeapon", Value)
	end,
})