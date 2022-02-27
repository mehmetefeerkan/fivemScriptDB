ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('silencieux', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
    TriggerClientEvent('eden_accesories:silencieux', source)
	xPlayer.removeInventoryItem(silencieux, 1)
end)

ESX.RegisterUsableItem('flashlight', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)	
	
    TriggerClientEvent('eden_accesories:flashlight', source)
	xPlayer.removeInventoryItem(flashlight, 1)
end)

ESX.RegisterUsableItem('grip', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
		
    TriggerClientEvent('eden_accesories:grip', source)
	xPlayer.removeInventoryItem(grip, 1)
end)


ESX.RegisterUsableItem('yusuf', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('eden_accesories:yusuf', source)
xPlayer.removeInventoryItem(yusuf ,1)
end)

