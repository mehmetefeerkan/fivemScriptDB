ESX = nil

CreateThread(function()
    MySQL.Async.execute('CREATE TABLE IF NOT EXISTS policereports (id int AUTO_INCREMENT, identifier varchar(100), name varchar(100), number varchar(20), description text, createdAt date DEFAULT CURDATE(), PRIMARY KEY(id))')

    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(100)
    end 
end)

RegisterNetEvent('lg: openAllReports')
AddEventHandler('lg: openAllReports', function()
    local idJ = source
    local xPlayer = ESX.GetPlayerFromId(idJ)
    local job = xPlayer.getJob().name
    -- here you need to check the job of the player
    -- example: xPlayer.job.name == "police"

    for i,k in pairs(jobs) do
        if job == k then
            MySQL.Async.fetchAll('SELECT *, DATE_FORMAT(createdAt, "'.. date_format .. '") AS date FROM policereports ORDER BY id DESC', {},
            function(result)
                TriggerClientEvent('lg: openAllReports', idJ, result)
            end)

            break
        end
    end
end)

RegisterNetEvent('lg: openReport')
AddEventHandler('lg: openReport', function()
    local source = source
    local name = GetPlayerName(source)

    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        name = xPlayer.getName()
    end

    -- here you get the player's name
    -- example: xPlayer.getName()
    TriggerClientEvent('lg: openReport', source, name)
end)

RegisterNetEvent('lg: saveReport')
AddEventHandler('lg: saveReport', function(data)
    local idJ = source
    local xPlayer = ESX.GetPlayerFromId(idJ)

    local name = ""
    local str_anonymous = "No"
    local identifier = xPlayer.getIdentifier()

    if data.anonymous then
        name = "Anonymous"
        str_anonymous = "Yes"
    else
        name = data.name
    end

    MySQL.Async.execute('DELETE FROM policereports WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function()
        MySQL.Async.insert('INSERT INTO policereports (identifier, name, number, description) VALUES (@identifier, @name, @number, @description)',
        {
            ['@identifier'] = identifier,
            ['@name'] = name, 
            ['@number'] = data.number, 
            ['@description'] = data.description
        }, function(insertedId)
            TriggerClientEvent("lg: PoliceReportNotify", idJ, translate.TR_NOTIFY_REPORT)

            if insertedId ~= 0 then
                local message = translate.TR_NAME .. ' ' .. data.name .. '\n' ..
                translate.TR_PHONE .. ' ' .. data.number .. '\n' ..
                translate.TR_DESCRIPTION .. ' ' .. data.description .. '\n' ..
                translate.TR_ANONYMOUS .. ' ' .. str_anonymous

                sendWebhook(WEBHOOK.DISCORD_URL, WEBHOOK.DISCORD_TITLE, message, WEBHOOK.COLOR)
                local xPlayers = ESX.GetPlayers()

                for i=1, #xPlayers, 1 do
                    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                    local job = xPlayer.getJob().name

                    for j,k in pairs(jobs) do
                        if job == k then
                            TriggerClientEvent('lg: PoliceReportNotify', xPlayers[i] , translate.TR_NEW_REPORT)
                            break
                        end
                    end
                end
            end
        end)
    end)
end)
 
function sendWebhook(DISCORD_WEBHOOK, DISCORD_TITLE, message, color)
    local send = {
        {
            ["color"] = color,
            ["title"] = DISCORD_TITLE,
            
            ['thumbnail'] = {
                ['url'] = WEBHOOK.SIMBOL_IMG,
                ['height'] = WEBHOOK.HEIGHT_SIMBOL,
                ['width'] = WEBHOOK.WIDTH_SIMBOL
            },
            ["description"] = message,
            ["footer"] = {
                ["text"] = WEBHOOK.DISCORD_FOOTER,
                ['icon_url'] = WEBHOOK.DISCORD_FOOTER_IMG
            },
        }
    }
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = send, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end