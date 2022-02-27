exports("dclog", function(webhook, title, text, target)
    local ts = os.time()
    local time = os.date('%Y-%m-%d %H:%M:%S', ts)
    local connect = {
        {
            ["color"] = 3092790,
            ["title"] = title,
            ["description"] = text,
            ["footer"] = {
                ["text"] = "by WH1TE                             " ..time,
                ["icon_url"] = "https://i.ytimg.com/vi/RciuGXnHhR8/hqdefault.jpg",
            },
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "fizzfau-logsystem", embeds = connect}), { ['Content-Type'] = 'application/json' })
end)
exports("getwebhooks", function()
    return WebHooks
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