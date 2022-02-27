repeat task.wait() until game:IsLoaded()
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

local GUI = Library:Create{
    Name = "FallAngel Hub",
    Size = UDim2.fromOffset(600, 400),
    Theme = Library.Themes.Dark,
    Link = "https://discord.gg/b9QX5rnkT5"
}

local plr = game:GetService("Players")
local lplr = plr.LocalPlayer

local Maintab = GUI:tab{
    Name = "Main",
    Icon = "rbxassetid://2174510075"
}

Maintab:Toggle{
    Name = "Kill All", 
    Description = "Only work for Marleyans Soldies(Equip Sniper or Bazooka)",
    StartingState = false,
    Callback = function(state)
        getgenv().killall = state
    end
}

GUI:Credit{
    Name = "x3Fall3nAngel",
    Description = "Made the script",
    V3rm = "https://v3rmillion.net/member.php?action=profile&uid=2270329",
    Discord = "https://discord.gg/b9QX5rnkT5"
}

function player()
    local target = nil
    local dist = math.huge
    for i, v in pairs(plr:GetPlayers()) do
        if v.Name ~= lplr.Name and lplr.Character then
            if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("PlayerHitbox") and v.TeamColor ~= lplr.TeamColor then
                if lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart") then
                    local magnitude = (v.Character.HumanoidRootPart.Position - lplr.Character.HumanoidRootPart.Position).magnitude
                    if magnitude < dist then
                        target = v
                        dist = magnitude
                    end
                end
            end
        end
    end
    return target
end

spawn(function()
    while task.wait() do
        if killall then
            pcall(function()
                if lplr.Character then
                    local args = {
                        [1] = "Sniper",
                        [2] = player().Character.Head.CFrame,
                        [3] = player().Character.Head
                    }

                    game:GetService("ReplicatedStorage").Remotes.Guns.Fire:FireServer(unpack(args))
                    local args = {
                        [1] = player().Character.HumanoidRootPart.CFrame
                    }

                    game:GetService("ReplicatedStorage").Remotes.Guns.BazookaFire:FireServer(unpack(args))
                end
            end)
        end
    end
end)
