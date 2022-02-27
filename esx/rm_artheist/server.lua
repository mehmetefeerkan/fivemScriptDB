ESX = nil
local lastrob = 0

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

ESX.RegisterServerCallback('artheist:server:checkRobTime', function(source, cb)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    
    if (os.time() - lastrob) < Config['ArtHeist']['nextRob'] and lastrob ~= 0 then
        local seconds = Config['ArtHeist']['nextRob'] - (os.time() - lastrob)
        TriggerClientEvent('okokNotify:Alert', player, "", Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'], 5000, 'error')
        cb(false)
    else
        lastrob = os.time()
        cb(true)
    end
end)

RegisterNetEvent('artheist:server:policeAlert')
AddEventHandler('artheist:server:policeAlert', function(coords)
    local players = ESX.GetPlayers()
    
    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            TriggerClientEvent('artheist:client:policeAlert', players[i], coords)
        end
    end
end)

RegisterServerEvent('artheist:server:syncHeistStart')
AddEventHandler('artheist:server:syncHeistStart', function()
    TriggerClientEvent('artheist:client:syncHeistStart', -1)
end)

RegisterServerEvent('artheist:server:syncPainting')
AddEventHandler('artheist:server:syncPainting', function(x)
    TriggerClientEvent('artheist:client:syncPainting', -1, x)
end)

RegisterServerEvent('artheist:server:syncAllPainting')
AddEventHandler('artheist:server:syncAllPainting', function()
    TriggerClientEvent('artheist:client:syncAllPainting', -1)
end)

RegisterServerEvent('artheist:server:rewardItem')
AddEventHandler('artheist:server:rewardItem', function(scene)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local item = scene['rewardItem']

    if player then
        player.addInventoryItem(item, 1)
    end
end)

RegisterServerEvent('artheist:server:finishHeist')
AddEventHandler('artheist:server:finishHeist', function()
    local src = source
    local player = ESX.GetPlayerFromId(src)

    if player then
        for k, v in pairs(Config['ArtHeist']['painting']) do
            local rdm = math.random(0,math.random(0,1))
            local count = player.getInventoryItem(v['rewardItem']).count
            if count > 0 then
                player.removeInventoryItem(v['rewardItem'], 1)
                player.addMoney(v['paintingPrice'])
                if rdm == 1 then
                    player.removeInventoryItem('mutations', 1)
                end
            end
        end
    end
end)