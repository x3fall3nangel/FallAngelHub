local function notif()
    game.StarterGui:SetCore("SendNotification", {
        Title = "Game Found";
        Text = "Loading script, wait for 3 sec";
    })
end


if game.PlaceId == 7305309231 then
    notif()
    wait(3)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Taxi_Boss.lua"))()
elseif game.PlaceId == 7655489843 then
    notif()
    wait(3)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Anime%20Battlegrounds%20X.lua"))()
elseif game.PlaceId == 7195200675 then
    notif()
    wait(3)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Jojo%20The%20Day%20End%20Evolution.lua"))()
elseif game.PlaceId == 6297822481 or game.PlaceId == 6725802681 then
    notif()
    wait(3)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Titan%20Warfare.lua"))()
elseif game.PlaceId == 9585537847 then
    notif()
    wait(3)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Shadovis_RPG.lua"))()
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GSstarGamer/Roblox-Exploits/main/loader.lua"))() 
end
