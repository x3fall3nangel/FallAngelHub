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

local Window = OrionLib:MakeWindow({Name = "Anime Dungeon Fighters", HidePremium = false, SaveConfig = true, ConfigFolder = "AnimeDungeonFighters",ShowIcon = true,})

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
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lplr = Players.LocalPlayer

local egg = {}
local skills = {}
local weapo = {"lvl 1" , "lvl 20", "lvl 40"}
local weapon = {"Sword", "Pistol", "Gloves"}
local mapdiff = {"Easy" , "Normal", "Hard", "Hell"}
local statss = {"Health", "Defense", "Attack", "Critical"}
local fuseit = {"Hat","Back","Weapon","Shoe","Ring","Necklace"}
local map = {"defense", "lvl 1" , "lvl 20", "lvl 40", "lvl 60", "lvl 80", "lvl 100", "lvl 120", "lvl 140",}

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

local function getdiff(w)
    if w == "Easy" then
        return 1
    elseif w == "Normal" then
        return 2
    elseif w == "Hard" then
        return 3
    elseif w == "Hell" then
        return 4
    end
end

local function getdungeon(v)
    if v == "lvl 1" then
        return "1_1"
    elseif v == "lvl 20" then
        return "1_2"
    elseif v == "lvl 40" then
        return "1_3"
    elseif v == "lvl 60" then
        return "2_1"
    elseif v == "lvl 80" then
        return "2_2"
    elseif v == "lvl 100" then
        return "2_3"
    elseif v == "lvl 120" then
        return "2_4"
    elseif v == "lvl 140" then
        return "2_5"
    elseif v == "lvl 140" then
        return "2_5"
    elseif v == "lvl 140" then
        return "2_5"
    elseif v == "lvl 140" then
        return "2_5"
    elseif v == "defense" then
        return "\229\161\148\233\152\178\230\168\161\229\188\143"
    end
end

local function getstat(e)
    local w 
    if e == "Health" then
        w = "3"
    elseif e == "Attack" then
        w = "1"
    elseif e == "Defense" then
        w = "2"
    elseif e == "Critical" then
        w = "6"
    end
    return w
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
    StartingState = false,
    Save = true,
    Flag = "killaura",
}

mainTab:AddToggle{
    Name = "Auto Equipbest",
    StartingState = false,
    Save = true,
    Flag = "autoequipbest",
}

mainTab:AddToggle{
    Name = "Auto Collect",
    StartingState = false,
    Save = true,
    Flag = "autocollect",
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
    StartingState = false,
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

miscTab:AddToggle{
    Name = "Auto Fuse",
    StartingState = false,
    Save = true,
    Flag = "autofuse",
}

miscTab:AddParagraph("Claim All Mail","Open mailbox to claim all item")
miscTab:AddButton{
    Name = "Claim all item in Mail",
    Callback = function()
        lplr.PlayerGui.ScreenGui["\233\130\174\228\187\182"].Visible = true
        for i,v in next, lplr.PlayerGui.ScreenGui["\233\130\174\228\187\182"].Frame.Scorll:GetChildren() do
            if tonumber(v.Name) then
                ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteEvent"):FireServer("\233\162\134\229\143\150\233\130\174\228\187\182\229\165\150\229\138\177", tonumber(v.Name))
            end
        end
        lplr.PlayerGui.ScreenGui["\233\130\174\228\187\182"].Visible = false
    end
}

dungeonTab:AddDropdown({
	Name = "Select Dungeon",
	Default = nil,
	Options = map,
	Save = true,
    Flag = "dungeon",
})

dungeonTab:AddDropdown({
	Name = "Select Dungeon Difficult",
	Default = "Easy",
	Options = mapdiff,
	Save = true,
    Flag = "diff",
})

dungeonTab:AddToggle{
    Name = "Auto Join Dungeon",
    StartingState = false,
    Save = true,
    Flag = "autojoindungeon",
}

summonTab:AddDropdown({
	Name = "Select Weapon lvl",
	Default = nil,
	Options = weapo,
	Save = true,
    Flag = "eggid",
})

summonTab:AddDropdown({
	Name = "Select Weapon",
	Default = nil,
	Options = weapon,
	Save = true,
    Flag = "weapontype",
})

summonTab:AddButton{
    Name = "Draw Weapon",
    Callback = function()
        if OrionLib.Flags["eggid"].Value and OrionLib.Flags["weapontype"].Value then
            for i,v in next, workspace["\229\156\186\230\153\175"]["\229\164\167\229\142\133"]["\230\138\189\230\173\166\229\153\168"]:GetChildren() do
                if string.find(v.Name, getdungeon(OrionLib.Flags["eggid"].Value)) and v.TouchPart.EggGUI.NameLabel.Text == OrionLib.Flags["weapontype"].Value then
                    ReplicatedStorage:WaitForChild("Msg"):WaitForChild("DrawWeapon"):InvokeServer(v.EggId.Value,1)
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
                                                        ["Power"] = 42.42640686035156,
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
    while task.wait(5) do
        if OrionLib.Flags["autoequipbest"].Value then
            ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\232\163\133\229\164\135\230\156\128\228\189\179\232\163\133\229\164\135")
        end
    end
end)

task.spawn(function()
    while task.wait(.5) do
        if OrionLib.Flags["dungeon"].Value == "defense" and OrionLib.Flags["diff"].Value then
            ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180",getdungeon(OrionLib.Flags["dungeon"].Value))
            ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166", getdiff(OrionLib.Flags["diff"].Value))
        end
        if OrionLib.Flags["dungeon"].Value and OrionLib.Flags["diff"].Value then
            if OrionLib.Flags["autojoindungeon"].Value then
                ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\229\138\160\229\133\165\231\187\132\233\152\159\230\136\191\233\151\180",getdungeon(OrionLib.Flags["dungeon"].Value))
                ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\230\138\149\231\165\168\233\154\190\229\186\166", getdiff(OrionLib.Flags["diff"].Value))
            else
                ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\233\128\128\229\135\186\231\187\132\233\152\159\230\136\191\233\151\180", getdungeon(OrionLib.Flags["dungeon"].Value))
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
                ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\230\139\190\229\143\150\231\137\169\229\147\129",{[1] = tonumber(v.Name),[2] = v:GetAttribute("DropNum"),[3] = v:GetAttribute("Identification")})
            end
        end
    end
    workspace:FindFirstChild("DropFolder").ChildAdded:Connect(function(v)
        if OrionLib.Flags["autocollect"].Value then
            v:Destroy()
        end
    end)
end)

task.spawn(function()
    while task.wait() do
        if OrionLib.Flags["autostats"].Value and OrionLib.Flags["stat"].Value then
            ReplicatedStorage:WaitForChild("Msg"):WaitForChild("RemoteFunction"):InvokeServer("\229\177\158\230\128\167\231\130\185\229\138\160\231\130\185",{["attr"] = getstat(OrionLib.Flags["stat"].Value),["addonce"] = 1})
        end
    end
end)

-- task.spawn(function()
--     while task.wait() do
--         if OrionLib.Flags["autofuse"].Value and OrionLib.Flags["fuse"].Value then
--         end
--     end
-- end)

OrionLib:Init()