local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Swordburst 3", HidePremium = false, SaveConfig = true, ConfigFolder = "Swordburst3", ShowIcon = true})

local mainTab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://13313903300",
	PremiumOnly = false
})

local killauraTab = Window:MakeTab({
	Name = "Kill Aura",
	Icon = "rbxassetid://13850718932",
	PremiumOnly = false
})

local miscTab = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://16307658016",
	PremiumOnly = false
})

local teleportTab = Window:MakeTab({
	Name = "Teleport",
	Icon = "rbxassetid://6723742952",
	PremiumOnly = false
})

local settingsTab = Window:MakeTab({
	Name = "Settings",
	Icon = "rbxassetid://4738901432",
	PremiumOnly = false
})

local creditTab = Window:MakeTab({
	Name = "Credits",
	Icon = "rbxassetid://7731404863",
	PremiumOnly = false
})

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local lplr = Players.LocalPlayer

local Stamina = require(ReplicatedStorage.Systems.Stamina)
local ItemList = require(ReplicatedStorage.Systems.Items.ItemList)

local mine
local boss
local rarity
local insert
local method
local waystones
local choosemob
local choosequest

local cd
local range
local dist

local mobs = {}
local mines = {}
local bosses = {}
local quests = {}
local waystone = {}
local swordburst = {}
local methods = {"above", "below", "behind"}
local category = {"Material", "Mount", "Cosmetic", "Pickaxe"}
local raritys = {"common (white)", "uncommon (green) and below", "rare (blue) and below", "epic (purple) and below", "legendary (orange) and below"}
local realrarity = {["common (white)"] = 1, ["uncommon (green) and below"] = 2, ["rare (blue) and below"] = 3, ["epic (purple) and below"] = 4, ["legendary (orange) and below"] = 5,}

local function getchar()
    return lplr.Character or lplr.CharacterAdded:Wait()
end

for i,v in next, workspace.BossArenas:GetChildren() do
    table.insert(bosses, v.Name)
end

for i,v in next, workspace.MobSpawns:GetChildren() do
    table.insert(mobs,v.Name)
end

for i,v in next, workspace.Waystones:GetChildren() do
    table.insert(waystone, v.Name)
end

for i,v in next, workspace.Ores:GetChildren() do
    insert = true
    for _,v2 in next, mines do
        if v2 == v.Name then
            insert = false
        end
    end
    if insert then
        table.insert(mines, v.Name)
    end
end

local Quest = require(game:GetService("ReplicatedStorage").Systems.Quests.QuestList)
for i,v in next, Quest do
    table.insert(quests, "Level " .. v.Level .. " " .. v.Target .. " " .. (v.Repeatable and "Repeatable" or ""))
end

for i, v in next, getconnections(lplr.Idled) do
    if v["Disable"] then
        v["Disable"](v)
    elseif v["Disconnect"] then
        v["Disconnect"](v)
    end
end

local Section1 = mainTab:AddSection({
	Name = "AutoFarm"
})

mainTab:AddDropdown({
	Name = "Select Auto farm method",
	Default = "behind",
	Options = methods,
	Callback = function(Value)
		method = Value
	end    
})

mainTab:AddSlider({
	Name = "Auto Farm Distance",
	Min = 1,
	Max = 50,
	Default = 15,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "distance",
	Callback = function(Value)
		dist = Value
	end    
})

mainTab:AddDropdown({
	Name = "Select Mobs",
	Default = nil,
	Options = mobs,
	Callback = function(Value)
		choosemob = Value
	end    
})

mainTab:AddParagraph("Auto Farm Mobs","If no one in the area the mobs wont spawn")
mainTab:AddToggle({
	Name = "Auto Farm Mobs",
	Default = false,
	Callback = function(Value)
		swordburst["automobs"] = Value
	end    
})

mainTab:AddDropdown({
	Name = "Select Boss",
	Default = nil,
	Options = bosses,
	Callback = function(Value)
		boss = Value
	end    
})

mainTab:AddParagraph("Auto Farm Boss","when boss havent spawn will farm selected mob when mob is spawned")
mainTab:AddToggle({
	Name = "Auto Farm Boss",
	Default = false,
	Callback = function(Value)
		swordburst["autoboss"] = Value
	end    
})

killauraTab:AddSlider({
	Name = "Kill Aura Cooldown",
	Min = 0.25,
	Max = 1,
	Default = 0.3,
	Color = Color3.fromRGB(255,255,255),
	Increment = 0.01,
	ValueName = "Cooldown",
	Callback = function(Value)
		cd = Value
	end    
})

killauraTab:AddSlider({
	Name = "Kill Aura Range",
	Min = 1,
	Max = 100,
	Default = 70,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Range",
	Callback = function(Value)
		range = Value
	end    
})

killauraTab:AddToggle({
	Name = "Kill Aura",
	Default = false,
	Callback = function(Value)
		swordburst["killaura"] = Value
	end    
})

killauraTab:AddParagraph("Kill aura for Players","Enable PvP to dmg ppl")
killauraTab:AddToggle({
	Name = "Kill Aura for Players",
	Default = false,
	Callback = function(Value)
		swordburst["killauraplr"] = Value
	end    
})

local Section2 = mainTab:AddSection({
	Name = "Auto Quest"
})

mainTab:AddDropdown({
	Name = "Select Quest",
	Default = nil,
	Options = quests,
	Callback = function(Value)
		choosequest = Value
	end    
})

mainTab:AddToggle({
	Name = "Auto Quest",
	Default = false,
	Callback = function(Value)
		swordburst["autoquest"] = Value
	end    
})

local Section3 = mainTab:AddSection({
	Name = "Auto Mine Ores"
})

mainTab:AddDropdown({
	Name = "Select Ores",
	Default = nil,
	Options = mines,
	Callback = function(Value)
		mine = Value
	end    
})

mainTab:AddToggle({
	Name = "Auto Mine Ores",
	Default = false,
	Callback = function(Value)
		swordburst["automine"] = Value
	end    
})

local Section1 = mainTab:AddSection({
	Name = "Auto Collect"
})

mainTab:AddToggle({
	Name = "Auto Collect",
	Default = false,
	Callback = function(Value)
		swordburst["autocollect"] = Value
	end    
})

miscTab:AddToggle({
	Name = "Reduce Lag",
	Default = false,
	Callback = function(Value)
		if Value == true then
            RunService:Set3dRenderingEnabled(false)
        else
            RunService:Set3dRenderingEnabled(true)
        end
	end    
})

teleportTab:AddDropdown({
	Name = "Select Waystones",
	Default = nil,
	Options = waystone,
	Callback = function(Value)
		waystones = Value
	end    
})

teleportTab:AddButton({
	Name = "Teleport Waystones",
	Callback = function()
        if waystones and getchar() and getchar():FindFirstChild("HumanoidRootPart") then
            for i,v in next, workspace.Waystones:GetChildren() do
                if v.Name == waystones then
                    getchar().HumanoidRootPart.CFrame = v.Main.CFrame * CFrame.new(0,0,5)
                end
            end
        end
  	end    
})

miscTab:AddButton({
	Name = "Infinite Stamina",
	Callback = function()
        debug.setupvalue(Stamina.SetMaxStamina,1,99999999)
        debug.setupvalue(Stamina.CanUseStamina,1, 99999999)
  	end    
})

miscTab:AddDropdown({
	Name = "Select Rarity",
	Default = nil,
	Options = raritys,
	Callback = function(Value)
		rarity = Value
	end    
})

miscTab:AddButton({
	Name = "Dismantle Selected rarity",
	Callback = function()
        if rarity then
            for i,v in next, ItemList do
                if v.Rarity and v.Rarity <= realrarity[rarity] and not table.find(category, v.Category) then
                    for _,items in next, ReplicatedStorage.Profiles[lplr.Name].Inventory:GetChildren() do
                        if string.find(i, items.Name) then
                            ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Crafting"):WaitForChild("Dismantle"):FireServer(items)
                            task.wait()
                        end
                    end
                end
            end
        end
  	end    
})

creditTab:AddLabel("Scripts Made by fallen_del")
creditTab:AddLabel("UI Library by Shlex")
creditTab:AddButton({
	Name = "Discord Server",
	Callback = function()
        setclipboard("https://discord.gg/auzBFqDrwZ")
  	end    
})

settingsTab:AddButton({
	Name = "Destroy Gui",
	Callback = function()
        OrionLib:Destroy()
  	end    
})

local function methodss()
    if method and dist then
        if method == "above" then
            return CFrame.new(0, dist, 0)
        elseif method == "below" then
            return CFrame.new(0, -dist,0)
        elseif method == "behind" then
            return CFrame.new(0,0, dist)
        end
    end
end

local function getclosestmobs(mob)
    local distance = math.huge
    local target
    local multitarget = {}
    for i,v in next, workspace.Mobs:GetChildren() do
        if v:FindFirstChild("HumanoidRootPart") and getchar() and getchar():FindFirstChild("HumanoidRootPart") then
            local magnitude = (getchar().HumanoidRootPart.Position - v:FindFirstChild("HumanoidRootPart").Position).magnitude
            if mob and string.find(v.Name, mob) and v:FindFirstChild("Healthbar") then
                if magnitude < distance then
                    target = v
                    distance = magnitude
                end
            end
            if magnitude <= range then
                table.insert(multitarget, v)
            end
        end
    end
    return target , multitarget
end

local function getplr() 
    local distance = range 
    local target = {}
    for i,v in next, Players:GetPlayers() do
        if v ~= lplr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and getchar() and getchar():FindFirstChild("HumanoidRootPart") then
            local magnitude = (getchar().HumanoidRootPart.Position - v.Character:FindFirstChild("HumanoidRootPart").Position).magnitude
            if magnitude <= distance then
                table.insert(target, v.Character)
            end
        end
    end
    return target
end

local function getores()
    local distance = math.huge
    local target
    for i,v in next, workspace.Ores:GetChildren() do
        if v.Name == mine and getchar() and getchar():FindFirstChild("HumanoidRootPart") and v:FindFirstChildWhichIsA("MeshPart").CFrame then
            local magnitude = (getchar().HumanoidRootPart.Position - v:FindFirstChildWhichIsA("MeshPart").Position).magnitude
            if magnitude < distance then
                target = v
                distance = magnitude
            end
        end
    end
    return target
end

local function getquest(chosequest) 
    for i,v in next, Quest do
        if string.find("Level " .. v.Level .. " " .. v.Target  .. " " .. (v.Repeatable and "Repeatable" or "") , chosequest) then
            return i
        end
    end
    return
end

task.spawn(function()
    while task.wait() do
        if swordburst["automobs"] and choosemob or swordburst["mobs"] and choosemob then
            local enemy = getclosestmobs(choosemob)
            if getchar() and getchar():FindFirstChild("HumanoidRootPart") and enemy and enemy:FindFirstChild("HumanoidRootPart") then
                getchar().HumanoidRootPart.CFrame = enemy:FindFirstChild("HumanoidRootPart").CFrame * methodss()
            end
        end 
    end
end)

task.spawn(function()
    while task.wait() do
        if swordburst["autoboss"] then
            if getchar() and getchar():FindFirstChild("HumanoidRootPart") and boss then
                local enemy = getclosestmobs(boss)
                if enemy and enemy:FindFirstChild("HumanoidRootPart") then
                    swordburst["automobs"] = false
                    getchar().HumanoidRootPart.CFrame = enemy:FindFirstChild("HumanoidRootPart").CFrame * methodss()
                else
                    for i,v in next, workspace.BossArenas:GetChildren() do
                        if string.find(v.Name, boss) and string.find(v.Spawn.ArenaBillboard.Frame.StatusLabel.Text, "Boss Cooldown") then
                            local e = string.sub(v.Spawn.ArenaBillboard.Frame.StatusLabel.Text,16,18)
                            local spawntime = string.split(e, ")")[1]
                            if tonumber(spawntime) and tonumber(spawntime) <= 1 then
                                swordburst["mobs"] = false
                                getchar().HumanoidRootPart.CFrame = v:FindFirstChild("Spawn").CFrame 
                            else
                                swordburst["mobs"] = true
                            end
                        end
                    end
                end
            end
        else
            swordburst["mobs"] = false
        end 
    end
end)

task.spawn(function()
    while true do
        local cd = cd or 0.3
        task.wait(cd)
        local totalenemy = {}
        local enemy,multienemy = getclosestmobs()
        if swordburst["killaura"] and #multienemy >= 1 then
            for i,v in next, multienemy do
                table.insert(totalenemy, v)
            end
        end
        if swordburst["killauraplr"] and #getplr() >= 1 then
            for i,v in next, getplr() do
                table.insert(totalenemy,v)
            end
        end
        if #totalenemy >= 1 then
            ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Combat"):WaitForChild("PlayerAttack"):FireServer(totalenemy)
        end
    end
end)

task.spawn(function()
    while task.wait(.5) do
        for i,v in next, lplr.PlayerGui.SkillBar.Frame:GetChildren() do
            if v:FindFirstChild("Hotkey") then
                local totalenemy = {}
                local e = choosemob or boss
                local enemy,multienemy = getclosestmobs(e)
                if swordburst["killaura"] and #multienemy >= 1 then
                    for i,v in next, multienemy do
                        table.insert(totalenemy, v)
                    end
                end
                if swordburst["killauraplr"] and #getplr() >= 1 then
                    for i,v in next, getplr() do
                        table.insert(totalenemy,v)
                    end
                end
                if #totalenemy >= 1 then
                    ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Skills"):WaitForChild("UseSkill"):FireServer(v.Name)
                    for i = 1, 8 do
                        ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Combat"):WaitForChild("PlayerSkillAttack"):FireServer(totalenemy, v.Name, i)
                    end     
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(3) do
        if swordburst["autocollect"] then
            for i,v in next, ReplicatedStorage.Drops:GetChildren() do
                if v:GetAttributes("Owner").Owner == lplr.Name then
                    ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Drops"):WaitForChild("Pickup"):FireServer(v)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(.1) do
        if swordburst["autoquest"] and choosequest then
            ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Quests"):WaitForChild("AcceptQuest"):FireServer(getquest(choosequest))
            ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Quests"):WaitForChild("CompleteQuest"):FireServer(getquest(choosequest))
        end
    end
end)

task.spawn(function()
    while task.wait(.3) do
        if swordburst["automine"] and mine then
            if getores() and getores():FindFirstChildWhichIsA("MeshPart") and getchar() and getchar():FindFirstChild("HumanoidRootPart") then
                getchar():FindFirstChild("HumanoidRootPart").CFrame =  getores():FindFirstChildWhichIsA("MeshPart").CFrame * CFrame.new(0,3,0)
                ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Equipment"):WaitForChild("EquipTool"):FireServer("Pickaxe", true) 
                ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Mining"):WaitForChild("Mine"):FireServer()
            end
        end
    end
end)

OrionLib:Init()
