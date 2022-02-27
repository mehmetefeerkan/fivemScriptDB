ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterUsableItem('beer', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('beer', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_beer'))

end)

ESX.RegisterUsableItem('adrenaline_shot', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('adrenaline_shot', 1) -- item name and how many removed on usage
	TriggerClientEvent('esx_optionalneeds:onAdrenaline', source)
end)
