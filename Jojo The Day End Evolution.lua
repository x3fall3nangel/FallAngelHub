local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

local GUI = Library:Create{
    Name = "FallAngel Hub",
    Size = UDim2.fromOffset(600, 400),
    Theme = Library.Themes.Dark,
    Link = "https://discord.gg/b9QX5rnkT5"
}

local plr = game:GetService("Players")
local lplr = plr.LocalPlayer
local mobs = {
    "Thugs",
    "Body Builder",
    "School Bully"
}
local a = nil

local Maintab = GUI:tab{
    Name = "Main",
    Icon = "rbxassetid://2174510075 "
}

GUI:Credit{
    Name = "x3Fall3nAngel",
    Description = "Made the script",
    V3rm = "https://v3rmillion.net/member.php?action=profile&uid=2270329",
    Discord = "https://discord.gg/b9QX5rnkT5"
}

Maintab:Dropdown{
    Name = "Choose Mobs",
    StartingText = "Select...",
    Items = mobs,
    Callback = function(v)
        a = v
    end
}

Maintab:Toggle{
    Name = "Auto Farm Mobs",
    StartingState = false,
    Callback = function(v)
        getgenv().autofarm = v
    end
}

spawn(function()
    while task.wait() do
        if autofarm and a then
            for i, v in next, workspace.NPC:GetChildren() do
                if v.Name == a and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                    if lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart") then
                        lplr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.Angles(math.rad(-90), 0, 0) + Vector3.new(0, 5, 0)
                    end
                end
            end
        end
    end
end)
