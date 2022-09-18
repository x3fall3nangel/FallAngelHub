repeat task.wait() until game:IsLoaded()
local Library1 = loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/mercury-lib-edit/master/src.lua"))()
local gu = Library1:Create{
    Name = "FallAngel Hub",
    Size = UDim2.fromOffset(600, 400),
    Theme = Library1.Themes.Serika,
    Link = "https://discord.gg/b9QX5rnkT5"
}
local bigui = false
local smallui = false
gu:Prompt{
    Followup = false,
    Title = "Gui Size",
    Text = "Big or Small",
    Buttons = {
        big_gui = function()
            bigui = true
        end,
        small_gui = function()
            smallui = true
        end
    }
}

repeat wait() until bigui == true or smallui == true
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/mercury-lib-edit/master/src.lua"))()
local GUI = nil
if bigui then
    GUI = Library:Create{
        Name = "FallAngel Hub",
        Size = UDim2.fromOffset(700, 600),
        Theme = Library.Themes.Serika,
        Link = "https://discord.gg/b9QX5rnkT5"
    }
else
    GUI = Library:Create{
        Name = "FallAngel Hub",
        Size = UDim2.fromOffset(450, 400),
        Theme = Library.Themes.Serika,
        Link = "https://discord.gg/b9QX5rnkT5"
    }
end

local Maintab = GUI:tab{
    Name = "Main",
    Icon = "rbxassetid://2174510075"
}

-- Services
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- LocalPlayer
local LocalPlayer = Players.LocalPlayer

-- Game Module
local weaponData = require(ReplicatedStorage.WeaponData)
local combatData = ReplicatedStorage.CombatData

-- Variable
local WeaponName, WeaponType, WeaponM1Name
local Loot = 0
local Mobs , MobsDistance

local meleeWeaponNames = {
    "Sword",
    "Club",
    "Longsword",
    "Axe",
    "Katana",
    "Spear",
    "Axe",
    "Knife",
    "Mallet",
    "Blade",
    "Gauntlets",
    "Lance",
    "Scythe",
    "Twin Blade"
}

local MobTable = {}

local skillWeaponNames = {
    "Staff",
}

local function getM1Name(Weapon, WeaponType)
    local weaponModule = require(combatData[WeaponType])

    local Data = {
        Character = LocalPlayer.Character,
        Stats = {AS = 1},
        Tools = {Weapon},
        Anim = require(ReplicatedStorage.AnimationService),
    }

    for i,v in next, weaponModule(Data, Weapon) do
        if v.LMB then
            return v.LMB[1]
        end
    end
end

local function isMeleeWeapon(WeaponName)
    if weaponData[WeaponName] and table.find(meleeWeaponNames, weaponData[WeaponName].Type) then
        return true
    end
end

local function isSkillWeapon(WeaponName)
    if weaponData[WeaponName] and table.find(skillWeaponNames, weaponData[WeaponName].Type) then
        return true
    end
end

for i,v in next, ReplicatedStorage.Costumes:GetChildren() do
    table.insert(MobTable, v.Name)
end

Maintab:Dropdown{
    Name = "Choose Mobs to auto farm",
    StartingText = "Select...",
    Description = nil,
    Items = MobTable,
    Callback = function(mob)
        Mobs = mob
    end
}

Maintab:Slider{
    Name = "Auto Farm Distance",
    Default = 5,
    Min = 5,
    Max = 15,
    Callback = function(distance)
        MobsDistance = distance
    end
}

Maintab:Toggle{
    Name = "Auto Farm",
    StartingState = false,
    Callback = function(state)
        getgenv().autofarm = state
    end
}

Maintab:Toggle{
    Name = "Spam Projectiles",
    StartingState = false,
    Description = "Staff Weapon only",
    Callback = function(state)
        getgenv().spam = state
    end
}

Maintab:Toggle{
    Name = "Kill Aura",
    StartingState = false,
    Description = "Credits to dory#2620 melee weapon only",
    Callback = function(state)
        getgenv().killaura = state
    end
}

Maintab:Toggle{
    Name = "Auto Collect Loot",
    StartingState = false,
    Callback = function(state)
        getgenv().autocollectloots = state
    end
}

Maintab:Toggle{
    Name = "Auto Collect Cubits",
    StartingState = false,
    Callback = function(state)
        getgenv().autocollectcubits = state
    end
}

Maintab:Toggle{
    Name = "Auto Rebirth",
    StartingState = false,
    Callback = function(state)
        getgenv().autorebirth = state
    end
}

task.spawn(function()
    while task.wait(.1) do
        if autocollectcubits then
            for _,v in next, workspace.Projectiles:GetChildren() do
                if v.Name == "Cubits" and v:FindFirstChildWhichIsA("ProximityPrompt") then
                    fireproximityprompt(v:FindFirstChildWhichIsA("ProximityPrompt"), math.huge)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(.1) do
        if autorebirth then
            ReplicatedStorage.RemoteEvent:FireServer("Rebirth") 
        end
    end
end)

task.spawn(function()
    while task.wait(.1) do
        if autocollectloots then 
            for i,v in next, workspace.Projectiles:GetChildren() do
                if v and v:FindFirstChildWhichIsA("ProximityPrompt") then
                    fireproximityprompt(v:FindFirstChildWhichIsA("ProximityPrompt"), math.huge)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if killaura then
            for i,v in next, LocalPlayer.Character.Equipment:GetChildren() do
                if isMeleeWeapon(v.Name) then
                    WeaponName, WeaponType = v.Name, weaponData[v.Name].Type
                    WeaponM1Name = getM1Name(v, WeaponType)
                end
            end
            for i,v in next, workspace.NPCs:GetChildren() do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and WeaponName and WeaponM1Name then
                    local dist = (LocalPlayer.Character.PrimaryPart.Position - v.PrimaryPart.Position).Magnitude
                    if dist < 25 then
                        LocalPlayer.Character.Combat.RemoteEvent:FireServer("Input", WeaponName, math.random(), WeaponM1Name.."Event", v.PrimaryPart)
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(.1) do
        if spam then
            for i,v in next, LocalPlayer.Character.Equipment:GetChildren() do
                if isSkillWeapon(v.Name) then
                    WeaponName, WeaponType = v.Name, weaponData[v.Name].Type
                    WeaponM1Name = getM1Name(v, WeaponType)
                end
            end
            LocalPlayer.Character.Combat.RemoteEvent:FireServer("Input", WeaponName, math.random(), WeaponM1Name)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if autofarm and MobsDistance and Mobs then
            for i,v in next, workspace.NPCs:GetChildren() do
                if string.find(v.Name, Mobs) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, MobsDistance)
                end
            end
        end
    end
end)

GUI:set_status("Status | Active")
