repeat
    wait()
until game:IsLoaded()
local plr = game:GetService("Players")
local lplr = plr.LocalPlayer

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

local GUI = Library:Create{
    Name = "FallAngel Hub",
    Size = UDim2.fromOffset(600, 400),
    Theme = Library.Themes.Dark,
    Link = "https://discord.gg/b9QX5rnkT5"
}

local Maintab = GUI:tab{
    Name = "Main",
    Icon = "rbxassetid://2174510075" -- rbxassetid://2174510075 home icon
}

GUI:Credit{
    Name = "x3Fall3nAngel",
    Description = "Made the script",
    V3rm = "https://v3rmillion.net/member.php?action=profile&uid=2270329",
    Discord = "https://discord.gg/b9QX5rnkT5"
}

GUI:Notification{
    Title = "Hey!",
    Text = "Join our discord server! discord.gg/b9QX5rnkT5",
    Duration = 20,
    Callback = function()
        game:IsLoaded()
    end
}

Maintab:Button{
    Name = "Modified Car",
    Callback = function()
        modcar()
    end
}

Maintab:Toggle{
    Name = "Auto pick customer",
    Description = "Auto get customer when near",
    StartingState = false,
    Callback = function(state)
        getgenv().autopick = state
    end
}

Maintab:Toggle{
    Name = "Auto Park",
    StartingState = false,
    Callback = function(state)
        getgenv().autopark = state
    end
}

Maintab:Toggle{
    Name = "Remove Random Car",
    StartingState = false,
    Callback = function(state)
        getgenv().removecar = state
    end
}

function fireproximityprompt(Obj, Amount, Skip)
    if Obj.ClassName == "ProximityPrompt" then
        Amount = Amount or 1
        local PromptTime = Obj.HoldDuration
        if Skip then
            Obj.HoldDuration = 0
        end
        for i = 1, Amount do
            Obj:InputHoldBegin()
            if not Skip then
                wait(Obj.HoldDuration)
            end
            Obj:InputHoldEnd()
        end
        Obj.HoldDuration = PromptTime
    else
        error("userdata<ProximityPrompt> expected")
    end
end

function getclosestcustomer()
    local target = nil
    local distance = 20
    for _, d in pairs(workspace.NewCustomers:GetChildren()) do
        for _ , v in pairs(d:GetChildren()) do 
            if v and v.Client:FindFirstChild("PromptPart") and v.Client:FindFirstChild("Model") then
                if tonumber(v.Client.PromptPart.Rating.Frame.Rating.Text) <= lplr.variables.vehicleRating.Value or v.Client.PromptPart:FindFirstChild("Event") then
                    local magnitude = (lplr.Character.HumanoidRootPart.Position - v.Client.PromptPart.Position).magnitude
                    if magnitude < distance then
                        target = v
                        distance = magnitude
                    end
                end
            end
        end
    end
    return target
end


function modcar()
    for i, v in pairs(getgc(true)) do
        if typeof(v) == "table" and rawget(v, "maxSpeed") then
            v.redline = 60000   
            v.idleRPM = 30000
            v.peakPower = 2000
            v.peakTorque = 2000
            v.peakPowerRPM = 15000
            v.peakTorqueRPM = 99999
            v.maxPitchTorque = 999
        elseif typeof(v) == "table" and rawget(v, "baseTorque") then
            v.baseTorque = 9999
        end
    end
end

spawn(function()
    while wait(.1) do
        if autopick then
            pcall(function()
                fireproximityprompt(getclosestcustomer().Client.PromptPart.CustomerPrompt, 1, true)
            end)
        end
    end
end)

spawn(function()
    while task.wait() do
        if autopark then
            pcall(function()
                local park = workspace.ParkingMarkers:FindFirstChild("ParkingMarker")
                for i, v in pairs(workspace.Vehicles:GetChildren()) do
                    if v:FindFirstChild("Server") and tostring(v.Server.Player.Value) == lplr.Name then
                        if workspace.ParkingMarkers:FindFirstChild("ParkingMarker") and lplr:DistanceFromCharacter(park.Part.Position) < 30 then
                            v:SetPrimaryPartCFrame(park.Part.CFrame * CFrame.new(0, 0.9, 0))
                        end
                    end
                end
            end)
        end
    end
end)


spawn(function()
    while task.wait() do
        if removecar then
            pcall(function()
                for i,v in pairs(workspace.Tracks:GetChildren()) do
                    v:Destroy()
                end
            end)
        end
    end
end)
