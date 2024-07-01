local games = {
    [33103002] = "https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/BeyBlade.lua",
    [4909558] = "https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/DriveWorld.lua",
    [15914350] = "https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Swordburst3.lua",
    [15150189] = "https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/AnimeDungeonFighters.lua",
}

if games[game.CreatorId] then
    loadstring(game:HttpGet(games[game.CreatorId]))()
else
    print("Game not supported")
end

--anti afk kick
local vu = cloneref(game:GetService("VirtualUser"))
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
