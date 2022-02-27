ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local PlayercurrentTattoos = {}

ESX.RegisterServerCallback('esx_tattooshop:requestPlayerTattoos', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		MySQL.Async.fetchAll('SELECT tattoos FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			if result[1].tattoos then
				cb(json.decode(result[1].tattoos))
			else
				cb()
			end
		end)
	else
		cb()
	end
end)

RegisterServerEvent('esx_tattooshop:purchaseTattoo')
AddEventHandler('esx_tattooshop:purchaseTattoo', function(PlayercurrentTattoos, target, tattoo)
	local xPlayer = ESX.GetPlayerFromId(target)
		table.insert(PlayercurrentTattoos, tattoo)
		MySQL.Async.execute('UPDATE users SET tattoos = @tattoos WHERE identifier = @identifier',
		{
			['@tattoos'] = json.encode(PlayercurrentTattoos),
			['@identifier'] = xPlayer.identifier
		}, function(rowsChanged)
			
		end)
		TriggerClientEvent('esx_tattooshop:buySuccess', source)
end)

RegisterServerEvent('esx_tattooshop:jecherche')
AddEventHandler('esx_tattooshop:jecherche', function(target)
	local xPlayer = ESX.GetPlayerFromId(target)
	MySQL.Async.fetchAll('SELECT tattoos FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		if result[1].tattoos then
			PlayercurrentTattoos = json.decode(result[1].tattoos)
		end
	end)
	TriggerClientEvent("esx_tattooshop:setSkin", source, target, PlayercurrentTattoos)
end)

------------------------------------------------------------------------------------------------------------------------ Target

RegisterServerEvent('esx_tattooshop:resetSkin')
AddEventHandler('esx_tattooshop:resetSkin', function(targetId)
	TriggerClientEvent("esx_tattooshop:resetSkin", targetId)
end)

RegisterServerEvent('esx_tattooshop:setPedSkin')
AddEventHandler('esx_tattooshop:setPedSkin', function(targetId)
	TriggerClientEvent("esx_tattooshop:setPedSkin", targetId)
end)

RegisterServerEvent('esx_tattooshop:setSkin')
AddEventHandler('esx_tattooshop:setSkin', function(skin, target, currentTattoos)
	_source = source
	targetid = target
	TriggerClientEvent("esx_tattooshop:setSkin", source, skin, target, currentTattoos) -- _source
end)

RegisterServerEvent('esx_tattooshop:getSkin')
AddEventHandler('esx_tattooshop:getSkin', function(player)
	target = player
	_source = source
	TriggerClientEvent("esx_tattooshop:getSkin", source, target)
end)

RegisterServerEvent('esx_tattooshop:change')
AddEventHandler('esx_tattooshop:change', function(targetId, collection, name)
	TriggerClientEvent("esx_tattooshop:change", targetId, collection, name)
end)

RegisterServerEvent('esx_tattooshop:delete')
AddEventHandler('esx_tattooshop:delete', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= 50000 then
		xPlayer.removeMoney(50000)
		MySQL.Async.execute('UPDATE users SET tattoos = "{}" WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		}, function(rowsChanged)
			TriggerClientEvent('esx_tattooshop:reloadTattoos', _source)
			TriggerClientEvent('okokNotify:Alert', _source, "", "All tattoos have been removed", 5000, 'success')
		end)
	else
		TriggerClientEvent('okokNotify:Alert', _source, "", "You don't have enough cash", 5000, 'error')
	end
end)

-- Item use
-- ESX.RegisterUsableItem('tattoo_mx', function(source)
-- 	local xPlayer  = ESX.GetPlayerFromId(source)
-- 	TriggerClientEvent('Iz_tattoo:tattoo_use', source)
-- 	-- TriggerClientEvent('okokNotify:Alert', source, "", "You used Tattoo Machine", 5000, 'success')
-- end)
RegisterCommand('tattoo', function(source)
	local xPlayer  = ESX.GetPlayerFromId(source)
	TriggerClientEvent('Iz_tattoo:tattoo_use', source)
	-- TriggerClientEvent('okokNotify:Alert', source, "", "You used Tattoo Machine", 5000, 'success')
end)
RegisterServerEvent('Iz_tattoo:removeencre')
AddEventHandler('Iz_tattoo:removeencre', function()
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('encre', 1)
end)




ESX.RegisterServerCallback('dd_tattoo:checkAvailability', function(source, cb, shopId, shopkey)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	MySQL.Async.fetchAll('SELECT * FROM users_shops WHERE shopname = @shopId', { 
		['@shopId'] = shopId,
	}, function(result) 	
		if result[1].is_occupied ~= nil then
			if result[1].owner == xPlayer.identifier then
				cb(true)
			else
				TriggerClientEvent('okokNotify:Alert', src, "", "This shop is already occupied.", 5000, 'success')
			end
		else
			cb(false)
		end
	end)
end)

RegisterServerEvent('dd_tattoo:startRenting')
AddEventHandler('dd_tattoo:startRenting', function(shopId, shopName, shopkey, price) 
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	MySQL.Async.fetchAll('SELECT * FROM users_shop WHERE owner = @identifier', { 
		['@identifier'] = xPlayer.identifier 
	}, function(result)
		if result[1] == nil then
			if xPlayer.getMoney() >= price then
				MySQL.Async.execute('INSERT INTO users_shop (owner, shop) VALUES (@identifier, @shopId)', {
					['@identifier'] = xPlayer.identifier,
					['@shopId'] = shopId
				})
				MySQL.Async.execute('UPDATE users_shops SET is_occupied = @is_occupied WHERE shopname = @shopId', {
					['@is_occupied'] = 'owned',
					['@shopId'] = shopId
				})
				MySQL.Async.execute('UPDATE users_shops SET owner = @owner WHERE shopname = @shopId', {
					['@owner'] = xPlayer.identifier,
					['@shopId'] = shopId				
				})
				xPlayer.removeMoney(price)
				local uniqueIdentifier = shopkey.."_Stash"          
				local inventoryType = "inventory"                           
				local inventorySubType = "housing"                             
				local inventoryLabel = "shop_storage"                         
				local maxWeight = 500.0                                          
				local maxSlots = 50                                             
				local items = exports["mf-inventory"]:buildInventoryItems({})
				exports["mf-inventory"]:createInventory(uniqueIdentifier,inventoryType,inventorySubType,inventoryLabel,maxWeight,maxSlots,items)
				TriggerClientEvent('okokNotify:Alert', src, "", "You started renting " ..shopName.. ". You will be charged "..Config.DailyRentPrice.." for daily rent", 3000, 'success')
			else
				TriggerClientEvent('okokNotify:Alert', src, "", "You don't have enough cash to buy business.", 3000, 'success')
			end
		else
			TriggerClientEvent('okokNotify:Alert', src, "", "You've already rented a shop, cancel it first.", 3000, 'success')
		end
	end)
end)
RegisterServerEvent('dd_tattoo:stopRenting')
AddEventHandler('dd_tattoo:stopRenting', function(shopId, shopName,shopkey) 
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	MySQL.Async.fetchAll('SELECT * FROM users_shop WHERE shop = @shopId AND owner = @identifier', { 
		['@shopId'] = shopId, 
		['@identifier'] = xPlayer.identifier 
	}, function(result)
		if result[1] ~= nil then
			MySQL.Async.execute('DELETE from users_shop WHERE shop = @shopId AND owner = @identifier', {
				['@shopId'] = shopId,
				['@identifier'] = xPlayer.identifier
			})
			MySQL.Async.execute('UPDATE users_shops SET is_occupied = @is_occupied WHERE shopname = @shopId', {
				['@is_occupied'] = nil,
				['@shopId'] = shopId
			})
			MySQL.Async.execute('UPDATE users_shops SET owner = @owner WHERE shopname = @shopId', {
				['@owner'] = nil,
				['@shopId'] = shopId				
			})

			local uniqueIdentifier = shopkey.."_Stash"
			exports["mf-inventory"]:deleteInventory(uniqueIdentifier)
			TriggerClientEvent('okokNotify:Alert', src, "", "You cancelled renting this shop.", 3000, 'success')
		else
			TriggerClientEvent('okokNotify:Alert', src, "", "You don't own this shop.", 3000, 'success')
		end
	end)
end)

function PayLockerRent(d, h, m)
	MySQL.Async.fetchAll('SELECT * FROM users_shop', {}, function(result)
		for i=1, #result, 1 do
			local xPlayer = ESX.GetPlayerFromIdentifier(result[i].owner)
			if xPlayer then
				xPlayer.removeAccountMoney('bank', Config.DailyRentPrice)
				TriggerClientEvent('okokNotify:Alert', xPlayer.source, "", "You paid "..Config.DailyRentPrice.." for the shop rental.", 5000, 'success')
			else
				MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
					['@identifier'] = result[i].owner,
					['@sender'] = 'City Hall',
					['@target_type'] = 'society',
					['@target'] = 'society_bank',
					['@label'] = 'Business Offline Payment',
					['@amount'] = Config.DailyRentPrice
				}, function(result)
				end)
			end
		end
	end)
end

TriggerEvent('cron:runAt', 22, 0, PayLockerRent)