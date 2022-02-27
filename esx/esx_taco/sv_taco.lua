ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('raider-tacoruns:add')
AddEventHandler('raider-tacoruns:add', function(type, amount, name)
	local xPlayer  = ESX.GetPlayerFromId(source)

	if type == 'money' then
		xPlayer.addMoney(amount)
		local society = (amount / 100)*15 
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_taco', function(account)
			account.addMoney(society)
		end)
	elseif type == 'item' then
		xPlayer.addInventoryItem(name, amount)
	end
end)

RegisterServerEvent('raider-tacoruns:remove')
AddEventHandler('raider-tacoruns:remove', function(type, amount, name)
	local xPlayer  = ESX.GetPlayerFromId(source)

	if type == 'money' then
		xPlayer.removeMoney(amount)
	elseif type == 'item' then
		xPlayer.removeInventoryItem(name, amount)
	end
end)

RegisterServerEvent('raider-tacoruns:check')
AddEventHandler('raider-tacoruns:check', function()
	local xPlayer  = ESX.GetPlayerFromId(source)
	local item = xPlayer.getInventoryItem(Config.Item).count
	local b = false
	if item > 0 then
		b = true
	end
	TriggerClientEvent('raider-tacoruns:check', b)
end)
ESX.RegisterServerCallback('raider-tacoruns:getPlayers', function(source,callback)
	local players = ESX.GetPlayers()
	callback(#players)
end)

RegisterServerEvent('raider-tacoruns:server')
AddEventHandler('raider-tacoruns:server', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= Config.StartTaco then
		xPlayer.removeMoney(Config.StartTaco)
		
	else
		-- TriggerClientEvent('notification', xPlayer, 'Satışa başlamak için yeterli paranız yok', 2)
	end
end)