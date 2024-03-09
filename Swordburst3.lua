if getgenv().keysystem == true then
    local KeySystemUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/MaGiXxScripter0/keysystemv2api/master/ui/xrer_mstudio45.lua"))()
    KeySystemUI.New({
        ApplicationName = "FallAngelHub", -- Your Key System Application Name
        Name = "FallAngelHub", -- Your Script name
        Info = "Get Key For FallAngelHub", -- Info text in the GUI, keep empty for default text.
        DiscordInvite = "https://discord.gg/auzBFqDrwZ", -- Optional.
        AuthType = "clientid" -- Can select verifycation with ClientId or IP ("clientid" or "ip")
    })
    repeat task.wait() until KeySystemUI.Finished() or KeySystemUI.Closed
end

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Swordburst 3", HidePremium = false, SaveConfig = true, ConfigFolder = "Swordburst3", ShowIcon = true,})

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

local targetTab = Window:MakeTab({
	Name = "Target",
	Icon = "rbxassetid://13677855342",
	PremiumOnly = false
})

local webhookTab = Window:MakeTab({
	Name = "Webhook",
	Icon = "rbxassetid://14769727847",
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
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lplr = Players.LocalPlayer

local Stamina = require(ReplicatedStorage.Systems.Stamina)
local ItemList = require(ReplicatedStorage.Systems.Items.ItemList)

local mob
local floor
local insert
local crafting
local waystones
local webhookurl

local mobs = {}
local mines = {}
local bosses = {}
local quests = {}
local waystone = {}
local methods = {"above", "below", "behind"}
local floors = {"Floor1", "Floor2", "Floor3", "Town"}
local craftings = {"Enchanting", "Mounts", "Smithing"}
local category = {"Material", "Mount", "Cosmetic", "Pickaxe"}
local raritys = {"common (white)", "uncommon (green) and below", "rare (blue) and below", "epic (purple) and below", "legendary (orange) and below"}
local realrarity = {["common (white)"] = 1, ["uncommon (green) and below"] = 2, ["rare (blue) and below"] = 3, ["epic (purple) and below"] = 4, ["legendary (orange) and below"] = 5,}
local swordburst = {
    method = {Value = "behind"},
    choosemob = {Value = nil},
    automobs = {Value = false},
    boss = {Value = nil},
    autoboss = {Value = false},
    choosequest = {Value = nil},
    autoquest = {Value = false},
    mine = {Value = nil},
    automine = {Value = false},
    autocollect = {Value = false},
    aura = {Value = false},
    killauraplr = {Value = false},
    dist = {Value = 15},
    cds = {Value = 0.4},
    cd = {Value = 0.3},
    range = {Value = 40},
    rarity = {Value = nil},
    webhook = {Value = false},
    cdw = {Value = 5},
    targetplr = {Value = false},
    choosetarget = {Value = false},
    ignoreparty = {Value = false}
}
local spawnlocation = {
    ["Chill Bat"] = {CFrame = CFrame.new(-1673.8651123046875, 236.44541931152344, -1950.248046875)},
    ["Cold Mammoth"] = {CFrame = CFrame.new(-3169.08935546875, 234.57823181152344, 56.66799545288086)},
    ["Mist Bunny"] = {CFrame = CFrame.new(-223.70713806152344, 64.55667114257812, 2469.333251953125)},
    ["Frost Scorpion"] = {CFrame = CFrame.new(-138.11627197265625, 81.73929595947266, -1139.07861328125)},
    ["Penguin"] = {CFrame = CFrame.new(719.542236328125, 17.156511306762695, 474.27288818359375)},
    ["Polar Bear"] = {CFrame = CFrame.new(-2866.92529296875, 228.58213806152344, -515.750244140625)},
    ["Snow Kitsune"] = {CFrame = CFrame.new(-475.0198669433594, 84.20121002197266, -2415.970703125)},
    ["Ember Jaguar"] = {CFrame = CFrame.new(565.008544921875, 404.27178955078125, 43.87567138671875)},
    ["Fiery Moose"] = {CFrame = CFrame.new(-145.9317169189453, 386.11541748046875, -3065.82763671875)},
    ["Fire Imp"] = {CFrame = CFrame.new(22.740245819091797, -297.7325744628906, -3466.63818359375)},
    ["Fire Wasp"] = {CFrame = CFrame.new(-63.78221893310547, 333.5207214355469, 984.7338256835938)},
    ["Hell Hound"] = {CFrame = CFrame.new(-980.1229858398438, -331.5343322753906, -1971.0489501953125)},
    ["Lava Basilisk"] = {CFrame = CFrame.new(1413.092529296875, 405.06268310546875, -671.137939453125)},
    ["Magma Golem"] = {CFrame = CFrame.new(-1658.054443359375, 518.244384765625, -1454.707763671875)},
    ["Phoenix"] = {CFrame = CFrame.new(-1882.8916015625, 515.0499877929688, -1031.61083984375)},
    ["Skeleton Bear"] = {CFrame = CFrame.new(836.9502563476562, 402.3498840332031, -822.7938232421875)},
    ["Basilisk"] = {CFrame = CFrame.new(-862.26318359375, -77.29805755615234, 738.7144165039062)},
    ["Brown Bear"] = {CFrame = CFrame.new(798.4417724609375, 174.1746368408203, 1415.19677734375)},
    ["Crystal Boar"] = {CFrame = CFrame.new(-529.992431640625, 150.70542907714844, 783.7307739257812)},
    ["Razor Boar"] = {CFrame = CFrame.new(897.904296875, 131.67388916015625, -947.9832153320312)},
    ["Rock Golem"] = {CFrame = CFrame.new(279.1563720703125, 207.06259155273438, 1357.7916259765625)},
    ["Soldier Boar"] = {CFrame = CFrame.new(-1760.115234375, -43.43751907348633, 1748.4549560546875)},
    ["Thunder Sakura Moose"] = {CFrame = CFrame.new(-488.3043212890625, 210.30789184570312, -119.70502471923828)},
    ["Tortoise"] = {CFrame = CFrame.new(1446.4488525390625, 127.01861572265625, -370.18182373046875)},
    ["Wolf"] = {CFrame = CFrame.new(863.54443359375, 131.0957489013672, 40.45374298095703)},
    ["Ice Wraith"] = {CFrame = CFrame.new(-22720.41796875, 2971.15771484375, 1777.969482421875)},
    ["Icewhal"] = {CFrame = CFrame.new(-24482.04296875, 2986.56396484375, 38.78126907348633)},
}


local function getchar()
    return lplr.Character or lplr.CharacterAdded:Wait()
end

local function getallplr()
    local e = {}
    for i,v in next, Players:GetPlayers() do
        if v ~= lplr then
            table.insert(e, v.Name)
        end
    end
    return e
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
	Default = swordburst["method"].Value,
	Options = methods,
    Save = true,
    Flag = "method",
})

mainTab:AddSlider({
	Name = "Auto Farm Distance",
	Min = 1,
	Max = 50,
	Default = swordburst["dist"].Value,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "distance",
    Save = true,
    Flag = "dist",
})

mainTab:AddDropdown({
	Name = "Select Mobs",
	Default = swordburst["choosemob"].Value,
	Options = mobs,
    Save = true,
    Flag = "choosemob",
})

mainTab:AddToggle({
	Name = "Auto Farm Mobs",
	Default = swordburst["automobs"].Value,
    Save = true,
    Flag = "automobs",   
})

mainTab:AddDropdown({
	Name = "Select Boss",
	Default = swordburst["boss"].Value,
	Options = bosses,
    Save = true,
    Flag = "boss",
})

mainTab:AddParagraph("Auto Farm Boss","when boss havent spawn will farm selected mob")
mainTab:AddToggle({
	Name = "Auto Farm Boss",
	Default = swordburst["autoboss"].Value,
    Save = true,
    Flag = "autoboss", 
})

local Section2 = mainTab:AddSection({
	Name = "Auto Quest"
})

mainTab:AddDropdown({
	Name = "Select Quest",
	Default = swordburst["choosequest"].Value,
	Options = quests,
    Save = true,
    Flag = "choosequest",
})

mainTab:AddToggle({
	Name = "Auto Quest",
	Default = swordburst["autoquest"].Value,
    Save = true,
    Flag = "autoquest",   
})

local Section3 = mainTab:AddSection({
	Name = "Auto Mine Ores"
})

mainTab:AddSlider({
	Name = "Mine Ores Cooldown",
	Min = 0.25,
	Max = 1,
	Default = swordburst["cds"].Value,
	Color = Color3.fromRGB(255,255,255),
	Increment = 0.01,
	ValueName = "Cooldown",
    Save = true,
    Flag = "cds",
})

mainTab:AddDropdown({
	Name = "Select Ores",
	Default = swordburst["mine"].Value,
	Options = mines,
    Save = true,
    Flag = "mine",
})

mainTab:AddToggle({
	Name = "Auto Mine Ores",
	Default = swordburst["automine"].Value,
    Save = true,
    Flag = "automine",
})

local Section1 = mainTab:AddSection({
	Name = "Auto Collect"
})

mainTab:AddToggle({
	Name = "Auto Collect",
	Default = swordburst["autocollect"].Value,
    Save = true,
    Flag = "autocollect",  
})

killauraTab:AddParagraph("Kill Aura Cooldown","Higher up cooldown if does no damage")
killauraTab:AddSlider({
	Name = "Kill Aura Cooldown",
	Min = 0.25,
	Max = 1,
	Default = swordburst["cd"].Value,
	Color = Color3.fromRGB(255,255,255),
	Increment = 0.01,
	ValueName = "Cooldown",
    Save = true,
    Flag = "cd",
})

killauraTab:AddSlider({
	Name = "Kill Aura Range",
	Min = 1,
	Max = 100,
	Default = swordburst["range"].Value,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Range",
    Save = true,
    Flag = "range",
})

killauraTab:AddToggle({
	Name = "Kill Aura",
	Default = swordburst["aura"].Value,
    Save = true,
    Flag = "aura",
})

killauraTab:AddParagraph("Kill aura for Players","Enable PvP to dmg ppl")
killauraTab:AddToggle({
	Name = "Kill Aura for Players",
	Default = swordburst["killauraplr"].Value,
    Save = true,
    Flag = "killauraplr",  
})

killauraTab:AddToggle({
	Name = "Ignore Party Members",
	Default = swordburst["ignoreparty"].Value,
    Save = true,
    Flag = "ignoreparty",
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

teleportTab:AddDropdown({
	Name = "Select Crafting Stations",
	Default = nil,
	Options = craftings,
	Callback = function(Value)
		crafting = Value
	end    
})

teleportTab:AddButton({
	Name = "Teleport Crafting Stations",
	Callback = function()
        if crafting and getchar() and getchar():FindFirstChild("HumanoidRootPart") then
            for i,v in next, workspace.CraftingStations:GetChildren() do
                if v.Name == crafting then
                    getchar().HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0,0,5)
                    return
                end
            end
        end
  	end    
})

teleportTab:AddDropdown({
	Name = "Select Floor",
	Default = nil,
	Options = floors,
	Callback = function(Value)
		floor = Value
	end    
})

teleportTab:AddButton({
	Name = "Teleport to Selected Floor",
	Callback = function()
        if floor then
            ReplicatedStorage.Systems.Teleport.Teleport:FireServer(floor)
        end
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

miscTab:AddButton({
	Name = "Infinite Stamina",
	Callback = function()
        debug.setupvalue(Stamina.SetMaxStamina,1,99999999)
        debug.setupvalue(Stamina.CanUseStamina,1, 99999999)
  	end    
})

miscTab:AddButton({
	Name = "Claim All Chest",
	Callback = function()
        for i,v in next, workspace:GetChildren() do
            if v.Name == "Chest" and v:FindFirstChild("RootPart") and v:FindFirstChild("RootPart"):FindFirstChild("ProximityPrompt") and getchar() and getchar():FindFirstChild("HumanoidRootPart") then
                getchar():FindFirstChild("HumanoidRootPart").CFrame = v:FindFirstChild("RootPart").CFrame * CFrame.new(0,2,0)
                repeat task.wait(.1) game:GetService('VirtualInputManager'):SendKeyEvent(true, "E", false, game) until v:FindFirstChild("RootPart"):FindFirstChild("ProximityPrompt") == nil
            end
        end
  	end    
})

miscTab:AddButton({
	Name = "Server Hop",
	Callback = function()
        local PlaceID = game.PlaceId
        local AllIDs = {}
        local foundAnything = ""
        local actualHour = os.date("!*t").hour
        local Deleted = false
        local File = pcall(function()
            AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
        end)
        if not File then
            table.insert(AllIDs, actualHour)
            writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
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
                        wait()
                        pcall(function()
                            writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                            wait()
                            game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                        end)
                    end
                end
            end
        end
        local function Teleport()
            while wait() do
                pcall(function()
                    TPReturner()
                    if foundAnything ~= "" then
                        TPReturner()
                    end
                end)
            end
        end
        Teleport()
  	end    
})

miscTab:AddDropdown({
	Name = "Select Rarity",
	Default = swordburst["rarity"].Value,
	Options = raritys,
    Save = true,
    Flag = "rarity",
})

miscTab:AddButton({
	Name = "Dismantle Selected rarity",
	Callback = function()
        if OrionLib.Flags["rarity"].Value then
            for i,v in next, ItemList do
                if v.Rarity and v.Rarity <= realrarity[OrionLib.Flags["rarity"].Value] and not table.find(category, v.Category) then
                    for _,items in next, ReplicatedStorage.Profiles[lplr.Name].Inventory:GetChildren() do
                        if string.find(i, items.Name) then
                            ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Crafting"):WaitForChild("Dismantle"):FireServer(items)
                            task.wait(.1)
                        end
                    end
                end
            end
        end
  	end    
})

miscTab:AddToggle{
    Name = "Auto Rejoin When Disconnected",
    StartingState = false,
    Save = true,
    Flag = "autorejoin",
}

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

webhookTab:AddSlider({
	Name = "Webhook Cooldown",
	Min = 1,
	Max = 60,
	Default = swordburst["cdw"].Value,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Minutes",
    Save = true,
    Flag = "cdw",
})

webhookTab:AddTextbox({
	Name = "Webhook Url",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		webhookurl = Value
	end	  
})

webhookTab:AddToggle({
	Name = "Webhook",
	Default = swordburst["webhook"].Value,
	Save = true,
    Flag = "webhook",
})

local targetdropdown = targetTab:AddDropdown({
	Name = "Select Target",
	Default = swordburst["choosetarget"].Value,
	Options = getallplr(),
    Save = true,
    Flag = "choosetarget",
})

targetTab:AddButton({
	Name = "Refrash target dropdown",
	Callback = function()
        targetdropdown:Refresh(getallplr(),true)
  	end    
})

targetTab:AddToggle({
	Name = "Tp to Selected Players",
	Default = swordburst["targetplr"].Value,
    Save = true,
    Flag = "targetplr",
})

local function methodss()
    if OrionLib.Flags["dist"].Value then
        if OrionLib.Flags["method"].Value == "above" then
            return CFrame.new(0, OrionLib.Flags["dist"].Value, 0)
        elseif OrionLib.Flags["method"].Value == "below" then
            return CFrame.new(0, -OrionLib.Flags["dist"].Value,0)
        elseif OrionLib.Flags["method"].Value == "behind" then
            return CFrame.new(0,0, OrionLib.Flags["dist"].Value)
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
            if magnitude <= OrionLib.Flags["range"].Value then
                table.insert(multitarget, v)
            end
        end
    end
    return target , multitarget
end

local function getplr(player) 
    local distance = math.huge
    local target
    local multitarget = {}
    local function getpartymember()
        local e = {}
        for i,v in next, lplr.PlayerGui.Party.Frame.Members:GetChildren() do
            if v.Name == "Template" and v:FindFirstChild("Username") then
                table.insert(e, v:FindFirstChild("Username").Text)
            end
        end
        return e
    end
    for i,v in next, Players:GetPlayers() do
        if v ~= lplr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and getchar() and getchar():FindFirstChild("HumanoidRootPart") then
            if OrionLib.Flags["ignoreparty"].Value and table.find(getpartymember(), v.DisplayName) then
                continue
            end
            local magnitude = (getchar().HumanoidRootPart.Position - v.Character:FindFirstChild("HumanoidRootPart").Position).magnitude
            if player and string.find(v.Name, player) and v.Character:FindFirstChild("Healthbar") then
                if magnitude < distance then
                    target = v.Character
                    distance = magnitude
                end
            end
            if magnitude <= OrionLib.Flags["range"].Value  then
                table.insert(multitarget, v.Character)
            end
        end
    end
    return target, multitarget
end

local function getores()
    local distance = math.huge
    local target
    for i,v in next, workspace.Ores:GetChildren() do
        if v.Name == OrionLib.Flags["mine"].Value and getchar() and getchar():FindFirstChild("HumanoidRootPart") and v:FindFirstChildWhichIsA("MeshPart").CFrame then
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

local function minutes(cd)
    return cd * 60
end

task.spawn(function()
    while task.wait() do
        if OrionLib.Flags["automobs"].Value and OrionLib.Flags["choosemob"].Value or mob and OrionLib.Flags["choosemob"].Value then
            local enemy = getclosestmobs(OrionLib.Flags["choosemob"].Value)
            if getchar() and getchar():FindFirstChild("HumanoidRootPart") then
                if enemy and enemy:FindFirstChild("HumanoidRootPart") then
                    getchar().HumanoidRootPart.CFrame = enemy:FindFirstChild("HumanoidRootPart").CFrame * methodss()
                else                       
                    getchar().HumanoidRootPart.CFrame = spawnlocation[OrionLib.Flags["choosemob"].Value].CFrame * CFrame.new(0,-8,0)
                end
            end
        end 
        if OrionLib.Flags["targetplr"].Value and OrionLib.Flags["choosetarget"].Value then
            local enemy = getplr(OrionLib.Flags["choosetarget"].Value)
            if getchar() and getchar():FindFirstChild("HumanoidRootPart") and enemy and enemy:FindFirstChild("HumanoidRootPart") then
                getchar().HumanoidRootPart.CFrame = enemy:FindFirstChild("HumanoidRootPart").CFrame * methodss()
            end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if OrionLib.Flags["autoboss"].Value then
            if getchar() and getchar():FindFirstChild("HumanoidRootPart") and OrionLib.Flags["boss"].Value then
                local enemy = getclosestmobs(OrionLib.Flags["boss"].Value)
                if enemy and enemy:FindFirstChild("HumanoidRootPart") then
                    mob = false
                    getchar().HumanoidRootPart.CFrame = enemy:FindFirstChild("HumanoidRootPart").CFrame * methodss()
                else
                    local times
                    for i,v in next, workspace.BossArenas:GetChildren() do
                        if string.find(v.Name, OrionLib.Flags["boss"].Value) then
                            if string.find(v.Spawn.ArenaBillboard.Frame.StatusLabel.Text, "Boss Cooldown") then
                                times = 0
                            elseif string.find(v.Spawn.ArenaBillboard.Frame.StatusLabel.Text, "Spawning Boss") then
                                times = 15
                            end
                            local e = string.sub(v.Spawn.ArenaBillboard.Frame.StatusLabel.Text,16,19)
                            local spawntime = string.split(e, ")")[1]
                            if tonumber(spawntime) and tonumber(spawntime) <= times then
                                mob = false
                                getchar().HumanoidRootPart.CFrame = v:FindFirstChild("Spawn").CFrame
                            else
                                mob = true
                            end
                        end
                    end
                end
            end
        else
            mob = false
        end 
    end
end)

task.spawn(function()
    while task.wait(OrionLib.Flags["cd"].Value) do
        local totalenemy = {}
        local enemy,multienemy = getclosestmobs()
        local e,m = getplr()
        if OrionLib.Flags["aura"].Value and #multienemy >= 1 then
            for i,v in next, multienemy do
                table.insert(totalenemy, v)
            end
        end
        if OrionLib.Flags["killauraplr"].Value and #m >= 1 then
            for i,v in next, m do
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
                local enemy,multienemy = getclosestmobs()
                local e,m = getplr()
                if OrionLib.Flags["aura"].Value and #multienemy >= 1 then
                    for i,v in next, multienemy do
                        table.insert(totalenemy, v)
                    end
                end
                if OrionLib.Flags["killauraplr"].Value and #m >= 1 then
                    for i,v in next, m do
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
        if OrionLib.Flags["autocollect"].Value then
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
        if OrionLib.Flags["autoquest"].Value and OrionLib.Flags["choosequest"].Value then
            ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Quests"):WaitForChild("AcceptQuest"):FireServer(getquest(OrionLib.Flags["choosequest"].Value))
            ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Quests"):WaitForChild("CompleteQuest"):FireServer(getquest(OrionLib.Flags["choosequest"].Value))
        end
    end
end)

task.spawn(function()
    while task.wait(OrionLib.Flags["cds"].Value) do
        if OrionLib.Flags["automine"].Value and OrionLib.Flags["mine"].Value then
            if getores() and getores():FindFirstChildWhichIsA("MeshPart") and getchar() and getchar():FindFirstChild("HumanoidRootPart") then
                getchar():FindFirstChild("HumanoidRootPart").CFrame =  getores():FindFirstChildWhichIsA("MeshPart").CFrame * CFrame.new(0,3,0)
                ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Equipment"):WaitForChild("EquipTool"):FireServer("Pickaxe", true) 
                ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Mining"):WaitForChild("Mine"):FireServer()
            end
        end
    end
end)

task.spawn(function()
    while task.wait(minutes(OrionLib.Flags["cdw"].Value)) do
        if OrionLib.Flags["webhook"].Value and webhookurl then
            local level = lplr.PlayerGui.MainHUD.Frame.Bars.LevelShadow.LevelLabel.Text
            local xp = lplr.PlayerGui.MainHUD.Frame.XPFrame.XPCount.Text
            local Vel = lplr.PlayerGui.Inventory.Frame.Currency.Vel.TextLabel.Text
            local data = {
                ["embeds"] = {
                    {
                        ["title"] = "**SwordBurst 3**",
                        ["description"] = "Username: " .. lplr.Name.."\n Level: " .. level .. "\n XP: " .. xp .. "\n Vel: " .. Vel,
                        ["type"] = "rich",
                        ["color"] = tonumber(0x7269da),
                    }
                }
            }
            local newdata = game:GetService("HttpService"):JSONEncode(data)
            local headers = {["content-type"] = "application/json"}
            request = http_request or request or HttpPost or syn.request
            local abcdef = {Url = webhookurl, Body = newdata, Method = "POST", Headers = headers}
            request(abcdef)
        end
    end
end)

task.spawn(function()
    GuiService.ErrorMessageChanged:Connect(function()
        if #Players:GetPlayers() <= 1 then
            Players.LocalPlayer:Kick("\nRejoining...")
            task.wait()
            TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
        end
        queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Swordburst3.lua", true))()]])
    end)
end)

OrionLib:Init()
