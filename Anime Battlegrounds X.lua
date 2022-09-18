repeat task.wait() until game:IsLoaded()
local Library1 = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()
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
            return bigui
        end,
        small_gui = function()
            smallui = true
            return smallui
        end
    }
}

repeat task.wait() until bigui == true or smallui == true
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()
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

local Teleporttab = GUI:tab{
    Name = "Teleport"
}

local Abilitytab = GUI:tab{
    Name = "Ability",
    Icon = "rbxassetid://8238487508"
}

local Misctab = GUI:tab{
    Name = "Misc",
    Icon = "rbxassetid://3340612861"
}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local HttpService = game:GetService("HttpService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")


local LocalPlayer = Players.LocalPlayer
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local mobs = 0
local eventmobs = 0
local tp
local dash
local farm
local amount
local amount1

getgenv().ability = false

local arenaepic = {
    "Tree Village Arena (Lvl 0)",
    "Ninja War Battlefield Arena (Lvl 10)",
    "Shonin Exams Arena (Lvl 20)",
    "Bell Games Arena (Lvl 40)",
    "Planet Niran Arena (Lvl 50)",
    "Power Tournament Arena (Lvl 60)",
    "Dora City Arena (Lvl 90)",
    "Kimoyo Ward Arena (Lvl 100)",
    "Sports Stadium Arena (Lvl 115)",
    "Cactoo Island Arena (Lvl200)",
    "Giant Tree Island Arena (Lvl 300)",
    "Punk Danger Island Arena (Lvl400)",
    "End Valley",
    "Court of Death"
}

local arenacframe = {
    ["Tree Village Arena"] = {
        CFrame = CFrame.new(2421, 175, 2967)
    },
    ["Shonin Exams Arena"] = {
        CFrame = CFrame.new(1539, 254, 3007)
    },
    ["Power Tournament Arena"] = {
        CFrame = CFrame.new(2581, 226, -1929)
    },
    ["Planet Niran Arena"] = {
        CFrame = CFrame.new(1348, 216, -2557)
    },
    ["Sports Stadium Arena"] = {
        CFrame = CFrame.new(7096, 222, 1082)
    },
    ["Bell Games Arena"] = {
        CFrame = CFrame.new(1551, 214, -1346)
    },
    ["Ninja War Battlefield Arena"] = {
        CFrame = CFrame.new(1959, 164, 2230)
    },
    ["Dora City Arena"] = {
        CFrame = CFrame.new(6723, 175, 222)
    },
    ["Kimoyo Ward Arena"] = {
        CFrame = CFrame.new(6127, 164, 666)
    },
    ["Cactoo Island Arena"] = {
        CFrame = CFrame.new(6335, 190, 6144)
    },
    ["Punk Danger Island Arena"] = {
        CFrame = CFrame.new(4938, 184, 4897)
    },
    ["Giant Tree Island Arena"] = {
        CFrame = CFrame.new(4820, 201, 6773)
    },
    ["End Valley"] = {
        CFrame = CFrame.new()
    },
    ["Court of Death"] = {
        CFrame = CFrame.new()
    }
}

local boss = {
    "Narek",
    "Mayasa",
    "Dara",
    "Bell Perfect Form",
    "Gozu",
    "Gozu Ultra",
    "Almighty",
    "All In One",
    "Doremiya",
    "Daiko",
    "Fluffy",
    "Kanai"
}

local File = pcall(function()
    AllIDs = HttpService:JSONDecode(readfile("NotSameServers.json"))
end)

if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", HttpService:JSONEncode(AllIDs))
end

local function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                task.wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    task.wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
            end
        end
    end
end

local function Rejoin()
    while task.wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end


local function checkarena(arena)
    local c = nil
    for i, v in next, arenacframe do
        if string.find(arena, i) then
            c = arenacframe[i]
        end
    end
    return c
end

local function checkfarm(arena)
    local a = nil
    for i, v in next, arenacframe do
        if arena == "End Valley" or arena == "Court of Death" then
            a = LocalPlayer.DisplayName .. "'s Arena" 
            return a
        end
        if string.find(arena, i) then
            a = i
        end
    end
    return a
end

local function getchest()
    local distance = math.huge
    local target = nil
    for i, v in next, workspace["SPAWNED_CHESTS"]:GetChildren() do
        if v:FindFirstChild("Center") or v:FindFirstChild("Part") then
            local magnitude = (v.Center.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude
            if magnitude < distance then
                distance = magnitude
                target = v
            end
        end
    end
    return target
end

local function getarena()
    local wow = nil
    if farm == "End Valley" or farm == "Court of Death" then
        for  _, arenaname in next, workspace["ACTIVE_WEEKLY_ARENAS"]:GetChildren() do
            if arenaname.Name == LocalPlayer.DisplayName .. "'s Arena" and arenaname:FindFirstChild("JoinSpawn") then
                wow = arenaname.Enemies
                return wow
            end
        end
    end
    if farm then
        for i, arenaname in next, workspace.WORLD:GetChildren() do
            if arenaname.Arenas:FindFirstChild(checkfarm(farm)) then
                wow = arenaname.Arenas:FindFirstChild(checkfarm(farm)).Enemies
            end
        end
    end
    return wow
end

local function checkarenaboss()
    local epicbos = nil
    if farm then
        for i, bossreal in next, boss do
            for i2, v in next, arenaepic do
                if i == i2 then
                    epicbos = bossreal
                end
            end
        end
    end
    return epicbos
end

local function dmgpoint()
    if hookmetamethod then
            local __namecall
        __namecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
            local method = getnamecallmethod()
            local args = {
                ...
            }
            local self = args[1]
            if not checkcaller() and method == "FireServer" and tostring(self) == "DamageTrigger" and args[2] == "Point" then
                for i = 1, amount do
                    __namecall(...)
                end
            end
            return __namecall(...)
        end))
    else
        local mt = getrawmetatable(game)
        setreadonly(mt, false)

        local __namecall = mt.__namecall

        mt.__namecall = newcclosure(function(...)
            local args = {
                ...
            }
            local self = args[1]
            local method = getnamecallmethod()
            if not checkcaller() and method == "FireServer" and tostring(self) == "DamageTrigger" and args[2] == "Point" then
                for i = 1, amount do
                    __namecall(...)
                end
            end
            return __namecall(...)
        end)
    end
end

local function dmghitbox()
    if hookmetamethod then
        local __namecall
        __namecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
            local method = getnamecallmethod()
            local args = {
                ...
            }
            local self = args[1]
            if not checkcaller() and method == "FireServer" and tostring(self) == "DamageTrigger" and args[2] == "Hitbox" then
                args[3]["DamageRate"] = 0
                args[3]["LifeTime"] = 100
            end
            return __namecall(...)
        end))
        local __namecall 
        __namecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
            local method = getnamecallmethod()
            local args = {
                ...
            }
            local self = args[1]
            if not checkcaller() and method == "FireServer" and tostring(self) == "DamageTrigger" and args[2] == "HitboxUpdate" then
                for i = 1, amount1 do
                    __namecall(...)
                end
            end
            return __namecall(...)
        end))
    else
        local mt = getrawmetatable(game)
        setreadonly(mt, false)

        local __namecall = mt.__namecall
        mt.__namecall = newcclosure(function(...)
            local args = {
                ...
            }
            local self = args[1]
            local method = getnamecallmethod()
            if not checkcaller() and method == "FireServer" and tostring(self) == "DamageTrigger" and args[2] == "Hitbox" then
                args[3]["DamageRate"] = 0
                args[3]["LifeTime"] = 100
            end
            return __namecall(...)
        end)

        local __namecall = mt.__namecall
        mt.__namecall = newcclosure(function(...)
            local method = getnamecallmethod()
            local args = {
                ...
            }
            local self = args[1]
            if not checkcaller() and method == "FireServer" and tostring(self) == "DamageTrigger" and args[2] == "HitboxUpdate" then
                for i = 1, amount1 do
                    __namecall(...)
                end
            end
            return __namecall(...)
        end)
    end
end

local function modash()
    local dashs = require(ReplicatedFirst.Classes.MovementHandler)
    local old = dashs.Update
    dashs.Update = function(...)
        local args = {
            ...
        }
        for i, v in next, args do
            if type(v) == "table" then
                for i2, v2 in next, v do
                    v.DashStamina = 0
                    v.DashDistance = tonumber(dash)
                    v.DashCooldown = 0
                    v.UsedDoubleJump = false
                    v.ReadyForDoubleJump = true
                end
            end
        end
        return old(...)
    end
end

Maintab:Dropdown{
    Name = "Choose Arena for Auto Farm",
    StartingText = "Select...",
    Items = arenaepic,
    Callback = function(v)
        if farm then
            ReplicatedStorage.Remotes.JoinLeaveArena:FireServer(checkfarm(farm), false)
        end
        farm = v
    end
}

Maintab:Toggle{
    Name = "Auto Farm Arena",
    Description = "This take a bit to load",
    StartingState = false,
    Callback = function(state)
        getgenv().farmarena = state
    end
}

Maintab:Toggle{
    Name = "Auto Farm Arena Boss",
    Description = "Choose Arena",
    StartingState = false,
    Callback = function(state)
        getgenv().farmboss = state
    end
}

Maintab:Toggle{
    Name = "Auto Farm Chest",
    StartingState = false,
    Callback = function(state)
        getgenv().farmchest = state
    end
}

Maintab:Toggle{
    Name = "Auto spawn Fighters",
    StartingState = false,
    Callback = function(state)
        getgenv().autofighters = state
    end
}

Abilitytab:Keybind{
    Name = "Auto Ability",
    Keybind = Enum.KeyCode.R,
    Callback = function()
        ability = not ability
    end
}

Abilitytab:Toggle{
    Name = "Auto Ability",
    Description = "For who dont want use keybind",
    StartingState = false,
    Callback = function(state)
        getgenv().autoability = state
    end
}

Maintab:Toggle{
    Name = "Punch Aura",
    StartingState = false,
    Callback = function(state)
        getgenv().auto = state
    end
}

Maintab:Toggle{
    Name = "Auto Rebirth",
    Description = "idk it work or not",
    Callback = function(state) 
        getgenv().autorebirth = state
    end
}

Maintab:Toggle{
    Name = "Instant Collect",
    StartingState = false,
    Callback = function(state)
        getgenv().collect = state
    end
}

Maintab:Toggle{
    Name = "Auto Block",
    StartingState = false,
    Callback = function(state)
        getgenv().block = state
    end
}

Abilitytab:Button{
    Name = "Ability List For Point",
    Description = "",
    Callback = function()
        GUI:Notification{
            Title = "Only these ability will work",
            Text = [[Tail Spin, Meteor, Skull Bomb, Dee Smash, Spirit Bomb, Deathball, Blast Volley, Bang Beam, Power Impact, Duplicate,  Black Lightning, Giant, Mace Smash, Detroit Smash, Thunder Shock, Decay, Rasengan, Di-Jambe, Raikiri, Burning Attack, Clay Explosion, Magatama, TriBlast, Planet Burst, Gravity Push, Fire Lance, Gift Bomb, Texas Smash]],
            Duration = 20,
            Callback = function()
            end
        }
    end
}

Abilitytab:Textbox{
    Name = "Ability Damage Point Amount",
    Description = "Please insert any numbers(recommend use 1000)",
    Callback = function(Text)
        amount = tonumber(Text)
    end
}

Abilitytab:Button{
Name = "Ability Damage For Point",
Description = "Work On some Ability only | Press 1 time only or u will crash",
StartingState = false,
Callback = function()
    if amount then
        dmgpoint()
    else
        Maintab:Prompt{
            Title = "PLEASE",
            Text = "Please Insert number On Ability boost Amount"
        }
    end
end
}

Abilitytab:Button{
Name = "Ability List For Hitbox",
Description = "",
Callback = function()
    GUI:Notification{
        Title = "Only these ability will work",
        Text = [[Tornado, Masenko, Red Hawk, Ice Time, Whirlwind, Wood Dragon, Sand Wave, Bubble Gust, Sea Quake, Double Beam, Air Cannon, Feather Slash, Flying Fist, Flame Wall, Ikoku, Hard Punch, Fireball, Flashfreeze, Santoryu, Destructo Disk, Electro Pistol, Fang Spin, Bug Attack, Susanoo, Galick Gun, Twin Lions, Kamehameha, Wood Prison, Beam Cannon, Water Pump, Black Hole, Amaterasu, Razor Wind]],
        Duration = 20,
        Callback = function()
        end
    }
end
}

Abilitytab:Textbox{
Name = "Ability Damage Hitbox Amount",
Description = "Dont go too high with this or u will crash(recommend 100)",
Callback = function(Text)
    amount1 = tonumber(Text)
end
}

Abilitytab:Button{
Name = "Ability Damage For Hitbox",
Description = "Work On some Ability only | Press 1 time only or u will crash",
StartingState = false,
Callback = function()
    if amount1 then
        dmghitbox()
    else
        Maintab:Prompt{
            Title = "PLEASE",
            Text = "Please Insert number On Ability boost Amount"
        }
    end
end
}


Maintab:Button{
    Name = "Anti afk",
    Callback = function()
        if getconnections then
            for i, v in next, getconnections(game.Players.LocalPlayer.Idled) do
                if v["Disable"] then
                    v["Disable"](v)
                elseif v["Disconnect"] then
                    v["Disconnect"](v)
                end
            end
        else
            Maintab:Prompt{
                Title = "Alert",
                Text = "Ur Executorr/exploit doesnt support getconnections"
            }
        end
    end
}


Maintab:Textbox{
    Name = "Dash Distance",
    Description = "Insert any numbers u want",
    Callback = function(v)
        dash = v
    end
}

Maintab:Button{
    Name = "Mod Dash Distance",
    Callback = function()
        if dash then
            modash()
        else
            Maintab:Prompt{
                Title = "PLEASE",
                Text = "Please Insert number On Dash Distance"
            }
        end
    end
}

Maintab:Button{
    Name = "Op Boat Speed",
    StartingState = false,
    Callback = function()
        local eboat = require(game.ReplicatedStorage.Modules.Bins.BoatData)
        for i, v in next, eboat do
            eboat[i].Speed = 999
        end
    end
}

GUI:Credit{
    Name = "x3Fall3nAngel",
    Description = "Made the script",
    V3rm = "https://v3rmillion.net/member.php?action=profile&uid=2270329",
    Discord = "https://discord.gg/b9QX5rnkT5"
}

GUI:Notification{
    Title = "Hey!",
    Text = "Join our discord server! discord.gg/b9QX5rnkT5",
    Duration = 5,
    Callback = function()
    end
}

Teleporttab:Dropdown{
    Name = "Choose Arena",
    StartingText = "Select...",
    Items = arenaepic,
    Callback = function(v)
        tp = v
    end
}

Teleporttab:Button{
    Name = "Teleport",
    Callback = function()
        if tp then
            LocalPlayer.Character.HumanoidRootPart.CFrame = checkarena(tp).CFrame * CFrame.new(0, 5, 0)
        end
    end
}

Misctab:Button{
    Name = "Rejoin",
    Callback = function()
        Rejoin()
    end
}

task.spawn(function()
    while task.wait() do
        pcall(function()
            if farm then
                if farm == "End Valley" and farmarena or farm == "Court of Death" and farmarena then
                    repeat
                        if not LocalPlayer.PlayerGui:FindFirstChild("Spawn") then
                            ReplicatedStorage.Remotes.UsePortal:InvokeServer("Tree Village")
                            wait(1)
                            ReplicatedStorage.Remotes.CreateWeeklyArena:InvokeServer(farm)
                        end
                        for _, v in next, getarena():GetChildren() do
                            if v:FindFirstChild("HumanoidRootPart") and farmarena and LocalPlayer.PlayerGui:FindFirstChild("Spawn") then
                                LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                                eventmobs = eventmobs + 1
                            end
                        end
                        wait(.1)
                    until eventmobs == 0 or farmarena == false
                end
            end
            if farm and farmarena then   
                if farm ~= "End Valley" or farm ~= "Court of Death" then
                    repeat
                        if not LocalPlayer.PlayerGui:FindFirstChild("Spawn") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = checkarena(farm).CFrame * CFrame.new(0, 0, -5)
                            ReplicatedStorage.Remotes.JoinLeaveArena:FireServer(checkfarm(farm), true)    
                        end
                        mobs = 0
                        for _, v in next, getarena():GetChildren() do
                            if v:FindFirstChild("HumanoidRootPart") and farmarena and LocalPlayer.PlayerGui:FindFirstChild("Spawn") then
                                LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                                mobs = mobs + 1
                            end
                        end
                        wait(.1)
                    until mobs == 0 or farmarena == false
                end
            end
        end)
    end
end)

task.spawn(function()
    while task.wait() do
        if auto then
            ReplicatedStorage.Remotes.Melee:FireServer("Melee")
        end
    end
end)

task.spawn(function()
    while task.wait(.5) do
        if autorebirth then
            ReplicatedStorage.Remotes.Rebirth:InvokeServer()
        end
    end
end)

task.spawn(function()
    while task.wait(.1) do
        pcall(function()
            if ability or autoability then
                for i, v in pairs(LocalPlayer.PlayerGui.UI.HotbarArea.Hotbar.AbilityButtons:GetChildren()) do
                    if v:IsA("Frame") then
                        VirtualInputManager:SendKeyEvent(true, v:FindFirstChild("Number").Text, false, game)
                    end
                end
            end
        end)
    end
end)

task.spawn(function()
    while task.wait() do
        pcall(function()
            if collect then
                pcall(function()
                    for i, v in next, workspace.FX:GetChildren() do
                        if string.len(v.Name) > 20 and collect then
                            v.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                        end
                    end
                end)
            end
        end)
    end
end)

task.spawn(function()
    local __namecall
    __namecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
        local method = getnamecallmethod()
        local args = {
            ...
        }
        local self = args[1]
        if not checkcaller() and method == "FireServer" and tostring(self) == "Movement" then
            return
        end
        return __namecall(...)
    end))
    local dashduration = require(ReplicatedStorage.Modules.Bins.AbilityData)
    for i, v in next, dashduration do
        dashduration[i].Duration = 0
    end
end)

task.spawn(function()
    while wait(.1) do
        pcall(function()
            if farmchest then
                pcall(function()
                    repeat
                        LocalPlayer.Character.HumanoidRootPart.CFrame = getchest().Center.CFrame * CFrame.new(0, 1.8, 0)
                        task.wait(4)
                    until getchest == nil or farmchest == false
                end)
            end
        end)
    end
end)

task.spawn(function()
    while task.wait() do
        pcall(function()
            if autofighters then
                for i, v in next, LocalPlayer.PlayerGui.UI.InventoryUI.FightersWindow.Equipped:GetChildren() do
                    if v:IsA("Frame") and v:FindFirstChild("ItemDisplay") and LocalPlayer.PlayerGui:FindFirstChild("Spawn") then
                        ReplicatedStorage.Remotes.SpawnFighter:InvokeServer(v.ItemDisplay.ItemName.Text)           
                    end
                end
            end
        end)
    end
end)

task.spawn(function()
    while wait(.5) do
        pcall(function()
            if farmboss and farm then
                repeat wait()
                    if not LocalPlayer.PlayerGui:FindFirstChild("Spawn") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = checkarena(farm).CFrame * CFrame.new(0, 0, -5)
                        ReplicatedStorage.Remotes.JoinLeaveArena:FireServer(checkfarm(farm), true)
                    end
                    task.wait(1)
                    for _, v in next, getarena():GetChildren() do
                        if v.Name == checkarenaboss() and v:FindFirstChild("HumanoidRootPart") and farmboss and LocalPlayer.PlayerGui:FindFirstChild("Spawn") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
                        end
                        if not v.Parent:FindFirstChild(checkarenaboss()) then
                            ReplicatedStorage.Remotes.JoinLeaveArena:FireServer(checkfarm(farm), false)  
                        end 
                    end 
                until farmboss == false
            end
        end)
    end
end)

task.spawn(function()
    while task.wait(1) do
        if block then
            ReplicatedStorage.Remotes.Melee:FireServer("Block", true)
        else
            ReplicatedStorage.Remotes.Melee:FireServer("Block", false)
        end
    end
end)