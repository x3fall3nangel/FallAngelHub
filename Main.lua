local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/notification_gui_library.lua", true))()


if game.PlaceId == 7305309231 then
    local notif = Notification.new("success", "Found script.", "Loading...")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Taxi_Boss.lua"))()
    notif:delete()
elseif game.PlaceId == 7655489843 then
    local notif = Notification.new("success", "Found script.", "Loading...")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Anime%20Battlegrounds%20X.lua"))()
    notif:delete()
elseif game.PlaceId == 7195200675 then
    local notif = Notification.new("success", "Found script.", "Loading...")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Jojo%20The%20Day%20End%20Evolution.lua"))()
    notif:delete()
elseif game.PlaceId == 6297822481 or game.PlaceId == 6725802681 then
    local notif = Notification.new("success", "Found script.", "Loading...")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Titan%20Warfare.lua"))()
    local notif = Notification.new("success", "Found script.", "Loading...")
elseif game.PlaceId == 9585537847 then
    local notif = Notification.new("success", "Found script.", "Loading...")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Shadovis_RPG.lua"))()
    notif:delete()
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GSstarGamer/Roblox-Exploits/main/loader.lua"))() 
end
