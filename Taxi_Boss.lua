repeat
	wait()
until game:IsLoaded()

local plr = game:GetService("Players")
local lplr = plr.LocalPlayer
local rate = nil
local carheight = nil
getgenv().autopark = false
local rating = {
	0,
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	"Event",
}
local height = {
	0.7,
	0.8,
	0.9,
	1,
	1.1,
	1.2,
	1.3,
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

local GUI = Library:Create{
	Name = "FallAngel Hub",
	Size = UDim2.fromOffset(600, 400),
	Theme = Library.Themes.Serika,
	Link = "https://discord.gg/b9QX5rnkT5"
}

local Maintab = GUI:tab{
	Name = "Main",
	Icon = "rbxassetid://2174510075"
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
	Description = "Reenter vehicle after press",
	Callback = function()
		modcar()
	end
}

Maintab:Dropdown{
	Name = "Choose Rating",
	StartingText = "Number",
	Items = rating,
	Callback = function(v)
		rate = v
	end
}


Maintab:Keybind{
	Name = "Tp to Customer",
	Description = "Choose Rating first",
	Keybind = Enum.KeyCode.C,
	Callback = function()
		if rate then
			if rate == "Event" then
				if tpeventcustomer() then
					tpevent()
				else
					GUI:Notification{
						Title = "Alert",
						Text = "Didnt find " .. rate .. " Customer Please Move Around",
						Duration = 3,
					}
				end
			else
				if tpcustomer() then
					tp()
				else
					GUI:Notification{
						Title = "Alert",
						Text = "Didnt find " .. rate .. " - " .. lplr.variables.vehicleRating.Value .. " Rating Customer Please Move Around",
						Duration = 3,
					}
				end
			end
		else
			GUI:Prompt{
				Title = "Alert",
				Text = "Please Choose Rating",
			}
		end
	end
}

Maintab:Dropdown{
	Name = "Choose Height for Auto Park",
	StartingText = "Number",
	Items = height,
	Callback = function(v)
		carheight = v 
		carheight = carheight or 1
	end
}

Maintab:Keybind{
	Name = "Auto Park",
	Description = "Work while 0 MPH",
	Keybind = Enum.KeyCode.X,
	Callback = function()
		autopark = not autopark
	end
}

Maintab:Toggle{
	Name = "Auto pick customer",
	Description = "Auto get customer while near",
	StartingState = false,
	Callback = function(state)
		getgenv().autopick = state
	end
}


Maintab:Toggle{
	Name = "Auto pick event customer",
	Description = "Auto get customer while near",
	StartingState = false,
	Callback = function(state)
		getgenv().autopickevent = state
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
				if tonumber(v.Client.PromptPart.Rating.Frame.Rating.Text) <= lplr.variables.vehicleRating.Value then
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

function tpcustomer()
	local target = nil
	local distance = math.huge
	for _, d in pairs(workspace.NewCustomers:GetChildren()) do
		for _ , v in pairs(d:GetChildren()) do
			if v and v.Client:FindFirstChild("PromptPart") and v.Client:FindFirstChild("Model") and v.Client.PromptPart:FindFirstChild("Rating") then
				local customerating = tonumber(v.Client.PromptPart.Rating.Frame.Rating.Text)
				if customerating >= rate and customerating <= lplr.variables.vehicleRating.Value then
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

function getclosesteventcustomer()
	local target = nil
	local distance = 20
	for _, d in pairs(workspace.NewCustomers:GetChildren()) do
		for _ , v in pairs(d:GetChildren()) do
			if v and v.Client:FindFirstChild("PromptPart") and v.Client:FindFirstChild("Model") then
				if v.Client.PromptPart:FindFirstChild("Event") then
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

function tpeventcustomer()
	local target = nil
	local distance = math.huge
	for _, d in pairs(workspace.NewCustomers:GetChildren()) do
		for _ , v in pairs(d:GetChildren()) do
			if v and v.Client:FindFirstChild("PromptPart") and v.Client:FindFirstChild("Model") then
				if v.Client.PromptPart:FindFirstChild("Event") then
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
	for i, v in pairs(workspace.Vehicles:GetChildren()) do
		if v:FindFirstChild("Server") and tostring(v.Server.Player.Value) == game.Players.LocalPlayer.Name then
			local modcar = require(v.Configuration.VehicleConfig)
			modcar.maxSpeed = 9999
			modcar.redline = 40000
			modcar.idleRPM = 40000
			modcar.peakPower = 3000
			modcar.peakTorque = 3000
			modcar.peakPowerRPM = 15000
			modcar.peakTorqueRPM = 99999
			modcar.maxPitchTorque = 999
			modcar.baseTorque = 9999
			if v.REAL.SEAT.EnterPrompt.ClassName == "ProximityPrompt" then
				v.REAL.SEAT.EnterPrompt.HoldDuration = 0
			end
		end
	end
end

function tp()
	for _, v in pairs(workspace.Vehicles:GetChildren()) do
		if v:FindFirstChild("Server") and tostring(v.Server.Player.Value) == lplr.Name then
			v:SetPrimaryPartCFrame(tpcustomer().CFrame)
		end
	end
end

function tpevent()
	for _, v in pairs(workspace.Vehicles:GetChildren()) do
		if v:FindFirstChild("Server") and tostring(v.Server.Player.Value) == lplr.Name then
			v:SetPrimaryPartCFrame(tpeventcustomer().CFrame)
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
	while wait(.1) do
		if autopickevent then
			pcall(function()
				fireproximityprompt(getclosesteventcustomer().Client.PromptPart.CustomerPrompt, 1, true)
			end)
		end
	end
end)

spawn(function()
	while task.wait() do
		if autopark and carheight then
			pcall(function()
				local park = workspace.ParkingMarkers:FindFirstChild("ParkingMarker")
				for _, v in pairs(workspace.Vehicles:GetChildren()) do
					if v:FindFirstChild("Server") and tostring(v.Server.Player.Value) == lplr.Name then
						if workspace.ParkingMarkers:FindFirstChild("ParkingMarker") and lplr:DistanceFromCharacter(park.Part.Position) < 50 then
							v:SetPrimaryPartCFrame(park.Part.CFrame * CFrame.new(0, carheight, 0))
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
				for _, v in pairs(workspace.Tracks:GetChildren()) do
					v:Destroy()
				end
			end)
		end
	end
end)

GUI:set_status("Status | Active")
