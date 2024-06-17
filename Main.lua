if game.PlaceId == 7305309231 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Taxi_Boss.lua"))()
elseif game.PlaceId == 7655489843 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Anime%20Battlegrounds%20X.lua"))()
elseif game.PlaceId == 10704789056 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/DriveWorld.lua"))()
elseif game.PlaceId == 16582687738 or game.PlaceId == 14819490378 or game.PlaceId == 15695929915 or game.PlaceId == 16928265611 or game.PlaceId == 17206024999 or game.PlaceId == 17856910664 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Swordburst3.lua"))()
elseif game.PlaceId == 15502802094 or game.PlaceId == 12135640403 or game.PlaceId == 15742087191 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/AnimeDungeonFighters.lua"))()
elseif game.PlaceId == 15423741735 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/BeyBlade.lua"))()
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GSstarGamer/Roblox-Exploits/main/loader.lua"))()
end

--anti afk kick
local vu = cloneref(game:GetService("VirtualUser"))
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

game:GetService("Players").LocalPlayer.OnTeleport:Connect(function()
    queue_on_teleport(loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Main.lua"))())
end)