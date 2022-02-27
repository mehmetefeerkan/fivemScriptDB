ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Oxy Run
RegisterServerEvent('oxydelivery:server')
AddEventHandler('oxydelivery:server', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.StartOxyPayment then
		xPlayer.removeMoney(Config.StartOxyPayment)
		
		TriggerClientEvent("oxydelivery:startDealing", source)
	else
		-- TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yeterli miktarda paran yok'})
		TriggerClientEvent('esx:showNotification', source, 'Yeterli miktarda paran yok') 
	end
end)

RegisterServerEvent('oxydelivery:receiveBigRewarditem')
AddEventHandler('oxydelivery:receiveBigRewarditem', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem(Config.BigRewarditem, 1)
end)
RegisterServerEvent('oxydelivery:paraiade')
AddEventHandler('oxydelivery:paraiade', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addMoney(Config.StartOxyPayment)
end)

 RegisterServerEvent('oxydelivery:receiveoxy')
AddEventHandler('oxydelivery:receiveoxy', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addMoney(Config.Payment / 2)
	xPlayer.removeInventoryItem(Config.Item, Config.OxyAmount)
end)

RegisterServerEvent('oxydelivery:receivemoneyyy')
AddEventHandler('oxydelivery:receivemoneyyy', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addMoney(Config.Payment)
	-- TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = Config.Payment .. '$ kazandın.'})
	TriggerClientEvent('esx:showNotification', source, Config.Payment .. '$ kazandın.') 
	xPlayer.removeInventoryItem(Config.Item, 1)
end)