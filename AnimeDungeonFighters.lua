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
    Title = "Anime Dungeon Fighters",
    SubTitle = "by fallen_del",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    mainTab = Window:AddTab({ Title = "Main", Icon = "scroll"}),
    miscTab = Window:AddTab({ Title = "Misc", Icon = "layout-grid"}),
    dungeonTab = Window:AddTab({ Title = "Dungeon", Icon = "shield" }),
    summonTab = Window:AddTab({ Title = "Summon", Icon = "shuffle"}),
    teleportTab = Window:AddTab({ Title = "Teleport", Icon = "user-cog"}),
    creditTab = Window:AddTab({ Title = "Information", Icon = "users"}),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings"})
}

local Options = Fluent.Options

local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService('VirtualInputManager')
local lplr = Players.LocalPlayer

local egg = {}
local skills = {}
local prices = {}
local map = {"Defense Mode"}
local mapdiff = {"Easy" , "Normal", "Hard", "Hell"}
local world = {"Lvl.0","Lvl.40","Lvl.60","Lvl.160"}
local statss = {"Health", "Defense", "Attack", "Critical"}
local fuseit = {"Hat","Back","Weapon","Shoe","Ring","Necklace"}
local raritys = {"white","blue and below","purple and below","yellow and below","radical red and below","rainbow and below","dark violet and below"}
local realrarity = {["white"] = 1, ["blue and below"] = 2, ["purple and below"] = 3, ["yellow and below"] = 4, ["radical red and below"] = 5, ["rainbow and below"] = 6, ["dark violet and below"] = 7,}

local GetDungeonCfg = debug.getupvalues(require(game:GetService("ReplicatedStorage").Tool.CfgFind).GetDungeonCfg)[1]
local FindEggCfgById = debug.getupvalues(require(game:GetService("ReplicatedStorage").Tool.CfgFind).FindEggCfgById)[1]

for i,v in next, GetDungeonCfg do
    table.insert(map, GetDungeonCfg[i].ZhName .. " Level : " .. GetDungeonCfg[i].UnlockLv .. " World " .. GetDungeonCfg[i].world)
end

for i,v in next, FindEggCfgById do
    table.insert(prices, FindEggCfgById[i].ZhName .. " Price : " .. FindEggCfgById[i].Price)
end

local function getchar()
    return lplr.Character or lplr.CharacterAdded:Wait()
end

local function getskillid(skillname)
    local skillid
    for i,v in next, lplr.PlayerGui.ScreenGui["\230\138\128\232\131\189"].Frame.PanelFolder:GetChildren() do
        if v:FindFirstChild("\229\183\178\232\163\133\229\164\135\230\138\128\232\131\189") then
            for i2,v2 in next, v:FindFirstChild("\229\183\178\232\163\133\229\164\135\230\138\128\232\131\189"):GetChildren() do
                if v2:FindFirstChild("onlyKey") and v2:FindFirstChild("Frame"):FindFirstChild("SkillName") and v2.Frame.SkillName.Text == skillname then
                    skillid = v2.onlyKey.Value
                    return skillid
                end
            end
        end
    end
end

local function getdungeon(dungeonname)
    if dungeonname == "Defense Mode" then
       return "\229\161\148\233\152\178\230\168\161\229\188\143"
    end
    for dungeon,v in next, GetDungeonCfg do
        if dungeonname and string.find(dungeonname, GetDungeonCfg[dungeon].ZhName) then
            local e = string.split(dungeonname, ": ")[2]
            local UnlockLevel = string.split(e, " ")[1]
            if tonumber(UnlockLevel) == GetDungeonCfg[dungeon].UnlockLv then
                return GetDungeonCfg[dungeon].mapTag, GetDungeonCfg[dungeon].hardlv
            end
        end
    end
end

local function getstat(e)
    if e == "Health" then
        return "3"
    elseif e == "Attack" then
        return "1"
    elseif e == "Defense" then
        return "2"
    elseif e == "Critical" then
        return "6"
    end
end

local function getitemid(item, rarity)
    local item = item
    local rarity = rarity
    local mainId 
    local othervt = {}
    local function getequipedicon(e)
        for _,equipeditem in next, lplr.PlayerGui.ScreenGui["\230\173\166\229\153\168"].Frame["\229\189\147\229\137\141\232\163\133\229\164\135"]:GetChildren() do
            if equipeditem:FindFirstChild("PosName") and equipeditem:FindFirstChild("PosName").Text == e then
                return equipeditem.Frame.Icon.Image
            end
        end
    end
    local function getraritys(e)
        for i,v in next, game:GetService("ReplicatedStorage")["\230\173\166\229\153\168\231\168\128\230\156\137\229\186\166\230\184\144\229\143\152\232\137\178"]:GetChildren() do
            if v:FindFirstChild("Stroke") and v.Stroke.Color == e then
                return tonumber(v.Name)
            end
        end
    end
    for i,v in next, lplr.PlayerGui.ScreenGui["\230\173\166\229\153\168"].Frame.Bag.ScrollPet:GetChildren() do
        if v.Name == "Temp" then
            if v:FindFirstChild("onlyID") then
                if v:FindFirstChild("Using").Visible then
                    if getequipedicon(item) == v.Frame.Icon.Image then
                        mainId = v:FindFirstChild("onlyID").Value
                    end
                else
                    for _,color in next, v.Frame.Stroke:GetChildren() do
                        if color.Name == "\230\169\153" then
                            color.Color = game:GetService("ReplicatedStorage")["\230\173\166\229\153\168\231\168\128\230\156\137\229\186\166\230\184\144\229\143\152\232\137\178"]["4"].Stroke.Color
                        end
                        if color.Name ~= "UICorner" and getraritys(color.Color) and getraritys(color.Color) <= realrarity[rarity] then
                            table.insert(othervt, v:FindFirstChild("onlyID").Value)
                        end
                    end
                end
            else
                lplr.PlayerGui.ScreenGui["\230\173\166\229\153\168"].Visible = true
                repeat task.wait() until v:FindFirstChild("onlyID")
                lplr.PlayerGui.ScreenGui["\230\173\166\229\153\168"].Visible = false
            end
        end
    end
    return mainId, othervt
end

for i,v in next, lplr.PlayerGui.ScreenGui.Main["BottomRight\230\137\139\230\156\186"]["\230\138\128\232\131\189"]:GetChildren() do
    if v:FindFirstChild("onlyKey") then
        table.insert(skills, v.Frame.SkillName.Text)
    end
end

Tabs.mainTab:AddParagraph({
    Title = "Select Best Skills",
    Content = "choose unlocked best skills to do more damage"
})

Tabs.mainTab:AddDropdown("skill", {
    Title = "Select Best Skills for Kill Aura",
    Values = skills,
    Multi = false,
    Default = nil,
})

Tabs.mainTab:AddToggle("killaura", {Title = "Kill Aura", Default = false})

Tabs.mainTab:AddToggle("autoequipbest", {Title = "Auto Equipbest", Default = false})

Tabs.mainTab:AddToggle("autocollect", {Title = "Auto Collect", Default = false})

Tabs.mainTab:AddToggle("autoquest", {Title = "Auto Accept/Claim Quest", Default = false})

Tabs.mainTab:AddToggle("autoclaimexp", {Title = "Auto Claim Exp Boost", Default = false})

Tabs.miscTab:AddDropdown("stat", {
    Title = "Select Stat",
    Values = statss,
    Multi = false,
    Default = nil,
})

Tabs.miscTab:AddToggle("autostats", {Title = "Auto Add Stats", Default = false})

Tabs.miscTab:AddDropdown("fuse", {
    Title = "Select Item to Fuse",
    Values = fuseit,
    Multi = false,
    Default = nil,
})

Tabs.miscTab:AddDropdown("rarity", {
    Title = "Select Rarity to Fuse",
    Values = raritys,
    Multi = false,
    Default = nil,
})

Tabs.miscTab:AddToggle("autofuse", {Title = "Auto Fuse", Default = false})

Tabs.miscTab:AddToggle("autorejoin", {Title = "Auto Rejoin When Disconnected", Default = false})

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

Tabs.dungeonTab:AddDropdown("dungeon", {
    Title = "Select Dungeon",
    Values = map,
    Multi = false,
    Default = nil,
})

Tabs.dungeonTab:AddToggle("autojoindungeon", {Title = "Auto Join Dungeon", Default = false})

Tabs.summonTab:AddDropdown("eggid", {
    Title = "Select Weapon",
    Values = prices,
    Multi = false,
    Default = nil,
})

Tabs.summonTab:AddButton{
    Title = "Draw Weapon",
    Description = "",
    Callback = function()
        if Options["eggid"].Value then
            local price = string.split(Options["eggid"].Value, ":")[2]
            for i,v in next, FindEggCfgById do
                if tonumber(price) == FindEggCfgById[i].Price and string.find(Options["eggid"].Value, FindEggCfgById[i].ZhName) then
                    ReplicatedStorage:WaitForChild("Msg"):WaitForChild("DrawWeapon"):InvokeServer(i ,1)
                end
            end
        end
    end
}

Tabs.summonTab:AddButton{
    Title = "Draw Fruit",
    Description = "",
    Callback = function()
        ReplicatedStorage:WaitForChild("Msg"):WaitForChild("DrawFruit"):InvokeServer(1)
    end
}

Tabs.summonTab:AddButton{
    Title = "Draw Hero",
    Description = "",
    Callback = function()
        ReplicatedStorage:WaitForChild("Msg"):WaitForChild("DrawHero"):InvokeServer(1,1)
    end
}

Tabs.teleportTab:AddDropdown("world", {
    Title = "Select World",
    Values = world,
    Multi = false,
    Default = nil,
})

Tabs.teleportTab:AddButton{
    Title = "Teleport to Selected World",
    Description = "",
    Callback = function()
        if Options["world"].Value then
            for i,v in next, lplr.PlayerGui.ScreenGui["\228\184\150\231\149\140\228\188\160\233\128\129"].Frame:GetChildren() do
                if v:FindFirstChild("LvStr") and v.LvStr.Text == Options["world"].Value then
                    ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\229\142\187\229\136\171\231\154\132\228\184\150\231\149\140",tonumber(v.Name))
                end
            end
        end
    end
}

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

task.spawn(function()
    while task.wait() do
        if Options["killaura"].Value and Options["skill"].Value then
            for _,v in next, workspace["\229\137\175\230\156\172\229\156\176\229\155\190"]:GetChildren() do
                for _, plr in next, v.Players:GetChildren() do
                    if plr.Value == lplr.UserId then
                        if v["\229\156\176\229\155\190"]:FindFirstChild("Enemy") then
                            for _,folder in next, v["\229\156\176\229\155\190"].Enemy:GetChildren() do
                                if folder:IsA("Folder") then
                                    for _, enemy in next, folder:GetChildren() do
                                        if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("NPC") then
                                            local args = {
                                                [1] = {
                                                    ["phsic"] = {["Power"] = 1.42640686035156,["Time"] = 0.15,["Dir"] = Vector3.new(-0.08174365013837814, 0.7071067690849304, -0.702366054058075)},
                                                    ["damage"] = 30,
                                                    ["castPercent"] = 0,
                                                    ["hitID"] = 1,
                                                    ["isSetNetworkOwnerEnemy"] = true,
                                                    ["skillID"] = getskillid(Options["skill"].Value)
                                                },
                                                [2] = enemy.Name
                                            }
                                            ReplicatedStorage:WaitForChild("Msg"):WaitForChild("HitEvent"):FireServer(unpack(args))
                                            task.wait()
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(3) do
        if Options["autoequipbest"].Value then
            ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\232\163\133\229\164\135\230\156\128\228\189\179\232\163\133\229\164\135")
        end
    end
end)

task.spawn(function()
    while task.wait(.5) do
        if Options["dungeon"].Value == "Defense Mode" then
            ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180",getdungeon(Options["dungeon"].Value))
        end
        if Options["dungeon"].Value then
            local dungeon, diff = getdungeon(Options["dungeon"].Value)
            if Options["autojoindungeon"].Value then
                ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180", dungeon)
                ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166", diff)
            else
                ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\233\128\128\229\135\186\231\187\132\233\152\159\230\136\191\233\151\180", dungeon)
            end
            if lplr.PlayerGui.ScreenGui["\233\128\154\229\133\179\231\187\147\231\174\151"].Visible == true then
                ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\233\128\128\229\135\186\229\137\175\230\156\172")
                lplr.PlayerGui.ScreenGui["\233\128\154\229\133\179\231\187\147\231\174\151"].Visible = false
            end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Options["autocollect"].Value then
            for i,v in next, lplr.DropFolder:GetChildren() do
                task.wait(3)
                ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\230\139\190\229\143\150\231\137\169\229\147\129",{[1] = tonumber(v.Name),[2] = v:GetAttribute("DropNum"),[3] = v:GetAttribute("Identification")})
            end
        end
    end
end)

task.spawn(function()
    while task.wait(.1) do
        if Options["autostats"].Value and Options["stat"].Value then
            ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\229\177\158\230\128\167\231\130\185\229\138\160\231\130\185",{["attr"] = getstat(Options["stat"].Value),["addonce"] = 1})
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
            queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/AnimeDungeonFighters.lua", true))()]])
        end
    end)
end)

task.spawn(function()
    while task.wait(10) do
        if Options["autofuse"].Value and Options["fuse"].Value and Options["rarity"].Value then
            local mainid,othervt = getitemid(Options["fuse"].Value , Options["rarity"].Value)
            ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\232\163\133\229\164\135\229\188\186\229\140\150",{["MainID"] = mainid, ["OtherVt"] = othervt})
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Options["autoquest"].Value then
            ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\233\162\134\229\143\150NPC\228\187\187\229\138\161")
            ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\233\162\134\229\143\150NPC\228\187\187\229\138\161\229\165\150\229\138\177")
        end
        if Options["autoclaimexp"].Value then
            ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\233\162\134\229\143\150\229\143\140\229\128\141\231\187\143\233\170\140")
        end
    end
end)

task.spawn(function()
    while task.wait(.5) do
        if not lplr:WaitForChild("PlayerGui"):FindFirstChild("lelelel") then
            local ScreenGui = Instance.new("ScreenGui")
            local ImageButton = Instance.new("ImageButton")
            local TextLabel = Instance.new("TextLabel")
        
            ScreenGui.Name = "lelelel"
            ScreenGui.Parent = lplr:WaitForChild("PlayerGui")
            ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        
            ImageButton.Parent = ScreenGui
            ImageButton.BackgroundColor3 = Color3.fromRGB(116, 104, 96)
            ImageButton.BackgroundTransparency = 0.500
            ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ImageButton.BorderSizePixel = 4
            ImageButton.Position = UDim2.new(0, 0, 0.308541536, 0)
            ImageButton.Size = UDim2.new(0, 137, 0, 35)
            ImageButton.Image = "http://www.roblox.com/asset/?id=1547208871"
            ImageButton.ImageColor3 = Color3.fromRGB(162, 255, 188)
        
            TextLabel.Parent = ImageButton
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.BackgroundTransparency = 1.000
            TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.BorderSizePixel = 0
            TextLabel.Position = UDim2.new(0.325138301, 0, 0.042424228, 0)
            TextLabel.Size = UDim2.new(0, 47, 0, 33)
            TextLabel.Font = Enum.Font.Unknown
            TextLabel.Text = "Open/Close Gui"
            TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.TextSize = 14.000
        
            local function IOUVXF_fake_script()
                local script = Instance.new('LocalScript', ScreenGui)
                local Button = script.Parent.ImageButton
                Button.MouseButton1Click:Connect(function()
                    VirtualInputManager:SendKeyEvent(true, "LeftControl", false, game)
                    VirtualInputManager:SendKeyEvent(false, "LeftControl", false, game)
                end)
            end
            coroutine.wrap(IOUVXF_fake_script)()
        end
    end
end)


SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FallAngelHub")
SaveManager:SetFolder("FallAngelHub/AnimeDungenFighters")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)
Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})
SaveManager:LoadAutoloadConfig()
