local DISCORD_NAME = "z12 logger"
local DISCORD_IMAGE = "https://i.imgyukle.com/2020/05/11/r8k2GI.png" -- default is FiveM logo
exports("dclog", function(webhook, title, text, target)
    local ts = os.time()
    local time = os.date('%Y-%m-%d %H:%M:%S', ts)
    local connect = {
        {
            ["color"] = 3092790,
            ["avatar_url"] = "https://i.imgyukle.com/2020/05/11/r8k2GI.png",
            ["title"] = title,
            ["description"] = text,
            ["footer"] = {
                ["text"] = "by Zalgo                             " ..time,
                ["icon_url"] = "https://i.imgyukle.com/2020/05/11/r8k2GI.png",
            },
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end)

exports("getid", function(source)
    local identifier = {}
    local identifiers = {}
	identifiers = GetPlayerIdentifiers(source)
    for i = 1, #identifiers do
        if string.match(identifiers[i], "discord:") then
            identifier["discord"] = string.sub(identifiers[i], 9)
            identifier["discord"] = "<@"..identifier["discord"]..">"
        end
        if string.match(identifiers[i], "steam:") then
			identifier["license"] = identifiers[i]
		end
    end
    if identifier["discord"] == nil then
        identifier["discord"] = "Bilinmiyor"
    end
    return identifier
end)

exports("getwebhooks", function()
    return WebHooks
end)