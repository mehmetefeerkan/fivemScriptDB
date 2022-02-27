
ESX, bliptable = nil, {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('gps', function(source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if GetCurrentResourceName() == 'm3_gps' then
        if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'ambulance' then
            TriggerClientEvent('m3:gps:client:Used', src)
        end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Script adını m3_gps olarak ayarlayınız!'})
	end
end)

RegisterServerEvent('m3:gps:server:openGPS')
AddEventHandler('m3:gps:server:openGPS', function(code)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    })

    table.insert(bliptable, {firstname = result[1].firstname, lastname = result[1].lastname, src = src, job = xPlayer.job.name, code = code})
end)

RegisterServerEvent('m3:gps:server:closeGPS')
AddEventHandler('m3:gps:server:closeGPS', function()
    local src = source

    for k = 1, #bliptable, 1 do
        TriggerClientEvent('m3:gps:client:removeBlip', bliptable[k].src, tonumber(src))
    end

    for i = 1, #bliptable, 1 do
        if bliptable[i].src == tonumber(src) then
            table.remove(bliptable, i)
            return
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if #bliptable > 0 then
            for i = 1, #bliptable, 1 do
                local player = GetPlayerPed(bliptable[i].src)
                local coord = GetEntityCoords(player)
                for k = 1, #bliptable, 1 do
                    TriggerClientEvent('m3:gps:client:getPlayerInfo', bliptable[k].src, {
                        coord = coord,
                        job = bliptable[i].job,
                        src = tonumber(bliptable[i].src),
                        text = '['..bliptable[i].code..'] - '..bliptable[i].firstname..' '..bliptable[i].lastname,
                    })
                end
            end
        end
    end
end)

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    TriggerClientEvent('m3:gps:client:closed', src)

	if item == 'gps' and count < 1 then
		for k = 1, #bliptable, 1 do
            TriggerClientEvent('m3:gps:client:removeBlip', bliptable[k].src, tonumber(src))
            TriggerClientEvent('m3:gps:client:removeBlip', src, tonumber(bliptable[k].src))
        end
    
        for i = 1, #bliptable, 1 do
            if bliptable[i].src == src then
                table.remove(bliptable, i)
            end
        end
	end
end)

AddEventHandler('playerDropped', function()
    local src = source

    removeBlip(src)
    removeBlip2(src)
end)

function removeBlip(src)
    for k = 1, #bliptable, 1 do
        TriggerClientEvent('m3:gps:client:removeBlip', bliptable[k].src, tonumber(src))
        return
    end
end

function removeBlip2(src)
    for i = 1, #bliptable, 1 do
        if bliptable[i].src == src then
            table.remove(bliptable, i)
            return
        end
    end
end