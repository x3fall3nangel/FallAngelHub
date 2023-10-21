local Title = "Support creator - Please visit the website"
local API_HOST = "s1.wayauth.com" -- s1.wayauth.com, s2.wayauth.com, s3.wayauth.com, s4.wayauth.com, s5.wayauth.com
local LINKVERTISE_ID = 939268 -- Change me
local LINKVERTISE_COUNT = 1 -- Change me
local TOKEN_EXPIRE_TIME = 120 -- Seconds

local Task = {}
Task.__index = Task

local HttpService = game:GetService("HttpService")
local SHA2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/Egor-Skriptunoff/pure_lua_SHA/master/sha2.lua"))()
local Iris = loadstring(game:HttpGet("https://raw.githubusercontent.com/x0581/Iris-Exploit-Bundle/main/bundle.lua"))().Init(game.CoreGui)

function Task.new(API_HOST, LinkvertiseID, LinkCount, TokenExpireTime)
    local nTask = {}

    nTask.API_HOST = API_HOST or "s1.wayauth.com"
    nTask.LinkvertiseID = LinkvertiseID or 12345
    nTask.LinkCount = LinkCount or 1
    nTask.Validator = tostring(math.random() + math.random(1, 100000) + Random.new():NextNumber())
    nTask.TokenExpireTime = TokenExpireTime or 0

    return setmetatable(nTask, Task)
end

function Task:create()
    local URLBase = "http://%s/v2/create/%s/%s/%s"
    local URL = URLBase:format(self.API_HOST, self.LinkvertiseID, self.Validator, self.LinkCount)
    self.task = HttpService:JSONDecode(game:HttpGet(URL))
    return self.task
end

function Task:verify()
    local URLBase = "http://%s/v2/verify/%s/%s/%s"
    local URL = URLBase:format(self.API_HOST, self.task.id, self.Validator, self.TokenExpireTime)
    local Response = HttpService:JSONDecode(game:HttpGet(URL))
    self.data = Response
    if Response.success then
        if SHA2.sha256(self.Validator):upper() == Response.validator:upper() then
            return true
        end
    end
    return false
end

function Task:copyURL()
    local URLBase = "http://%s/v2/wait/%s"
    local URL = URLBase:format(self.API_HOST, self.task.id)
    return setclipboard(URL)
end

function Task:verifyToken(Token)
    local URLBase = "http://%s/v2/tokens/exists/%s"
    local URL = URLBase:format(self.API_HOST, Token)
    local Response = game:HttpGet(URL)
    local Decode = HttpService:JSONDecode(Response)
    if Decode and Decode.success then
        return true
    end
    return false
end

local nTask = Task.new(API_HOST, LINKVERTISE_ID, LINKVERTISE_COUNT, TOKEN_EXPIRE_TIME); nTask:create()
local Verified = false

Iris:Connect(function()
    if not Verified then
        Iris.Window({Title, [Iris.Args.Window.NoClose] = true, [Iris.Args.Window.NoResize] = true, [Iris.Args.Window.NoScrollbar] = true, [Iris.Args.Window.NoCollapse] = true}, {size = Iris.State(Vector2.new(375, 60))}) do
            Iris.SameLine() do
                if Iris.Button({"I have visited the website."}).clicked then
                    task.spawn(function()
                        Verified = nTask:verify()
                    end)
                end
                if Iris.Button({"Copy Website"}).clicked then
                    nTask:copyURL()
                end
                Iris.End()
            end
            Iris.End()
        end
    end
end)

local TokenPassed

if isfile("test-token.txt") then
    if nTask:verifyToken(readfile("test-token.txt")) then
        Verified = true
        TokenPassed = true
    end
end


repeat task.wait() until Verified
if not TokenPassed then
warn("Verified website at", nTask.data.timestamp)
warn("Finished at", os.date("%c"))
warn("Authentication Token", nTask.data.token)
warn("Authentication Token Expire Time", TOKEN_EXPIRE_TIME)

writefile("test-token.txt", nTask.data.token)
end