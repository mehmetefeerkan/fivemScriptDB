ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('np_selltonpc:dodeal')
AddEventHandler('np_selltonpc:dodeal', function(item, price1, price2)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local weedprice = math.random(price1, price2)
		local weedamount = math.random(1, 5)

		local finalamount = weedprice * weedamount

		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You sold ' .. weedamount .. ' for $' .. finalamount, length = 4000 })
		xPlayer.removeInventoryItem(item, weedamount)
		xPlayer.addInventoryItem('cash', finalamount)
		Citizen.Wait(0)
	end
end)

RegisterServerEvent('checkD')
AddEventHandler('checkD', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local weed = xPlayer.getQuantity('weed')
		if weed >= 1 then
			TriggerClientEvent("checkR", source, true)
		else
			TriggerClientEvent("checkR", source, false)
		end
	end
end)

RegisterServerEvent('np_selltonpc:saleInProgress')
AddEventHandler('np_selltonpc:saleInProgress', function(streetName, playerGender)
	if playerGender == 0 then
		playerGender = 'Female'
	else
		playerGender = 'Male'
	end

	TriggerClientEvent('np_selltonpc:policeNotify', -1, 'Drug deal in progress: A ' .. playerGender .. ' has been spotted selling drugs at ' .. streetName)
end)