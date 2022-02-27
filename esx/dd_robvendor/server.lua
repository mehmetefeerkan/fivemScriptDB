ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local deadPeds = {}

RegisterServerEvent('dd_robvendor:pedDead')
AddEventHandler('dd_robvendor:pedDead', function(store)
    if not deadPeds[store] then
        deadPeds[store] = 'deadlol'
        TriggerClientEvent('dd_robvendor:onPedDeath', -1, store)
        local second = 1000
        local minute = 60 * second
        local hour = 60 * minute
        local cooldown = Config.Shops[store].cooldown
        local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
        Wait(wait)
        if not Config.Shops[store].robbed then
            for k, v in pairs(deadPeds) do if k == store then table.remove(deadPeds, k) end end
            TriggerClientEvent('dd_robvendor:resetStore', -1, store)
        end
    end
end)

RegisterServerEvent('dd_robvendor:handsUp')
AddEventHandler('dd_robvendor:handsUp', function(store)
    TriggerClientEvent('dd_robvendor:handsUp', -1, store)
end)

RegisterServerEvent('dd_robvendor:pickUp')
AddEventHandler('dd_robvendor:pickUp', function(store)
    local xPlayer = ESX.GetPlayerFromId(source)
    local randomAmount = math.random(Config.Shops[store].money[1], Config.Shops[store].money[2])
    xPlayer.addMoney(randomAmount)
    TriggerClientEvent('esx:showNotification', source, Translation[Config.Locale]['cashrecieved'] .. ' ~g~' .. randomAmount .. ' ' .. Translation[Config.Locale]['currency'])
    TriggerClientEvent('dd_robvendor:removePickup', -1, store) 
end)

ESX.RegisterServerCallback('dd_robvendor:canRob', function(source, cb, store)
    local cops = 0
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            cops = cops + 1
        end
    end
    if cops >= Config.Shops[store].cops then
        if not Config.Shops[store].robbed and not deadPeds[store] then
            cb(true)
        else
            cb(false)
        end
    else
        cb('no_cops')
    end
end)

RegisterServerEvent('dd_robvendor:rob')
AddEventHandler('dd_robvendor:rob', function(store)
    local src = source
    Config.Shops[store].robbed = true
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            TriggerClientEvent('dd_robvendor:msgPolice', xPlayer.source, store, src)
        end
    end
    TriggerClientEvent('dd_robvendor:rob', -1, store)
    Wait(30000)
    TriggerClientEvent('dd_robvendor:robberyOver', src)

    local second = 1000
    local minute = 60 * second
    local hour = 60 * minute
    local cooldown = Config.Shops[store].cooldown
    local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
    Wait(wait)
    Config.Shops[store].robbed = false
    for k, v in pairs(deadPeds) do if k == store then table.remove(deadPeds, k) end end
    TriggerClientEvent('dd_robvendor:resetStore', -1, store)
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #deadPeds do TriggerClientEvent('dd_robvendor:pedDead', -1, i) end -- update dead peds
        Citizen.Wait(500)
    end
end)
