local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local USERS_URL = "https://raw.githubusercontent.com/rnadom1232/tsdwda/refs/heads/main/autojoiner/Block/list.txt"

local requestFunc = syn and syn.request or request or http_request
if not requestFunc then
    return
end

local success, response = pcall(function()
    return requestFunc({
        Url = USERS_URL,
        Method = "GET",
        Headers = { ["Cache-Control"] = "no-cache" }
    })
end)

if not success or not response then
    return
end

local body = response.Body or response.body
if not body or body == "" then
    return
end

local kickList = {}
for line in string.gmatch(body, "[^\r\n]+") do
    local cleanName = line:gsub("%s+", ""):lower()
    if cleanName ~= "" then
        kickList[cleanName] = true
    end
end

if kickList[LocalPlayer.Name:lower()] then
    LocalPlayer:Kick("Hello. You can not use your autojoiner until you post your claimed hits to the channel needed. Contact tie or kzen when you did so")
end
