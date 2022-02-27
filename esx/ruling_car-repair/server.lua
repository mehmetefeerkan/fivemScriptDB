ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) 
	ESX = obj 
end)

ESX.RegisterUsableItem('fixtool', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('hasan:ontamirkit', source)
end)

RegisterServerEvent("removeitem")
AddEventHandler("removeitem", function(itemname)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem(itemname, 1)
end)

