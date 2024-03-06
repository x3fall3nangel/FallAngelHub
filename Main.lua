if game.PlaceId == 7305309231 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Taxi_Boss.lua"))()
elseif game.PlaceId == 7655489843 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Anime%20Battlegrounds%20X.lua"))()
elseif game.PlaceId == 7195200675 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Jojo%20The%20Day%20End%20Evolution.lua"))()
elseif game.PlaceId == 6297822481 or game.PlaceId == 6725802681 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Titan%20Warfare.lua"))()
elseif game.PlaceId == 9585537847 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Shadovis_RPG.lua"))()
elseif game.PlaceId == 10704789056 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/DriveWorld.lua"))()
elseif game.PlaceId == 16582687738 or game.PlaceId == 14819490378 or game.PlaecId == 15695929915 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Swordburst3.lua"))()
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GSstarGamer/Roblox-Exploits/main/loader.lua"))()
end

--anti afk kick
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
