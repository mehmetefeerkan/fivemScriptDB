ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('matif_headlights:check', function(source, cb, plate)
    local _source = source

    MySQL.Async.fetchScalar('SELECT color FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
    }, function(result)
		cb(result)
	end)
end)

RegisterServerEvent('matif_headlights:set')
AddEventHandler('matif_headlights:set', function(plate, color)
    MySQL.Sync.execute("UPDATE owned_vehicles SET color =@color WHERE plate=@plate",{['@color'] = color, ['@plate'] = plate})
end)

RegisterServerEvent('matif_headlights:install')
AddEventHandler('matif_headlights:install', function(plate)
    local _src = source
    xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getJob().name == 'illegalmechanic' then
        MySQL.Async.fetchScalar('SELECT color FROM owned_vehicles WHERE plate = @plate', {
            ['@plate'] = plate
        }, function(result)
            if result == 'NOT' then
                MySQL.Sync.execute("UPDATE owned_vehicles SET color =@color WHERE plate=@plate",{['@color'] = -1, ['@plate'] = plate})
                xPlayer.showNotification('Xenon renkli far kiti başarıyla takıldı.', _src)
                xPlayer.removeInventoryItem('xenonfarkit', 1)
            elseif result ~= 'NOT' and result ~= nil then
                xPlayer.showNotification('Bu araçta zaten xenon renkli far kiti takılı.', _src)
            else
                xPlayer.showNotification('Bu araca xenon renkli far kiti takılamıyor!', _src)
            end
        end)
    else
        xPlayer.showNotification('İllegal mekanik değilsin!', _src)
    end
end)

ESX.RegisterUsableItem('xenonfarkit', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerClientEvent('rgbfar:tak', _source)

end)

ESX.RegisterUsableItem('xenonrgb', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent('rgbfar:kullan', _source)

end)


-- function notify(id, message)
--     TriggerClientEvent('esx:showNotification', id, message)
-- end



