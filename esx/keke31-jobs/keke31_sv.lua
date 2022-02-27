ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('keke31job:add')
AddEventHandler('keke31job:add', function(name, amount)
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(name, amount)
end)

RegisterServerEvent('keke31job:remove')
AddEventHandler('keke31job:remove', function(name, amount)
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(name, amount)
end)

ESX.RegisterServerCallback('keke31:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getQuantity(item)
	cb(quantity)
end)