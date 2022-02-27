ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx_policedog:hasClosestDrugs')
AddEventHandler('esx_policedog:hasClosestDrugs', function(playerId)
    local target = ESX.GetPlayerFromId(playerId)
    local src = source
    local inventory = target.inventory
    for i = 1, #inventory do
        for k, v in pairs(Config.Drugs) do
            if inventory[i].name == v and inventory[i].count > 0 then
                TriggerClientEvent('esx_policedog:hasDrugs', src, true)
                return
            end
        end
    end
    TriggerClientEvent('esx_policedog:hasDrugs', src, false)
end)


RegisterServerEvent("hilemigirdi")
AddEventHandler("hilemigirdi", function(reason)
  local _source = source
      local connect = {
            {
                ["color"] = 23295,
                ["title"] = reason,
                ["description"] = "Kullanıcı: "..GetPlayerName(_source).. "\n"  ..GetPlayerIdentifiers(_source)[1].."  ",
                ["footer"] = {
                ["text"] = "4",
                },
            }
        }
      PerformHttpRequest("https://discordapp.com/api/webhooks/777503519246647337/qLM2OdAGGGr2I_mBZgjUxbOZsbY2KW42O1r9YUY26OkOwGD4EAsRZp7K1k5fFxwiqXH3", function(err, text, headers) end, 'POST', json.encode({username = "MIXAS AC", embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end)