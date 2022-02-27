ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('gpsill', function(source)
TriggerClientEvent('gps:menu', source)
end)

RegisterServerEvent('gps:supprimer')
AddEventHandler('gps:supprimer', function()
        local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeInventoryItem('gpsill', 1)
end)