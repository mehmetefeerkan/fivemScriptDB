ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('kp_bee:pickedUpCannabis')
AddEventHandler('kp_bee:pickedUpCannabis', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('honey_a')
	if xPlayer.canCarryItem('honey_a', 2) then
		xPlayer.addInventoryItem('honey_a', math.random(2,2))
	else
		xPlayer.showNotification('Envanterin Dolu')
	end
		
end)

ESX.RegisterServerCallback('kp_bee:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)
		cb(true)
end)
