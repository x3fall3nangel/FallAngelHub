local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Fluent " .. Fluent.Version,
    SubTitle = "by dawid",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    mainTab = Window:AddTab({ Title = "Main", Icon = "scroll" }),
    dungeonTab = Window:AddTab({ Title = "Dungeon", Icon = "shield" }),
    creditTab = Window:AddTab({Title = "Information",Icon = "users"}),
    miscTab = Window:AddTab({Title = "Misc",Icon = "layout-grid"}),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options


local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lplr = Players.LocalPlayer

local Attack_ID
local CanShootElement = false

local dungeonid = {}

local Dungeon = require(ReplicatedStorage.ReplicatedStorage.SharedModules.Dungeons)
local KnitClient = require(ReplicatedStorage.ReplicatedStorage.Packages.Knit.KnitClient)
local DungeonService = debug.getupvalue(KnitClient.GetService, 1).DungeonService
local PartyService = debug.getupvalue(KnitClient.GetService, 1).PartyService
local WeaponService = debug.getupvalue(KnitClient.GetService, 1).WeaponService
repeat task.wait() until debug.getupvalue(debug.getupvalue(WeaponService.UseSword,1),1) ~= nil
local UseSwordRemote = debug.getupvalue(debug.getupvalue(WeaponService.UseSword,1),1)
local GetPartyFromPlayerRemote = debug.getupvalue(debug.getupvalue(PartyService.GetPartyFromPlayer,1),1)
local DataController = debug.getupvalue(KnitClient.GetController, 1).DataController
local DropsService = debug.getupvalue(KnitClient.GetService, 1).DropsService
local CollectDropRemote = debug.getupvalue(debug.getupvalue(DropsService.CollectDrop,1),1)
local DropsController = require(game:GetService("Players").LocalPlayer.PlayerScripts.StarterPlayerScripts.Controllers.DropsController)
local DropsTable =  debug.getupvalue(DropsController.KnitStart,3)
local StartDungeonRemote = debug.getupvalue(debug.getupvalue(DungeonService.StartDungeon,1),1)
local HealingService = debug.getupvalue(KnitClient.GetService, 1).HealingService
local UseHealRemote = debug.getupvalue(debug.getupvalue(HealingService.UseHeal,1),1)

local function getchar()
	return lplr.Character or lplr.CharacterAdded:Wait()
end

local OldNameCall
OldNameCall = hookmetamethod(game, "__namecall", function(sel, ...)
    local Args = {...}
    if sel == UseSwordRemote then
        Attack_ID = Args[2]
    end
    return OldNameCall(sel, unpack(Args))
end)

for _,v in next, Dungeon do
    for o,p in next, v.SpecificDungeonData.DifficultyLevels do
        for i, diff in next, v.SpecificDungeonData.Difficulties do
            if o == diff then
                table.insert(dungeonid, v.Id .. " " .. o .. " Level:"..  v.SpecificDungeonData.DifficultyLevels[diff].Level)
            end
        end
    end
end

for i,v in next, ReplicatedStorage.ReplicatedStorage.Packages.Knit.Services.AntiCheatService:GetChildren() do
    v:Destroy()
end

local function getdungeon(e)
    local dungeon = {
        id = "",
        diff = ""
    }
    dungeon.id = string.split(e, " ")[1]
    dungeon.diff = string.split(e, " ")[2]
    return dungeon
end

Tabs.dungeonTab:AddDropdown("choosedungeon", {
    Title = "Select Dungeon",
    Values = dungeonid,
    Multi = false,
    Default = "",
})

Tabs.dungeonTab:AddToggle("autodungeon", {Title = "Auto Create Dungeon", Default = false})

Tabs.dungeonTab:AddToggle("autostart", {Title = "Auto Start Dungeon", Default = false})

Tabs.dungeonTab:AddToggle("autoretry", {Title = "Auto Retry", Default = false})

Tabs.mainTab:AddToggle("killaura", {Title = "Sword Aura", Default = false})

Tabs.mainTab:AddToggle("autoshoot", {Title = "Auto Shoot Element", Default = false})

Tabs.mainTab:AddToggle("autoheal", {Title = "Auto Use Heal When Low", Default = false})

Tabs.mainTab:AddSlider("dist", {
    Title = "Auto Farm Distance",
    Description = "",
    Default = 5,
    Min = 1,
    Max = 15,
    Rounding = 1
})

Tabs.mainTab:AddToggle("autofarm", {Title = "Auto Farm Mobs", Default = false})

Tabs.mainTab:AddToggle("autocollect", {Title = "Auto Collect Drops", Default = false})

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
        VirtualUser:CaptureController();
        VirtualUser:Button1Down(Vector2.new(1280, 672));
        task.wait(5)
    end
end)

task.spawn(function()
    while task.wait() do
        if Options["killaura"].Value and Attack_ID then
            UseSwordRemote:InvokeServer({["Direction"] = nil,["Origin"] = nil,["Position"] = nil}, Attack_ID)          
        end
    end
end)

task.spawn(function()
    while task.wait(.1) do
        if Options["autocollect"].Value then
            for i,v in next, DropsTable do
                CollectDropRemote:InvokeServer(i)
            end
        end
    end
end)

local b = false
task.spawn(function()
    while task.wait(.1) do
        if Options["autodungeon"].Value then
            local CreatePartyRemote
            local StartPartyRemote
            local suc = pcall(function() return debug.getupvalue(debug.getupvalue(PartyService.CreateParty, 1),1) end)
            if suc then
                CreatePartyRemote = debug.getupvalue(debug.getupvalue(PartyService.CreateParty, 1),1)
                StartPartyRemote = debug.getupvalue(debug.getupvalue(PartyService.StartParty,1),1)
            else
                return
            end
            CreatePartyRemote:InvokeServer(getdungeon(Options["choosedungeon"].Value).id, getdungeon(Options["choosedungeon"].Value).diff, "Friends", "Normal")
            local id = GetPartyFromPlayerRemote:InvokeServer(lplr).Data.UUID
            StartPartyRemote:InvokeServer(id)
            if b == false then
                b = true
                queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/ElementalDungeon.lua"))()]])
            end
        end
    end
end)

local a = false
task.spawn(function()
    while task.wait(.1) do
        if Options["autoretry"].Value then
            if lplr.PlayerGui.DungeonComplete.Main.Frame.Visible == true then
                local suc = debug.getupvalue(debug.getupvalue(PartyService.VoteOn,1),1)
                local VoteOnRemote
                if suc then
                    VoteOnRemote = debug.getupvalue(debug.getupvalue(PartyService.VoteOn,1),1)
                else
                    return
                end
                VoteOnRemote:InvokeServer("Retry")
                if a == false then
                    a = true
                    queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/ElementalDungeon.lua"))()]])
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(.1) do
        if Options["autostart"].Value then
            if lplr.PlayerGui.Main.StartBtn.Visible == true then
                StartDungeonRemote:InvokeServer()
            end
        end
    end
end)

task.spawn(function()
    while task.wait(.1) do
        if Options["autofarm"].Value then
            for i,v in next, workspace.Mobs:GetChildren() do
                repeat task.wait()
                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid").Health >= 0 and getchar() and getchar():FindFirstChild("HumanoidRootPart") then
                        local lookAtPosition = v.HumanoidRootPart.Position
                        local lookDirection = (lookAtPosition - getchar():FindFirstChild("HumanoidRootPart").Position).unit
                        getchar().HumanoidRootPart.CFrame = v:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, 0, Options["dist"].Value)
                        local rotation = CFrame.new(getchar():FindFirstChild("HumanoidRootPart").Position, getchar():FindFirstChild("HumanoidRootPart").Position + lookDirection)
                        getchar():FindFirstChild("HumanoidRootPart").CFrame = rotation
                        CanShootElement = true
                    end
                until not v:FindFirstChild("HumanoidRootPart") or v:FindFirstChild("Humanoid").Health <= 0 or Options["autofarm"].Value == false or not getchar()
                CanShootElement = false
            end
        end
    end
end)

task.spawn(function()
    while task.wait(.1) do
        if Options["autoshoot"] and CanShootElement then
            for i,v in next, debug.getupvalues(DataController.GetReplica)[1].Data.Main.EquippedItems.Elements do
                for i2,v2 in next, ReplicatedStorage.ReplicatedStorage.Abilities.Elements[v]:GetChildren() do
                    local Remote = ReplicatedStorage:WaitForChild("ReplicatedStorage"):WaitForChild("Abilities"):WaitForChild("Templates"):WaitForChild("ToolTemplate"):WaitForChild("RemoteEvent ")
                    Remote:FireServer(v2,{["Direction"] = Vector3.new(0,0,0),["Origin"] = Vector3.new(0,0,0),["Position"] = Vector3.new(0,0,0)},"Start")
                    Remote:FireServer(v2,{["Direction"] = Vector3.new(0,0,0),["Origin"] = Vector3.new(0,0,0),["Position"] = Vector3.new(0,0,0)},"End")
                end
            end            
        end
    end
end)

task.spawn(function()
    while task.wait(.1) do
        if Options["autoheal"] then
            if getchar() and getchar():FindFirstChild("Humanoid") then
                if getchar().Humanoid.Health <= getchar().Humanoid.MaxHealth / 2 then
                    UseHealRemote:InvokeServer()
                end
            end           
        end
    end
end)

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)
Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})
SaveManager:LoadAutoloadConfig()