ESX = nil
local playersProcessingcannabis = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('diaz_mantar:sellDrug')
AddEventHandler('diaz_mantar:sellDrug', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = Config.DrugDealerItems[itemName]
	local xItem = xPlayer.getInventoryItem(itemName)

	if not price then
		print(('diaz_mantar: %s attempted to sell an invalid drug!'):format(xPlayer.identifier))
		return
	end

	if xItem.count < amount then
		xPlayer.showNotification(_U('dealer_notenough'))
		return
	end

	price = ESX.Math.Round(price * amount)

	if Config.GiveBlack then
		xPlayer.addAccountMoney('black_money', price)
	else
		xPlayer.addMoney(price)
	end

	xPlayer.removeInventoryItem(xItem.name, amount)
	xPlayer.showNotification(_U('dealer_sold', amount, xItem.label, ESX.Math.GroupDigits(price)))
end)

ESX.RegisterServerCallback('diaz_mantar:buyLicense', function(source, cb, licenseName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local license = Config.LicensePrices[licenseName]

	if license then
		if xPlayer.getMoney() >= license.price then
			xPlayer.removeMoney(license.price)

			TriggerEvent('esx_license:addLicense', source, licenseName, function()
				cb(true)
			end)
		else
			cb(false)
		end
	else
		print(('diaz_mantar: %s attempted to buy an invalid license!'):format(xPlayer.identifier))
		cb(false)
	end
end)

RegisterServerEvent('diaz_mantar:pickedUpCannabis')
AddEventHandler('diaz_mantar:pickedUpCannabis', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.canCarryItem('mantar', 1) then
		xPlayer.addInventoryItem('mantar', 1)
	else
		xPlayer.showNotification(_U('mantar_inventoryfull'))
	end
end)

ESX.RegisterServerCallback('diaz_mantar:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(xPlayer.canCarryItem(item, 1))
end)

RegisterServerEvent('diaz_mantar:processCannabis')
AddEventHandler('diaz_mantar:processCannabis', function()
	if not playersProcessingcannabis[source] then
		local _source = source

		playersProcessingcannabis[_source] = ESX.SetTimeout(Config.Delays.mantarProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xmantar = xPlayer.getInventoryItem('mantar')

			if xmantar.count > 2 then
				if xPlayer.canSwapItem('mantar', 2, 'mantarlikek', 1) then
					xPlayer.removeInventoryItem('mantar', 2)
					xPlayer.addInventoryItem('mantarlikek', 1)

					xPlayer.showNotification(_U('mantar_processed'))
				else
					xPlayer.showNotification(_U('mantar_processingfull'))
				end
			else
				xPlayer.showNotification(_U('mantar_processingenough'))
			end

			playersProcessingcannabis[_source] = nil
		end)
	else
		print(('diaz_mantar: %s attempted to exploit mantar processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerId)
	if playersProcessingcannabis[playerId] then
		ESX.ClearTimeout(playersProcessingcannabis[playerId])
		playersProcessingcannabis[playerId] = nil
	end
end

RegisterServerEvent('diaz_mantar:cancelProcessing')
AddEventHandler('diaz_mantar:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	CancelProcessing(playerId)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)
