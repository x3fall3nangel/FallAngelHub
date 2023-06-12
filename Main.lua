local chwid = game:GetService("RbxAnalyticsService"):GetClientId()
function check_hwid(hwid)
    local hwid = game:HttpGet("https://uc4c4mi44lvv2g3ombpszxkqtm0lxdzo.lambda-url.ap-northeast-1.on.aws/check?hwid=" ..
                                  chwid)
    local exists = hwid.split(hwid, ":")[2]
    if exists == "true}" then
        return true
    elseif exists == "false}" then
        return false
    end
end

local status = true

if status == true then
    if game.PlaceId == 7305309231 then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Taxi_Boss.lua"))()
    elseif game.PlaceId == 7655489843 then
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Anime%20Battlegrounds%20X.lua"))()
    elseif game.PlaceId == 7195200675 then
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Jojo%20The%20Day%20End%20Evolution.lua"))()
    elseif game.PlaceId == 6297822481 or game.PlaceId == 6725802681 then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Titan%20Warfare.lua"))()
    elseif game.PlaceId == 9585537847 then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/Shadovis_RPG.lua"))()
    elseif game.PlaceId == 10704789056 then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/x3fall3nangel/FallAngelHub/main/DriveWorld.lua"))()
    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GSstarGamer/Roblox-Exploits/main/loader.lua"))()
    end
elseif status == false then

end
