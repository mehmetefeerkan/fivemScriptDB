ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('energy', function(source)
	TriggerClientEvent('esx_extraitems:redbull', source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('energy', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 50000)
end)