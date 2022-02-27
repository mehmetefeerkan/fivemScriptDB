ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bloodsbandana', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('lexia_bandana:bloodsbandana', source)
end)

ESX.RegisterUsableItem('greenbandana', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('lexia_bandana:greenbandana', source)
end)

ESX.RegisterUsableItem('ballasbandana', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('lexia_bandana:ballasbandana', source)
end)

ESX.RegisterUsableItem('vagosbandana', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('lexia_bandana:vagosbandana', source)
end)

ESX.RegisterUsableItem('cripsbandana', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('lexia_bandana:cripsbandana', source)
end)

ESX.RegisterUsableItem('whitebandana', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('lexia_bandana:whitebandana', source)
end)

ESX.RegisterUsableItem('blackbandana', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('lexia_bandana:blackbandana', source)
end)

ESX.RegisterUsableItem('orangebandana', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('lexia_bandana:orangebandana', source)
end)