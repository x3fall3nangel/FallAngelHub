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
local connection = nil

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

Maintab:Toggle{
	Name = "ESP Name",
	StartingState = false,
	Callback = function(state) 
        getgenv().espname = state
        if espname == true then
            local gui = Instance.new("BillboardGui")
            local esp = Instance.new("TextLabel", gui)
            gui.Name = "ESP"
            gui.ResetOnSpawn = false
            gui.AlwaysOnTop = true;
            gui.LightInfluence = 0;
            gui.Size = UDim2.new(1.75, 0, 1.75, 0);
            esp.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            esp.Text = ""
            esp.Size = UDim2.new(0.0001, 0.00001, 0.0001, 0.00001);
            esp.BorderSizePixel = 4;
            esp.BorderColor3 = Color3.new(255, 255, 255)
            esp.BorderSizePixel = 0
            esp.Font = "GothamSemibold"
            esp.TextSize = 8
            esp.TextColor3 = Color3.fromRGB(255, 255, 255) 
            while task.wait() do 
                if espname then
                    for i,v in pairs (game:GetService("Players"):GetPlayers()) do
                        if v ~= lplr and v.Character.Head:FindFirstChild("Cracked esp") == nil then 
                            esp.Text = "{"..v.Name.."}"
                            gui:Clone().Parent = v.Character.Head
                        end
                    end
                else
                    gui:Destroy()
                end
            end
        end
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
