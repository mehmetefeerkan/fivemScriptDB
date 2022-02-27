ESX = nil
local lastrob = 0
local start = false
discord = {
    ['webhook'] = 'DISCORDWEBHOOKLINK',
    ['name'] = 'rm_humanelabsheist',
    ['image'] = 'https://cdn.discordapp.com/avatars/869260464775921675/dea34d25f883049a798a241c8d94020c.png?size=1024'
}

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

ESX.RegisterUsableItem(Config['HumaneLabs']['wetsuit']['itemName'], function(source)
    local src = source
    local player = ESX.GetPlayerFromId(src)

    if player then
        TriggerClientEvent('humanelabsheist:client:wearWetsuit', src)
    end
end)

ESX.RegisterServerCallback('humanelabsheist:server:checkPoliceCount', function(source, cb)
    local src = source
    local players = ESX.GetPlayers()
    local policeCount = 0

    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            policeCount = policeCount + 1
        end
    end

    if policeCount >= Config['HumaneLabs']['requiredPoliceCount'] then
        cb(true)
    else
        cb(false)
        TriggerClientEvent('humanelabsheist:client:showNotification', src, Strings['need_police'])
    end
end)

ESX.RegisterServerCallback('humanelabsheist:server:checkTime', function(source, cb)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    
    if (os.time() - lastrob) < Config['HumaneLabs']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['HumaneLabs']['nextRob'] - (os.time() - lastrob)
        TriggerClientEvent('humanelabsheist:client:showNotification', src, Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'])
        cb(false)
    else
        lastrob = os.time()
        start = true
        discordLog(player.getName() ..  ' - ' .. player.getIdentifier(), ' started the Humane Labs. Heist!')
        cb(true)
    end
end)

RegisterServerEvent('humanelabsheist:server:policeAlert')
AddEventHandler('humanelabsheist:server:policeAlert', function(coords)
    local players = ESX.GetPlayers()
    
    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            TriggerClientEvent('humanelabsheist:client:policeAlert', players[i], coords)
        end
    end
end)

RegisterServerEvent('humanelabsheist:server:heistRewards')
AddEventHandler('humanelabsheist:server:heistRewards', function()
    local src = source
    local player = ESX.GetPlayerFromId(src)

    if player then
        if start then
            if Config['HumaneLabs']['rewards']['money'] > 0 then
                player.addMoney(Config['HumaneLabs']['rewards']['money'])
                discordLog(player.getName() ..  ' - ' .. player.getIdentifier(), ' gain $' .. Config['HumaneLabs']['rewards']['money'])
            end

            if Config['HumaneLabs']['rewards']['blackMoney'] > 0 then
                player.addAccountMoney('black_money', Config['HumaneLabs']['rewards']['blackMoney'])
                discordLog(player.getName() ..  ' - ' .. player.getIdentifier(), ' gain $' .. Config['HumaneLabs']['rewards']['blackMoney'] .. 'black money')
            end

            if Config['HumaneLabs']['rewards']['items'] ~= nil then
                for k, v in pairs(Config['HumaneLabs']['rewards']['items']) do
                    local rewardCount = v['count']()
                    player.addInventoryItem(v['name'], rewardCount)
                    discordLog(player.getName() ..  ' - ' .. player.getIdentifier(), ' gain this: ' .. v['name'] .. ' x' .. rewardCount)
                end
            end
            
            start = false
        end
    end
end)
RegisterServerEvent('humane:plantbombtoall')
AddEventHandler('humane:plantbombtoall', function(x,y,z)
    SetTimeout(10000, function()
        TriggerClientEvent('humane:plantedbomb', -1, x,y,z)
        TriggerEvent("dd_news:PostNews", 'Humane Labs')
    end)
end)
function discordLog(name, message)
    local data = {
        {
            ["color"] = '3553600',
            ["title"] = "**".. name .."**",
            ["description"] = message,
        }
    }
    PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = data, avatar_url = discord['image']}), { ['Content-Type'] = 'application/json' })
end