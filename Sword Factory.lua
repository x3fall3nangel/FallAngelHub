local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

local GUI = Library:Create{
    Name = "Mercury",
    Size = UDim2.fromOffset(600, 400),
    Theme = Library.Themes.Dark,
    Link = "https://github.com/deeeity/mercury-lib"
}

local Maintab = GUI:tab{
    Name = "Maintab"
}

local plr = game:GetService("Players")
local lplr = plr.LocalPlayer

Maintab:Toggle{
    Name = "Semi God Mode",
    StartingState = false,
    Callback = function(state)
        getgenv().god = state
    end
}

Maintab:Toggle{
    Name = "Kill Aura Mobs",
    StartingState = false,
    Callback = function(state)
        getgenv().dmg = state
    end
}

Maintab:Toggle{
    Name = "Kill Aura Player",
    StartingState = false,
    Callback = function(state)
        getgenv().dmgplr = state
    end
}

Maintab:Slider{
    Name = "WalkSpeed",
    Default = 16,
    Min = 16,
    Max = 50,
    Callback = function(s)
        getgenv().speed = s
    end
}

spawn(function()
    while task.wait() do
        if lplr.Character and lplr.Character:FindFirstChildOfClass("Tool") and dmg then
            pcall(function()
                for i,v in next, workspace.Mobs:GetChildren() do 
                    if v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and dmg then
                        local magnitude = (v.HumanoidRootPart.Position - lplr.Character.HumanoidRootPart.Position).magnitude
                        if magnitude <= 50 then
                            firetouchinterest(v.HumanoidRootPart, lplr.Character:FindFirstChildOfClass("Tool").Handle, 0)
                            firetouchinterest(v.Head, lplr.Character:FindFirstChildOfClass("Tool").Handle, 0)
                            firetouchinterest(v.Torso, lplr.Character:FindFirstChildOfClass("Tool").Handle, 0)
                            firetouchinterest(v["Right Leg"], lplr.Character:FindFirstChildOfClass("Tool").Handle, 0)
                            firetouchinterest(v["Right Arm"], lplr.Character:FindFirstChildOfClass("Tool").Handle, 0)
                            firetouchinterest(v["Left Leg"], lplr.Character:FindFirstChildOfClass("Tool").Handle, 0)
                            firetouchinterest(v["Left Arm"], lplr.Character:FindFirstChildOfClass("Tool").Handle, 0)
                            firetouchinterest(v.HumanoidRootPart, lplr.Character:FindFirstChildOfClass("Tool").Handle, 1)
                            firetouchinterest(v.Head, lplr.Character:FindFirstChildOfClass("Tool").Handle, 1)
                            firetouchinterest(v.Torso, lplr.Character:FindFirstChildOfClass("Tool").Handle, 1)
                            firetouchinterest(v["Right Leg"], lplr.Character:FindFirstChildOfClass("Tool").Handle, 1)
                            firetouchinterest(v["Right Arm"], lplr.Character:FindFirstChildOfClass("Tool").Handle, 1)
                            firetouchinterest(v["Left Leg"], lplr.Character:FindFirstChildOfClass("Tool").Handle, 1)
                            firetouchinterest(v["Left Arm"], lplr.Character:FindFirstChildOfClass("Tool").Handle, 1)
                        end
                    end
                end
            end)
        end
    end
end)

spawn(function()
    while task.wait() do
        if lplr.Character and god then
            pcall(function()
                for i,v in next, workspace.Mobs:GetChildren() do 
                    if v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("LinkedSword") then
                        v.LinkedSword:Destroy()
                    end
                end
                for i,v in next, plr:GetPlayers() do
                    if v ~= lplr and v.Character and v.Character:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                       if v.Character:FindFirstChildOfClass("Tool") then
                           v:FindFirstChildOfClass("Tool").Handle:Destroy()
                       end 
                    end
                end
            end)
        end
    end
end)

spawn(function()
    while task.wait() do
        if lplr.Character and dmgplr then
            pcall(function()
                for i, v in pairs(plr:GetPlayers()) do
                    if v.Name ~= lplr.Name then
                        if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 and dmgplr then
                            local magnitude = (v.Character.HumanoidRootPart.Position - lplr.Character.HumanoidRootPart.Position).magnitude
                            if magnitude < 30 then
                                for i2,v2 in next, v.Character:GetChildren() do
                                    if v2:IsA("MeshPart") or v2:IsA("Part") then
                                        firetouchinterest(v2, lplr.Character, 0)
                                        firetouchinterest(v2, lplr.Character, 1)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

spawn(function()
    while task.wait() do
        if lplr.Character and speed then
            pcall(function()
                lplr.Character.Humanoid.WalkSpeed = speed
            end)
        end
    end
end)