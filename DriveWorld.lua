local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/mercury-lib-edit/master/src.lua"))()

local GUI = Library:Create{
    Name = "Mercury",
    Size = UDim2.fromOffset(600, 400),
    Theme = Library.Themes.Serika,
    Link = "https://github.com/deeeity/mercury-lib"
}

local Main = GUI:tab{
    Name = "Main",
    Icon = "rbxassetid://8569322835" -- rbxassetid://2174510075 home icon
}


local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")

local lp = Players.LocalPlayer
local Systems = ReplicatedStorage:WaitForChild("Systems")

local Driveworld = {}

for i,v in pairs(getconnections(Players.LocalPlayer.Idled)) do
    if v["Disable"] then
        v["Disable"](v)
    elseif v["Disconnect"] then
        v["Disconnect"](v)
    end
end

local function getchar()
    return lp.Character or lp.CharacterAdded:Wait()
end

local function isvehicle()
    for i,v in next, workspace.Cars:GetChildren() do
        if (v:IsA("Model") and v:FindFirstChild("Owner") and v:FindFirstChild("Owner").Value == lp) then
            if v:FindFirstChild("CurrentDriver") and v:FindFirstChild("CurrentDriver").Value == lp then
                return true
            end
        end
    end
    return false
end

local function getvehicle()
    for i,v in next, workspace.Cars:GetChildren() do
        if v:IsA("Model") and v:FindFirstChild("Owner") and v:FindFirstChild("Owner").Value == lp then
            return v
        end
    end
    return
end


Main:Toggle({
    Name = "Auto Delivery Trailer",
	StartingState = false,
    Description = "Use Full-E or Casper for more money(work in USA map only)",
	Callback = function(state)
        Driveworld["autodelivery"] = state
    end
})

Main:Toggle({
    Name = "Auto Delivery Food",
	StartingState = false,
    Description = "easier for quest",
	Callback = function(state)
        Driveworld["autodeliveryfood"] = state
    end
})

Main:Toggle({
    Name = "Auto Complete Race",
	StartingState = false,
    Description = "auto complete when u in race",
	Callback = function(state)
        Driveworld["autocomplete"] = state
    end
})

Main:Button({
    Name = "Find Barn Part",
    Description = "Tp ur car when u near the barn part",
	Callback = function()
        for i,v in next, workspace.Objects.Destructible:GetChildren() do
            if v.Name == "BarnFindItem" and v:FindFirstChildWhichIsA("MeshPart") then
                Systems:WaitForChild("Navigate"):WaitForChild("Teleport"):InvokeServer(v:FindFirstChildWhichIsA("MeshPart").CFrame)
                task.wait(.5)
            end
        end
    end
})

task.spawn(function()
    while task.wait() do
        if Driveworld["autocomplete"] then
            if isvehicle() then
                for _,v in next, workspace.Races:GetChildren() do
                    if (v:FindFirstChild("Checkpoints") and v:FindFirstChild("Checkpoints"):GetChildren()[1]:FindFirstChild("Forcefield")) then
                        task.wait(3)
                        for i = 1, #v.Checkpoints:GetChildren() do
                            if v.Checkpoints[i]:FindFirstChild("Forcefield") then
                                Systems:WaitForChild("Navigate"):WaitForChild("Teleport"):InvokeServer(v.Checkpoints[i].Forcefield.CFrame)
                                task.wait()
                            end
                        end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Driveworld["autodeliveryfood"] then
            pcall(function()
                if not isvehicle() then
                    local Cars = ReplicatedStorage:WaitForChild("PlayerData"):WaitForChild(lp.Name):WaitForChild("Inventory"):WaitForChild("Cars")
                    local Truck = Cars:FindFirstChild("FullE") or Cars:FindFirstChild("Casper")
                    local normalcar = Cars:FindFirstChildWhichIsA("Folder")
                    if Truck then
                        Systems:WaitForChild("CarInteraction"):WaitForChild("SpawnPlayerCar"):InvokeServer(Truck)
                    else
                        Systems:WaitForChild("CarInteraction"):WaitForChild("SpawnPlayerCar"):InvokeServer(normalcar)
                    end
                    getchar().HumanoidRootPart.CFrame = getvehicle().PrimaryPart.CFrame
                    task.wait(1)
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                end
                local completepos
                local CompletionRegion
                local job = lp.PlayerGui.Interface.Score.Frame.Jobs
                repeat task.wait()
                    if job.Visible == false and Driveworld["autodeliveryfood"] then
                        Systems:WaitForChild("Jobs"):WaitForChild("StartJob"):InvokeServer("FoodDelivery","Tavern")
                    end
                until job.Visible == true or Driveworld["autodeliveryfood"] == false
                task.wait(25)
                CompletionRegion = workspace:FindFirstChild("CompletionRegion")
                if CompletionRegion:FindFirstChild("Primary") then
                    completepos = CompletionRegion:FindFirstChild("Primary").CFrame
                end
                for i = 1, 25 do
                    if not Driveworld["autodelivery"] or not getvehicle() or not getchar() then
                        return
                    end
                    task.wait(1)
                end
                Systems:WaitForChild("Navigate"):WaitForChild("Teleport"):InvokeServer(completepos)
                task.wait(.5)
                Systems:WaitForChild("Jobs"):WaitForChild("CompleteJob"):InvokeServer()
                task.wait(.5)
                if lp.PlayerGui.Interface.JobComplete.Enabled == true then
                    Systems:WaitForChild("Jobs"):WaitForChild("CashBankedEarnings"):FireServer()
                    firesignal(lp.PlayerGui.Interface.JobComplete.Window.Content.Buttons.Close.MouseButton1Click)
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Driveworld["autodelivery"] then
            pcall(function()
                if not isvehicle() then
                    local Cars = ReplicatedStorage:WaitForChild("PlayerData"):WaitForChild(lp.Name):WaitForChild("Inventory"):WaitForChild("Cars")
                    local Truck = Cars:FindFirstChild("FullE") or Cars:FindFirstChild("Casper")
                    local normalcar = Cars:FindFirstChildWhichIsA("Folder")
                    if Truck then
                        Systems:WaitForChild("CarInteraction"):WaitForChild("SpawnPlayerCar"):InvokeServer(Truck)
                    else
                        Systems:WaitForChild("CarInteraction"):WaitForChild("SpawnPlayerCar"):InvokeServer(normalcar)
                    end
                    getchar().HumanoidRootPart.CFrame = getvehicle().PrimaryPart.CFrame
                    task.wait(1)
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                end
                local completepos
                local distance
                local jobDistance
                local CompletionRegion
                local job = lp.PlayerGui.Interface.Score.Frame.Jobs
                repeat task.wait()
                    if job.Visible == false and Driveworld["autodelivery"] then
                        Systems:WaitForChild("Jobs"):WaitForChild("StartJob"):InvokeServer("TrailerDelivery", "F")
                    end
                until job.Visible == true or Driveworld["autodelivery"] == false
                print("Start Job")
                repeat task.wait() 
                    CompletionRegion = workspace:WaitForChild("CompletionRegion", 3)
                    if CompletionRegion then
                        distance = CompletionRegion:FindFirstChild("Primary"):FindFirstChild("DestinationIndicator"):FindFirstChild("Distance").Text
                        local yeas = string.split(distance, " ")
                        for i,v in next, yeas do
                            if tonumber(v) then
                                if tonumber(v) < 2.1 then
                                    Systems:WaitForChild("Jobs"):WaitForChild("StartJob"):InvokeServer("TrailerDelivery", "F")
                                else
                                    jobDistance = v
                                    print("Trailer Job Distance : " .. jobDistance)
                                    break
                                end
                            end
                        end
                    end
                until jobDistance and tonumber(jobDistance) > 2.1 or Driveworld["autodelivery"] == false
                if CompletionRegion:FindFirstChild("Primary") then
                    completepos = CompletionRegion:FindFirstChild("Primary").CFrame
                end
                for i = 1, 25 do
                    if not Driveworld["autodelivery"] or not getvehicle() or not getchar() then
                        return
                    end
                    task.wait(1)
                end
                Systems:WaitForChild("Navigate"):WaitForChild("Teleport"):InvokeServer(completepos)
                task.wait(.5)
                Systems:WaitForChild("Jobs"):WaitForChild("CompleteJob"):InvokeServer()
                task.wait(.5)
                if lp.PlayerGui.Interface.JobComplete.Enabled == true then
                    Systems:WaitForChild("Jobs"):WaitForChild("CashBankedEarnings"):FireServer()
                    firesignal(lp.PlayerGui.Interface.JobComplete.Window.Content.Buttons.Close.MouseButton1Click)
                end
                print("Completed Job")    
            end)
        end
    end
end)

GUI:Credit{
    Name = "x3Fall3nAngel",
    Description = "Made the script",
    V3rm = "https://v3rmillion.net/member.php?action=profile&uid=2270329",
    Discord = "https://discord.gg/b9QX5rnkT5"
}

GUI:set_status("Status | Active")