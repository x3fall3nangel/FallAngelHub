if game.PlaceId == 7499189111 then
    game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunctions").EnterQueue:InvokeServer("FFA", "Ryan", false)
    return
end

if game.PlaceId ~= 7501699167 then
    return
end

local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()


local Window = Library:CreateWindow({
    -- Set Center to true if you want the menu to appear in the center
    -- Set AutoShow to true if you want the menu to appear when it is created
    -- Position and Size are also valid options here
    -- but you do not need to define them unless you are changing them :)
    
    Title = 'FallAngel Hub',
    Center = true, 
    AutoShow = true,
})

local Tabs = {
    -- Creates a new tab titled Main
    Main = Window:AddTab('Main'), 
    ['UI Settings'] = Window:AddTab('UI Settings'),
}
local Mainbox = Tabs.Main:AddLeftGroupbox('Main')

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local queue = queue_on_teleport or syn.queue_on_teleport
local queuecheck = false
local skills

local function GetChampionModule()
    local champion = LocalPlayer:GetAttribute("Champion")
    local module = require(ReplicatedStorage.Modules.ChampionModules[champion])
    return module
end

local skill = {
    "Unique",
    "Special",
    "Ultimate",
    "Basic"
}

queue([[loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Encounters.lua", true))()]])

local Network = require(ReplicatedStorage.SharedModules.Network)

Mainbox:AddToggle('infthing', {
    Text = 'Inf Energy/Ultimate',
    Default = false, -- Default value (true / false)
    Tooltip = '', -- Information shown when you hover over the toggle
})

Mainbox:AddToggle('Killall', {
    Text = 'KillAll',
    Default = true, -- Default value (true / false)
    Tooltip = 'Work with all champions', -- Information shown when you hover over the toggle
})

Mainbox:AddToggle('NoCooldown', {
    Text = 'No Cooldown',
    Default = false, -- Default value (true / false)
    Tooltip = 'no cooldown all abilities', -- Information shown when you hover over the toggle
})

Mainbox:AddToggle('autoqueue', {
    Text = 'Auto Queue Match',
    Default = true, -- Default value (true / false)
    Tooltip = '', -- Information shown when you hover over the toggle
})

Mainbox:AddLabel("Spam Ability"):AddKeyPicker('KeyPicker', {
    -- SyncToggleState only works with toggles. 
    -- It allows you to make a keybind which has its state synced with its parent toggle

    -- Example: Keybind which you use to toggle flyhack, etc.
    -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state
    Default = 'V', -- String as the name of the keybind (MB1, MB2 for mouse buttons)  
    SyncToggleState = true, 

    -- You can define custom Modes but I have never had a use for it.
    Mode = 'Toggle', -- Modes: Always, Toggle, Hold

    Text = 'Ability Spam', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu,
})


Mainbox:AddDropdown('Skilldropdown', {
    Values = skill,
    Default = "", -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Select skill',
    Tooltip = '', -- Information shown when you hover over the textbox
})

Options.Skilldropdown:OnChanged(function(v)
    skills = v
end)


task.spawn(function()
    RunService.Heartbeat:Connect(function()
        if Options.KeyPicker:GetState() and skills then
            GetChampionModule()[skills .. "AttackStart"]()
            if Library.Unloaded then return end
        else
            return
        end
    end)
end)

Toggles.autoqueue:OnChanged(function()
    task.spawn(function()
        while task.wait() do
            if LocalPlayer.PlayerGui.Victory.NewVictory.Visible and not queuecheck and Toggles.autoqueue.Value then
                Network:FireServer("EnterQueue")
                queuecheck = true
            end
        end
    end)
end)

Toggles.infthing:OnChanged(function()
    task.spawn(function()
        while task.wait() and Toggles.infthing.Value do
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Energy") and LocalPlayer.Character:FindFirstChild("Charge") then
                LocalPlayer.Character.Energy.Value = 100
                LocalPlayer.Character.Charge.Value = 100
            end
        end
    end)
end)

Toggles.NoCooldown:OnChanged(function()
    task.spawn(function()
        while task.wait() and Toggles.NoCooldown.Value do
            for _,v in next, debug.getupvalues(GetChampionModule().BasicAttackStart) do
                if typeof(v) == "table" then
                    for i2,v2 in next, v do
                        if typeof(v2) == "boolean" then
                            v[i2] = false
                        end
                    end
                end
            end
        end
    end)
end)

Toggles.Killall:OnChanged(function()
    task.spawn(function()
        while task.wait(.1) and Toggles.Killall.Value do
            for i,v in next, Players:GetPlayers() do
                if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
                    Network:FireServer("DamageRequest", {
                        ["direction"] = LocalPlayer.Character.Head.CFrame.LookVector,
                        ["IKnowWhyYouAreHere"] = "TheresNoPoint",
                        ["charName"] = "Kusanagi",
                        ["charhit"] = v.Character,
                        ["attackType"] = "FailedParry",
                        ["chargeIncrease"] = nil,
                        ["char"] = LocalPlayer.Character,
                        ["damage"] = 10,
                        ["knockbackSpeed"] = 999
                    })
                end
            end
        end
    end)
end)

-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' }) 

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- ThemeManager (Allows you to have a menu theme system)

-- Hand the library over to our managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore keys that are used by ThemeManager. 
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings() 

-- Adds our MenuKeybind to the ignore list 
-- (do you want each config to have a different menu key? probably not.)
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 

-- use case for doing it this way: 
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs['UI Settings']) 

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config 
-- which has been marked to be one that auto loads!