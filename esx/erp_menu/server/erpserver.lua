ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen['CreateThread'](function()
    MySQL['Async']['execute']([[ALTER TABLE `users` ADD COLUMN IF NOT EXISTS `animations` LONGTEXT]])
end)

ESX['RegisterServerCallback']('8x_erp:get_favorites', function(source, cb)
    local xPlayer = ESX['GetPlayerFromId'](source)

    MySQL['Async']['fetchScalar']("SELECT animations FROM users WHERE identifier=@identifier", {['@identifier'] = xPlayer['identifier']}, function(result)
        if not result then
            MySQL['Async']['execute']([[
                UPDATE `users` SET animations=@animations WHERE identifier=@identifier
            ]], {
                ['@animations'] = '{}',
                ['@identifier'] = xPlayer['identifier'],
            })
            cb('{}')
        else
            cb(result or '{}')
        end
    end)
end)

RegisterServerEvent('8x_erp:update_favorites')
AddEventHandler('8x_erp:update_favorites', function(animations)
    local xPlayer = ESX['GetPlayerFromId'](source)

    MySQL['Async']['execute']([[
        UPDATE `users` SET animations=@animations WHERE identifier=@identifier
    ]], {
        ['@animations'] = animations,
        ['@identifier'] = xPlayer['identifier'],
    })

    if Config['pNotify'] then
        pNotify(xPlayer['source'], Strings['Updated_Favorites'], 'success', 3500)
    else
        TriggerClientEvent('esx:showNotification', xPlayer['source'], Strings['Updated_Favorites'])
    end
end)

RegisterServerEvent('8x_erp:syncAccepted')
AddEventHandler('8x_erp:syncAccepted', function(requester, id)
    local accepted = source
    
    TriggerClientEvent('8x_erp:playSynced', accepted, requester, id, 'Accepter')
    TriggerClientEvent('8x_erp:playSynced', requester, accepted, id, 'Requester')
end)

RegisterServerEvent('8x_erp:requestSynced')
AddEventHandler('8x_erp:requestSynced', function(target, id)
    local requester = source
    local xPlayer = ESX['GetPlayerFromId'](requester)
    
    MySQL['Async']['fetchScalar']("SELECT firstname FROM users WHERE identifier=@identifier", {['@identifier'] = xPlayer['identifier']}, function(firstname)
        TriggerClientEvent('8x_erp:syncRequest', target, requester, id, firstname)
    end)
end)

pNotify = function(src, message, messagetype, messagetimeout)
    TriggerClientEvent("pNotify:SendNotification", src, {
        text = (message),
        type = messagetype,
        timeout = (messagetimeout),
        layout = "bottomCenter",
        queue = "global"
    })
end