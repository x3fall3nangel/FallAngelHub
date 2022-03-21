repeat
	wait()
until game:IsLoaded()

local L_1_ = game:GetService("Players")
local L_2_ = L_1_.LocalPlayer
local L_3_ = nil
local L_4_ = nil
getgenv().autopark = false
local L_5_ = {
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
local L_6_ = {
	0.5,
	0.6,
	0.7,
	0.8,
	0.9,
	1,
	1.1,
	1.2,
	1.3,
	1.4,
	1.5,
}

local L_7_ = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

local L_8_ = L_7_:Create{
	Name = "FallAngel Hub",
	Size = UDim2.fromOffset(600, 400),
	Theme = L_7_.Themes.Serika,
	Link = "https://discord.gg/b9QX5rnkT5"
}

local L_9_ = L_8_:tab{
	Name = "Main",
	Icon = "rbxassetid://2174510075"
}

L_8_:Credit{
	Name = "x3Fall3nAngel",
	Description = "Made the script",
	V3rm = "https://v3rmillion.net/member.php?action=profile&uid=2270329",
	Discord = "https://discord.gg/b9QX5rnkT5"
}

L_8_:Notification{
	Title = "Hey!",
	Text = "Join our discord server! discord.gg/b9QX5rnkT5",
	Duration = 20,
	Callback = function()
		game:IsLoaded()
	end
}

L_9_:Button{
	Name = "Modified Car",
	Description = "Reenter vehicle after press",
	Callback = function()
		modcar()
	end
}

L_9_:Dropdown{
	Name = "Choose Rating",
	StartingText = "Number",
	Items = L_5_,
	Callback = function(L_10_arg0)
		L_3_ = L_10_arg0
	end
}


L_9_:Keybind{
	Name = "Tp to Customer",
	Description = "Choose Rating first",
	Keybind = Enum.KeyCode.C,
	Callback = function()
		if L_3_ then
			if L_3_ == "Event" then
				if tpeventcustomer() then
					tpevent()
				else
					L_8_:Notification{
						Title = "Alert",
						Text = "Didnt find " .. L_3_ .. " Customer Please Move Around",
						Duration = 3,
					}
				end
			else
				if tpcustomer() then
					if L_2_.PlayerGui.MissionGui.MissionGui.Visible == false then
						tp()
					else
						L_8_:Notification{
							Title = "Alert",
							Text = "Your taxi already has customer",
							Duration = 3,
						}
					end
				else
					L_8_:Notification{
						Title = "Alert",
						Text = "Didnt find " .. L_3_ .. " - " .. L_2_.variables.vehicleRating.Value .. " Rating Customer Please Move Around",
						Duration = 3,
					}
				end
			end
		else
			L_8_:Prompt{
				Title = "Alert",
				Text = "Please Choose Rating",
			}
		end
	end
}

L_9_:Dropdown{
	Name = "Choose Height for Auto Park",
	StartingText = "Number",
	Items = L_6_,
	Callback = function(L_11_arg0)
		L_4_ = L_11_arg0 or 1
	end
}

L_9_:Keybind{
	Name = "Toggle Auto Park",
	Description = "Work while 0 MPH",
	Keybind = Enum.KeyCode.X,
	Callback = function()
		autopark = not autopark
	end
}

L_9_:Toggle{
	Name = "Auto pick customer",
	Description = "Auto get customer while near",
	StartingState = false,
	Callback = function(L_12_arg0)
		getgenv().autopick = L_12_arg0
	end
}


L_9_:Toggle{
	Name = "Auto pick event customer",
	Description = "Auto get customer while near",
	StartingState = false,
	Callback = function(L_13_arg0)
		getgenv().autopickevent = L_13_arg0
	end
}

L_9_:Toggle{
	Name = "Remove Random Car",
	StartingState = false,
	Callback = function(L_14_arg0)
		getgenv().removecar = L_14_arg0
	end
}

function fireproximityprompt(L_15_arg0, L_16_arg1, L_17_arg2)
	if L_15_arg0.ClassName == "ProximityPrompt" then
		L_16_arg1 = L_16_arg1 or 1
		local L_18_ = L_15_arg0.HoldDuration
		if L_17_arg2 then
			L_15_arg0.HoldDuration = 0
		end
		for L_19_forvar0 = 1, L_16_arg1 do
			L_15_arg0:InputHoldBegin()
			if not L_17_arg2 then
				wait(L_15_arg0.HoldDuration)
			end
			L_15_arg0:InputHoldEnd()
		end
		L_15_arg0.HoldDuration = L_18_
	else
		error("userdata<ProximityPrompt> expected")
	end
end

function getclosestcustomer()
	local L_20_ = nil
	local L_21_ = 20
	for L_22_forvar0, L_23_forvar1 in pairs(workspace.NewCustomers:GetChildren()) do
		for L_24_forvar0 , L_25_forvar1 in pairs(L_23_forvar1:GetChildren()) do
			if L_25_forvar1 and L_25_forvar1.Client:FindFirstChild("PromptPart") and L_25_forvar1.Client:FindFirstChild("Model") then
				if tonumber(L_25_forvar1.Client.PromptPart.Rating.Frame.Rating.Text) <= L_2_.variables.vehicleRating.Value then
					local L_26_ = (L_2_.Character.HumanoidRootPart.Position - L_25_forvar1.Client.PromptPart.Position).magnitude
					if L_26_ < L_21_ then
						L_20_ = L_25_forvar1
						L_21_ = L_26_
					end
				end
			end
		end
	end
	return L_20_
end

function tpcustomer()
	local L_27_ = nil
	local L_28_ = math.huge
	for L_29_forvar0, L_30_forvar1 in pairs(workspace.NewCustomers:GetChildren()) do
		for L_31_forvar0 , L_32_forvar1 in pairs(L_30_forvar1:GetChildren()) do
			if L_32_forvar1 and L_32_forvar1.Client:FindFirstChild("PromptPart") and L_32_forvar1.Client:FindFirstChild("Model") and L_32_forvar1.Client.PromptPart:FindFirstChild("Rating") then
				local L_33_ = tonumber(L_32_forvar1.Client.PromptPart.Rating.Frame.Rating.Text)
				if L_33_ >= L_3_ and L_33_ <= L_2_.variables.vehicleRating.Value then
					local L_34_ = (L_2_.Character.HumanoidRootPart.Position - L_32_forvar1.Client.PromptPart.Position).magnitude
					if L_34_ < L_28_ then
						L_27_ = L_32_forvar1
						L_28_ = L_34_
					end
				end
			end
		end
	end
	return L_27_
end

function getclosesteventcustomer()
	local L_35_ = nil
	local L_36_ = 20
	for L_37_forvar0, L_38_forvar1 in pairs(workspace.NewCustomers:GetChildren()) do
		for L_39_forvar0 , L_40_forvar1 in pairs(L_38_forvar1:GetChildren()) do
			if L_40_forvar1 and L_40_forvar1.Client:FindFirstChild("PromptPart") and L_40_forvar1.Client:FindFirstChild("Model") then
				if L_40_forvar1.Client.PromptPart:FindFirstChild("Event") then
					local L_41_ = (L_2_.Character.HumanoidRootPart.Position - L_40_forvar1.Client.PromptPart.Position).magnitude
					if L_41_ < L_36_ then
						L_35_ = L_40_forvar1
						L_36_ = L_41_
					end
				end
			end
		end
	end
	return L_35_
end

function tpeventcustomer()
	local L_42_ = nil
	local L_43_ = math.huge
	for L_44_forvar0, L_45_forvar1 in pairs(workspace.NewCustomers:GetChildren()) do
		for L_46_forvar0 , L_47_forvar1 in pairs(L_45_forvar1:GetChildren()) do
			if L_47_forvar1 and L_47_forvar1.Client:FindFirstChild("PromptPart") and L_47_forvar1.Client:FindFirstChild("Model") then
				if L_47_forvar1.Client.PromptPart:FindFirstChild("Event") then
					local L_48_ = (L_2_.Character.HumanoidRootPart.Position - L_47_forvar1.Client.PromptPart.Position).magnitude
					if L_48_ < L_43_ then
						L_42_ = L_47_forvar1
						L_43_ = L_48_
					end
				end
			end
		end
	end
	return L_42_
end

function modcar()
	for L_49_forvar0, L_50_forvar1 in pairs(workspace.Vehicles:GetChildren()) do
		if L_50_forvar1:FindFirstChild("Server") and tostring(L_50_forvar1.Server.Player.Value) == game.Players.LocalPlayer.Name then
			local L_51_ = require(L_50_forvar1.Configuration.VehicleConfig)
			L_51_.maxSpeed = 9999
			L_51_.redline = 40000
			L_51_.idleRPM = 40000
			L_51_.peakPower = 3000
			L_51_.peakTorque = 3000
			L_51_.peakPowerRPM = 15000
			L_51_.peakTorqueRPM = 99999
			L_51_.maxPitchTorque = 999
			L_51_.baseTorque = 9999
			if L_50_forvar1.REAL.SEAT.EnterPrompt.ClassName == "ProximityPrompt" then
				L_50_forvar1.REAL.SEAT.EnterPrompt.HoldDuration = 0
			end
		end
	end
end

function tp()
	for L_52_forvar0, L_53_forvar1 in pairs(workspace.Vehicles:GetChildren()) do
		if L_53_forvar1:FindFirstChild("Server") and tostring(L_53_forvar1.Server.Player.Value) == L_2_.Name then
			L_53_forvar1:SetPrimaryPartCFrame(tpcustomer().CFrame)
		end
	end
end

function tpevent()
	for L_54_forvar0, L_55_forvar1 in pairs(workspace.Vehicles:GetChildren()) do
		if L_55_forvar1:FindFirstChild("Server") and tostring(L_55_forvar1.Server.Player.Value) == L_2_.Name then
			L_55_forvar1:SetPrimaryPartCFrame(tpeventcustomer().CFrame)
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
		if autopark and L_4_ then
			pcall(function()
				local L_56_ = workspace.ParkingMarkers:FindFirstChild("ParkingMarker")
				for L_57_forvar0, L_58_forvar1 in pairs(workspace.Vehicles:GetChildren()) do
					if L_58_forvar1:FindFirstChild("Server") and tostring(L_58_forvar1.Server.Player.Value) == L_2_.Name then
						if workspace.ParkingMarkers:FindFirstChild("ParkingMarker") and L_2_:DistanceFromCharacter(L_56_.Part.Position) < 50 then
							L_58_forvar1:SetPrimaryPartCFrame(L_56_.Part.CFrame * CFrame.new(0, L_4_, 0))
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
				for L_59_forvar0, L_60_forvar1 in pairs(workspace.Tracks:GetChildren()) do
					L_60_forvar1:Destroy()
				end
			end)
		end
	end
end)

L_8_:set_status("Status | Active")
