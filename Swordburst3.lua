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

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Swordburst 3",
    SubTitle = "by fallen_del",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    mainTab = Window:AddTab({ Title = "Main", Icon = "scroll"}),
    killauraTab = Window:AddTab({ Title = "Kill Aura", Icon = "swords"}),
    miscTab = Window:AddTab({ Title = "Misc", Icon = "layout-grid"}),
    targetTab = Window:AddTab({ Title = "Target", Icon = "target"}),
    teleportTab = Window:AddTab({ Title = "Teleport", Icon = "user-cog"}),
    upgradeTab = Window:AddTab({ Title = "Upgrade", Icon = "hammer" }),
    webhookTab = Window:AddTab({ Title = "Webhook", Icon = "bell"}),
    creditTab = Window:AddTab({ Title = "Information", Icon = "users"}),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings"})
}

local Options = Fluent.Options

local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService('VirtualInputManager')
local lplr = Players.LocalPlayer

local Stamina = require(ReplicatedStorage.Systems.Stamina)
local Quest = require(ReplicatedStorage.Systems.Quests.QuestList)
local ItemList = require(ReplicatedStorage.Systems.Items.ItemList)


local mob
local floor
local insert
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
    ignoreparty = {Value = false},
    autorejoin = {Value = false},
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

local function webhook(url)
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
    local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    request(abcdef)
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

for i,v in next, lplr.PlayerGui.Upgrade.Frame.List:GetChildren() do
    if v.Name == "ItemTemplate" then
        v:Destroy()
    end
end

for i,v in next, lplr.PlayerGui.Mounts.Frame.Mounts.MountList.Items:GetChildren() do
    if v.Name == "ItemTemplate" then
        v:Destroy()
    end
end

for i,v in next, lplr.PlayerGui.Enchant.Frame.List:GetChildren() do
    if v.Name == "ItemTemplate" then
        v:Destroy()
    end
end

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

Tabs.mainTab:AddDropdown("method", {
    Title = "Select Auto farm method",
    Values = methods,
    Multi = false,
    Default = swordburst["method"].Value,
})

Tabs.mainTab:AddSlider("dist", {
    Title = "Auto Farm Distance",
    Description = "",
    Default = swordburst["dist"].Value,
    Min = 1,
    Max = 50,
    Rounding = 1,
})

Tabs.mainTab:AddDropdown("choosemob", {
    Title = "Select Mobs",
    Values = mobs,
    Multi = false,
    Default = swordburst["choosemob"].Value,
})

Tabs.mainTab:AddToggle("automobs", {Title = "Auto Farm Mobs", Default = swordburst["automobs"].Value})


Tabs.mainTab:AddDropdown("boss", {
    Title = "Select Boss",
    Values = bosses,
    Multi = false,
    Default = swordburst["boss"].Value,
})

Tabs.mainTab:AddParagraph({
    Title = "Auto Farm Boss",
    Content = "When boss havent spawn will farm selected mob"
})

Tabs.mainTab:AddToggle("autoboss", {Title = "Auto farm Boss", Default = swordburst["autoboss"].Value})

Tabs.mainTab:AddDropdown("choosequest", {
    Title = "Select Quest",
    Values = quests,
    Multi = false,
    Default = swordburst["choosequest"].Value,
})

Tabs.mainTab:AddToggle("autoquest", {Title = "Auto Quest", Default = swordburst["autoquest"].Value})

Tabs.mainTab:AddSlider("cds", {
    Title = "Mine Ores Cooldown",
    Description = "",
    Default = swordburst["cds"].Value,
    Min = 0.3,
    Max = 1,
    Rounding = 1,
})

Tabs.mainTab:AddDropdown("mine", {
    Title = "Select Ores",
    Values = mines,
    Multi = false,
    Default = swordburst["mine"].Value,
})

Tabs.mainTab:AddToggle("automine", {Title = "Auto Mine Ores", Default = swordburst["automine"].Value})

Tabs.mainTab:AddToggle("autocollect", {Title = "Auto Collect", Default = swordburst["autocollect"].Value})

Tabs.killauraTab:AddParagraph({
    Title = "Kill Aura Cooldown",
    Content = "Higher up cooldown if does no damage"
})
Tabs.killauraTab:AddSlider("cd", {
    Title = "Kill Aura Cooldown",
    Description = "",
    Default = swordburst["cd"].Value,
    Min = 0.25,
    Max = 1,
    Rounding = 1,
})

Tabs.killauraTab:AddSlider("range", {
    Title = "Kill Aura Range",
    Description = "",
    Default = swordburst["range"].Value,
    Min = 1,
    Max = 100,
    Rounding = 1,
})

Tabs.killauraTab:AddToggle("aura", {Title = "Kill Aura", Default = swordburst["aura"].Value})

Tabs.killauraTab:AddParagraph({
    Title = "Kill aura for Players",
    Content = "Enable PvP to dmg ppl"
})
Tabs.killauraTab:AddToggle("killauraplr", {Title = "Kill Aura for Players", Default = swordburst["killauraplr"].Value})

Tabs.killauraTab:AddToggle("ignoreparty", {Title = "Ignore Party Members", Default = swordburst["ignoreparty"].Value})

local waystonedropdown = Tabs.teleportTab:AddDropdown("", {
    Title = "Select Waystones",
    Values = waystone,
    Multi = false,
    Default = nil,
})
waystonedropdown:OnChanged(function(Value)
    waystones = Value
end)

Tabs.teleportTab:AddButton({
	Title = "Teleport Waystones",
    Description = "",
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

local floordropdown = Tabs.teleportTab:AddDropdown("", {
    Title = "Select Floor",
    Values = floors,
    Multi = false,
    Default = nil,
})
floordropdown:OnChanged(function(Value)
    floor = Value
end)

Tabs.teleportTab:AddButton({
	Title = "Teleport to Selected Floor",
    Description = "",
	Callback = function()
        if floor then
            ReplicatedStorage.Systems.Teleport.Teleport:FireServer(floor)
        end
  	end    
})

local reduceToggle = Tabs.miscTab:AddToggle("reducelag", {Title = "Reduce Lag", Default = false})
reduceToggle:OnChanged(function()
    if Options["reducelag"].Value == true then
        RunService:Set3dRenderingEnabled(false)
    else
        RunService:Set3dRenderingEnabled(true)
    end
end)  

Tabs.miscTab:AddButton({
	Title = "Infinite Stamina",
    Description = "",
	Callback = function()
        debug.setupvalue(Stamina.SetMaxStamina,1,99999999)
        debug.setupvalue(Stamina.CanUseStamina,1,99999999)
  	end    
})

Tabs.miscTab:AddButton({
	Title = "Claim All Chest",
    Description = "",
	Callback = function()
        for i,v in next, workspace:GetChildren() do
            if v.Name == "Chest" and v:FindFirstChild("RootPart") and v:FindFirstChild("RootPart"):FindFirstChild("ProximityPrompt") and getchar() and getchar():FindFirstChild("HumanoidRootPart") then
                getchar():FindFirstChild("HumanoidRootPart").CFrame = v:FindFirstChild("RootPart").CFrame * CFrame.new(0,2,0)
                repeat task.wait(.1) VirtualInputManager:SendKeyEvent(true, "E", false, game) until v:FindFirstChild("RootPart"):FindFirstChild("ProximityPrompt") == nil
            end
        end
  	end    
})

Tabs.miscTab:AddButton({
	Title = "Server Hop",
    Description = "",
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

Tabs.miscTab:AddDropdown("rarity", {
    Title = "Select Rarity",
    Values = raritys,
    Multi = false,
    Default = swordburst["rarity"].Value,
})

Tabs.miscTab:AddButton({
	Title = "Dismantle Selected rarity",
    Description = "",
	Callback = function()
        if Options["rarity"].Value then
            for i,v in next, ItemList do
                if v.Rarity and v.Rarity <= realrarity[Options["rarity"].Value] and not table.find(category, v.Category) then
                    for _,items in next, ReplicatedStorage.Profiles[lplr.Name].Inventory:GetChildren() do
                        if string.find(i, items.Name) then
                            ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Crafting"):WaitForChild("Dismantle"):FireServer(items)
                            task.wait(.5)
                        end
                    end
                end
            end
        end
  	end    
})

Tabs.miscTab:AddToggle("autorejoin", {Title = "Auto Rejoin When Disconnected", Default = swordburst["autorejoin"].Value})

Tabs.creditTab:AddParagraph({
    Title = "Scripts Made by fallen_del",
    Content = ""
})
Tabs.creditTab:AddParagraph({
    Title = "UI Library by dawid",
    Content = ""
})
Tabs.creditTab:AddButton({
	Title = "Discord Server",
    Description = "",
	Callback = function()
        setclipboard("https://discord.gg/auzBFqDrwZ")
  	end    
})

Tabs.webhookTab:AddSlider("cdw", {
    Title = "Webhook Cooldown (Minutes)",
    Description = "",
    Default = swordburst["cdw"].Value,
    Min = 1,
    Max = 60,
    Rounding = 1,
})

Tabs.webhookTab:AddInput("Input", {
    Title = "Webhook Url",
    Default = "",
    Placeholder = "Ur webhook url",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        webhookurl = Value
    end
})

Tabs.webhookTab:AddButton({
	Title = "Test Webhook",
    Description = "",
	Callback = function()
        if webhookurl then
            webhook(webhookurl)
        end
  	end    
})

Tabs.webhookTab:AddToggle("webhook", {Title = "Webhook", Default = swordburst["webhook"].Value})

Tabs.targetTab:AddDropdown("choosetarget", {
    Title = "Select Target",
    Values = getallplr(),
    Multi = false,
    Default = swordburst["choosetarget"].Value,
})

Tabs.targetTab:AddToggle("targetplr", {Title = "Tp to Selected Players", Default = swordburst["targetplr"].Value})

Tabs.upgradeTab:AddButton({
	Title = "Open Upgrade Gui",
    Description = "",
	Callback = function()
        if lplr.PlayerGui.Upgrade.Frame.List:FindFirstChild("ItemTemplate") then
            lplr.PlayerGui.Upgrade.Enabled = true
            lplr.PlayerGui.Upgrade.Frame.Visible = true
        else
            repeat task.wait() 
                getchar().HumanoidRootPart.CFrame = workspace.CraftingStations.Smithing.CFrame
                VirtualInputManager:SendKeyEvent(true, "E", false, game) 
            until lplr.PlayerGui.Upgrade.Frame.List:FindFirstChild("ItemTemplate")
        end
  	end    
})

Tabs.upgradeTab:AddButton({
	Title = "Open Mount Gui",
    Description = "",
	Callback = function()
        if lplr.PlayerGui.Mounts.Frame.Mounts.MountList.Items:FindFirstChild("ItemTemplate") then
            lplr.PlayerGui.Mounts.Enabled = true
            lplr.PlayerGui.Mounts.Frame.Visible = true
        else
            repeat task.wait() 
                getchar().HumanoidRootPart.CFrame = workspace.CraftingStations.Mounts.CFrame
                VirtualInputManager:SendKeyEvent(true, "E", false, game) 
            until lplr.PlayerGui.Mounts.Frame.Mounts.MountList.Items:FindFirstChild("ItemTemplate")
        end
  	end    
})

Tabs.upgradeTab:AddButton({
	Title = "Open Enchant Gui",
    Description = "",
	Callback = function()
        if lplr.PlayerGui.Enchant.Frame.List:FindFirstChild("ItemTemplate")then
            lplr.PlayerGui.Enchant.Enabled = true
            lplr.PlayerGui.Enchant.Frame.Visible = true
        else
            repeat task.wait() 
                getchar().HumanoidRootPart.CFrame = workspace.CraftingStations.Enchanting.CFrame
                VirtualInputManager:SendKeyEvent(true, "E", false, game) 
            until lplr.PlayerGui.Enchant.Frame.List:FindFirstChild("ItemTemplate")
        end   
  	end    
})

local function methodss()
    if Options["dist"].Value then
        if Options["method"].Value == "above" then
            return CFrame.new(0, Options["dist"].Value, 0)
        elseif Options["method"].Value == "below" then
            return CFrame.new(0, -Options["dist"].Value,0)
        elseif Options["method"].Value == "behind" then
            return CFrame.new(0,0, Options["dist"].Value)
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
            if magnitude <= tonumber(Options["range"].Value) then
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
            if Options["ignoreparty"].Value and table.find(getpartymember(), v.DisplayName) then
                continue
            end
            local magnitude = (getchar().HumanoidRootPart.Position - v.Character:FindFirstChild("HumanoidRootPart").Position).magnitude
            if player and string.find(v.Name, player) and v.Character:FindFirstChild("Healthbar") then
                if magnitude < distance then
                    target = v.Character
                    distance = magnitude
                end
            end
            if magnitude <= tonumber(Options["range"].Value) then
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
        if v.Name == Options["mine"].Value and getchar() and getchar():FindFirstChild("HumanoidRootPart") and v:FindFirstChildWhichIsA("MeshPart").CFrame then
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
        if Options["automobs"].Value and Options["choosemob"].Value or mob and Options["choosemob"].Value then
            local enemy = getclosestmobs(Options["choosemob"].Value)
            if getchar() and getchar():FindFirstChild("HumanoidRootPart") then
                if enemy and enemy:FindFirstChild("HumanoidRootPart") then
                    getchar().HumanoidRootPart.CFrame = enemy:FindFirstChild("HumanoidRootPart").CFrame * methodss()
                else                       
                    getchar().HumanoidRootPart.CFrame = spawnlocation[Options["choosemob"].Value].CFrame * CFrame.new(0,-8,0)
                end
            end
        end 
        if Options["targetplr"].Value and Options["choosetarget"].Value then
            local enemy = getplr(Options["choosetarget"].Value)
            if getchar() and getchar():FindFirstChild("HumanoidRootPart") and enemy and enemy:FindFirstChild("HumanoidRootPart") then
                getchar().HumanoidRootPart.CFrame = enemy:FindFirstChild("HumanoidRootPart").CFrame * methodss()
            end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Options["autoboss"].Value then
            if getchar() and getchar():FindFirstChild("HumanoidRootPart") and Options["boss"].Value then
                local enemy = getclosestmobs(Options["boss"].Value)
                if enemy and enemy:FindFirstChild("HumanoidRootPart") then
                    mob = false
                    getchar().HumanoidRootPart.CFrame = enemy:FindFirstChild("HumanoidRootPart").CFrame * methodss()
                else
                    local times
                    for i,v in next, workspace.BossArenas:GetChildren() do
                        if string.find(v.Name, Options["boss"].Value) then
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
    while task.wait(Options["cd"].Value) do
        local totalenemy = {}
        local enemy,multienemy = getclosestmobs()
        local e,m = getplr()
        if Options["aura"].Value and #multienemy >= 1 then
            for i,v in next, multienemy do
                table.insert(totalenemy, v)
            end
        end
        if Options["killauraplr"].Value and #m >= 1 then
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
                if Options["aura"].Value and #multienemy >= 1 then
                    for i,v in next, multienemy do
                        table.insert(totalenemy, v)
                    end
                end
                if Options["killauraplr"].Value and #m >= 1 then
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
        if Options["autocollect"].Value then
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
        if Options["autoquest"].Value and Options["choosequest"].Value then
            ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Quests"):WaitForChild("AcceptQuest"):FireServer(getquest(Options["choosequest"].Value))
            ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Quests"):WaitForChild("CompleteQuest"):FireServer(getquest(Options["choosequest"].Value))
        end
    end
end)

task.spawn(function()
    while task.wait(Options["cds"].Value) do
        if Options["automine"].Value and Options["mine"].Value then
            if getores() and getores():FindFirstChildWhichIsA("MeshPart") and getchar() and getchar():FindFirstChild("HumanoidRootPart") then
                getchar():FindFirstChild("HumanoidRootPart").CFrame =  getores():FindFirstChildWhichIsA("MeshPart").CFrame * CFrame.new(0,3,0)
                ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Equipment"):WaitForChild("EquipTool"):FireServer("Pickaxe", true) 
                ReplicatedStorage:WaitForChild("Systems"):WaitForChild("Mining"):WaitForChild("Mine"):FireServer()
            end
        end
    end
end)

task.spawn(function()
    while task.wait(minutes(Options["cdw"].Value)) do
        if Options["webhook"].Value and webhookurl then
            webhook(webhookurl)
        end
    end
end)

task.spawn(function()
    GuiService.ErrorMessageChanged:Connect(function()
        if Options["autorejoin"].Value then
            if #Players:GetPlayers() <= 1 then
                Players.LocalPlayer:Kick("\nRejoining...")
                task.wait()
                TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
            else
                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
            end
            queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Swordburst3.lua", true))()]])
        end
    end)
end)

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FallAngelHub")
SaveManager:SetFolder("FallAngelHub/Swordburst3")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)
Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})
SaveManager:LoadAutoloadConfig()
