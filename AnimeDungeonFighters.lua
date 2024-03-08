queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/AnimeDungeonFighters.lua", true))()]])
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

local Window = OrionLib:MakeWindow({Name = "Anime Dungeon Fighters", HidePremium = false, SaveConfig = true, ConfigFolder = "AnimeDungeonFighters",ShowIcon = true})

local mainTab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://13313903300",
	PremiumOnly = false
})

local miscTab = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://16307658016",
	PremiumOnly = false
})

local dungeonTab = Window:MakeTab({
	Name = "Dungeon",
	Icon = "rbxassetid://180083965",
	PremiumOnly = false
})

local summonTab = Window:MakeTab({
	Name = "Summon",
	Icon = "rbxassetid://938790070",
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
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lplr = Players.LocalPlayer

local egg = {}
local skills = {}
local prices = {}
local map = {"Defense Mode"}
local mapdiff = {"Easy" , "Normal", "Hard", "Hell"}
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

mainTab:AddParagraph("Select Best Skills","choose unlocked best skills to do more damage")
mainTab:AddDropdown({
	Name = "Select Best Skills for Kill Aura",
	Default = nil,
	Options = skills,
	Save = true,
    Flag = "skill"
})

mainTab:AddToggle{
    Name = "Kill Aura",
    Default = false,
    Save = true,
    Flag = "killaura",
}

mainTab:AddToggle{
    Name = "Auto Equipbest",
    Default = false,
    Save = true,
    Flag = "autoequipbest",
}

mainTab:AddToggle{
    Name = "Auto Collect",
    Default = false,
    Save = true,
    Flag = "autocollect",
}

mainTab:AddToggle{
    Name = "Auto Accept/Claim Quest",
    Default = false,
    Save = true,
    Flag = "autoquest",
}

mainTab:AddToggle{
    Name = "Auto Claim Exp Boost",
    Default = false,
    Save = true,
    Flag = "autoclaimexp",
}

miscTab:AddDropdown({
	Name = "Select Stats",
	Default = nil,
	Options = statss,
	Save = true,
    Flag = "stat"
})

miscTab:AddToggle{
    Name = "Auto add stats",
    Default = false,
    Save = true,
    Flag = "autostats",
}

miscTab:AddDropdown({
	Name = "Select Item to Fuse",
	Default = nil,
	Options = fuseit,
	Save = true,
    Flag = "fuse"
})

miscTab:AddDropdown({
	Name = "Select Rarity to Fuse",
	Default = nil,
	Options = raritys,
	Save = true,
    Flag = "rarity"
})

miscTab:AddToggle{
    Name = "Auto Fuse",
    Default = false,
    Save = true,
    Flag = "autofuse",
}

miscTab:AddToggle{
    Name = "Auto Rejoin When Disconnected",
    Default = false,
    Save = true,
    Flag = "autorejoin",
}

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

dungeonTab:AddDropdown({
	Name = "Select Dungeon",
	Default = nil,
	Options = map,
	Save = true,
    Flag = "dungeon",
})

dungeonTab:AddToggle{
    Name = "Auto Join Dungeon",
    Default = false,
    Save = true,
    Flag = "autojoindungeon",
}

summonTab:AddDropdown({
	Name = "Select Weapon",
	Default = nil,
	Options = prices,
	Save = true,
    Flag = "eggid",
})

summonTab:AddButton{
    Name = "Draw Weapon",
    Callback = function()
        if OrionLib.Flags["eggid"].Value then
            local price = string.split(OrionLib.Flags["eggid"].Value, ":")[2]
            for i,v in next, FindEggCfgById do
                if tonumber(price) == FindEggCfgById[i].Price and string.find(OrionLib.Flags["eggid"].Value, FindEggCfgById[i].ZhName) then
                    ReplicatedStorage:WaitForChild("Msg"):WaitForChild("DrawWeapon"):InvokeServer(i ,1)
                end
            end
        end
    end
}

summonTab:AddButton{
    Name = "Draw Fruit",
    Callback = function()
        ReplicatedStorage:WaitForChild("Msg"):WaitForChild("DrawFruit"):InvokeServer(1)
    end
}

summonTab:AddButton{
    Name = "Draw Hero",
    Callback = function()
        ReplicatedStorage:WaitForChild("Msg"):WaitForChild("DrawHero"):InvokeServer(1,1)
    end
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

task.spawn(function()
    while task.wait() do
        if OrionLib.Flags["killaura"].Value and OrionLib.Flags["skill"].Value then
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
                                                    ["phsic"] = {
                                                        ["Power"] = 1.42640686035156,
                                                        ["Time"] = 0.15,
                                                        ["Dir"] = Vector3.new(-0.08174365013837814, 0.7071067690849304, -0.702366054058075)
                                                    },
                                                    ["damage"] = 30,
                                                    ["castPercent"] = 0,
                                                    ["hitID"] = 1,
                                                    ["isSetNetworkOwnerEnemy"] = true,
                                                    ["skillID"] = getskillid(OrionLib.Flags["skill"].Value)
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
        if OrionLib.Flags["autoequipbest"].Value then
            ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\232\163\133\229\164\135\230\156\128\228\189\179\232\163\133\229\164\135")
        end
    end
end)

task.spawn(function()
    while task.wait(.5) do
        if OrionLib.Flags["dungeon"].Value == "Defense Mode" then
            ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180",getdungeon(OrionLib.Flags["dungeon"].Value))
        end
        if OrionLib.Flags["dungeon"].Value then
            local dungeon, diff = getdungeon(OrionLib.Flags["dungeon"].Value)
            if OrionLib.Flags["autojoindungeon"].Value then
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
        if OrionLib.Flags["autocollect"].Value then
            for i,v in next, lplr.DropFolder:GetChildren() do
                task.wait(3)
                ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\230\139\190\229\143\150\231\137\169\229\147\129",{[1] = tonumber(v.Name),[2] = v:GetAttribute("DropNum"),[3] = v:GetAttribute("Identification")})
            end
        end
    end
end)

task.spawn(function()
    while task.wait(.1) do
        if OrionLib.Flags["autostats"].Value and OrionLib.Flags["stat"].Value then
            ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\229\177\158\230\128\167\231\130\185\229\138\160\231\130\185",{["attr"] = getstat(OrionLib.Flags["stat"].Value),["addonce"] = 1})
        end
    end
end)

task.spawn(function()
    GuiService.ErrorMessageChanged:Connect(function()
        if #Players:GetPlayers() <= 1 then
            lplr:Kick("\nRejoining...")
            task.wait()
            TeleportService:Teleport(game.PlaceId, lplr)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, lplr)
        end
    end)
end)

task.spawn(function()
    while task.wait(10) do
        if OrionLib.Flags["autofuse"].Value and OrionLib.Flags["fuse"].Value and OrionLib.Flags["rarity"].Value then
            local mainid,othervt = getitemid(OrionLib.Flags["fuse"].Value , OrionLib.Flags["rarity"].Value)
            ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\232\163\133\229\164\135\229\188\186\229\140\150",{["MainID"] = mainid, ["OtherVt"] = othervt})
        end
    end
end)

task.spawn(function()
    while task.wait(.5) do
        if OrionLib.Flags["autoquest"].Value then
            ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\233\162\134\229\143\150NPC\228\187\187\229\138\161")
            ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\233\162\134\229\143\150NPC\228\187\187\229\138\161\229\165\150\229\138\177")
        end
        if OrionLib.Flags["autoclaimexp"].Value then
            ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\233\162\134\229\143\150\229\143\140\229\128\141\231\187\143\233\170\140")
        end
    end
end)

OrionLib:Init()