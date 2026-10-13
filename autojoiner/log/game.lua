if not LPH_OBFUSCATED then
    LPH_NO_VIRTUALIZE = function(...) return (...) end
    LPH_JIT_MAX = function(...) return (...) end
    LPH_JIT_ULTRA = function(...) return (...) end
end

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local LocalPlayer = Players.LocalPlayer

local CONFIG = {
    WEBHOOK_URL = "https://discord.com/api/webhooks/1559658969838919710/ZncRm-rLjJP3bHrkUnmk-ciZ_TuDyzZj3gSY-Bcr-z8kkCbZ_7mElDn7E78E7ifbQI4q"
}

local function GetGameName()
    local success, gameInfo = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)
    if success and gameInfo then
        return gameInfo.Name
    end
    return "Unknown"
end

local function CreateWebhookData()
    local description = string.format(
        "**Username:** %s\n**Display Name:** %s",
        LocalPlayer.Name,
        LocalPlayer.DisplayName
    )

    local payload = {
        ["embeds"] = {{
            ["title"] = GetGameName(),
            ["description"] = description,
            ["color"] = 16777215,
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }

    return HttpService:JSONEncode(payload)
end

local function SendWebhook(data)
    local request = http_request or request or HttpPost or syn.request
    if not request then return end

    pcall(function()
        request({
            Url = CONFIG.WEBHOOK_URL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = data
        })
    end)
end

pcall(function()
    SendWebhook(CreateWebhookData())
end)

return true
