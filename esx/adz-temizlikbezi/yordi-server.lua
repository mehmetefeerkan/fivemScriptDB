TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('temizlikbezi', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('yordi:cleaningcloth', source)
	xPlayer.removeInventoryItem('temizlikbezi', '1')
	Citizen.Wait(1000)
	xPlayer.addInventoryItem('kirlitemizlikbezi', '1')
end)