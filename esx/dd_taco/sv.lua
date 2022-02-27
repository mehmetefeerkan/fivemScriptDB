ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'taco', 'Tacos & Burritos', true, true)
TriggerEvent('esx_society:registerSociety', 'taco', 'taco', 'society_taco', 'society_taco', 'society_taco', {type = 'public'})

RegisterNetEvent('dd_taco:removeItem')
AddEventHandler('dd_taco:removeItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 1)
end)

RegisterNetEvent('dd_taco:addItem')
AddEventHandler('dd_taco:addItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(item)
	if DD.Usinglimit then
		if sourceItem.limit ~= -1 and sourceItem.count > sourceItem.limit then
			TTriggerClientEvent('okokNotify:Alert', source, "", "Cannot hold anymore", 3000, 'error')
		else
			xPlayer.addInventoryItem(item, 5)				
		end
	else
		if xPlayer.canCarryItem(item, 5) then
			xPlayer.addInventoryItem(item, 5)
		else
			TriggerClientEvent('okokNotify:Alert', source, "", "Cannot hold anymore", 3000, 'error')
		end
	end
end)
--------------------------//CRAFTING//---------------------------------
ESX.RegisterServerCallback('dd_taco:taco', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local groundmeat = xPlayer.getInventoryItem('groundmeat').count
	local vegetables = xPlayer.getInventoryItem('vegetables').count
	local tacowrap = xPlayer.getInventoryItem('taco_wrap').count
	if groundmeat >= 1 and vegetables >= 1 and tacowrap >=1 then
		cb(true)
	else
		cb(false)
	end
end)
ESX.RegisterServerCallback('dd_taco:burritos', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local groundmeat = xPlayer.getInventoryItem('groundmeat').count
	local vegetables = xPlayer.getInventoryItem('vegetables').count
	local tacowrap = xPlayer.getInventoryItem('taco_wrap').count
	local chilysauce = xPlayer.getInventoryItem('chilysauce').count
	if groundmeat >= 1 and vegetables >= 1 and tacowrap >=1 and chilysauce >= 1 then
		cb(true)
	else
		cb(false)
	end
end)
ESX.RegisterServerCallback('dd_taco:ecola', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local curMoney = xPlayer.getMoney()
	if curMoney >= DD.ecola then
		cb(true)
	else
		cb(false)
	end
end)

RegisterNetEvent('dd_taco:assemblingSUCCESSS')
AddEventHandler('dd_taco:assemblingSUCCESSS', function(tae, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(tae, count)

	-- TriggerClientEvent('okokNotify:Alert', source, "", "You have successfully created a menu", 3000, 'success')
	if tae == 'taco' then
		xPlayer.removeInventoryItem('groundmeat', 1)
		xPlayer.removeInventoryItem('vegetables', 1)
		xPlayer.removeInventoryItem('taco_wrap', 1)
	elseif tae == 'burritos' then
		xPlayer.removeInventoryItem('groundmeat', 1)
		xPlayer.removeInventoryItem('vegetables', 1)
		xPlayer.removeInventoryItem('taco_wrap', 1)
		xPlayer.removeInventoryItem('chilysauce', 1)
	elseif tae == 'ecola' then
		xPlayer.removeMoney(DD.ecola)
	end
end)

RegisterServerEvent('dd_taco:OrderCL')
AddEventHandler('dd_taco:OrderCL', function(product)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local buyer = xPlayer.getName()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'taco' then
			TriggerClientEvent('okokNotify:Alert', xPlayers[i], "🌭🌮🌯 Tacos & Burritos", "Name: "..buyer.." Order 1 piece of "..product, 10000, 'success')
		end
	end
end)
-----------------------//ON OFF DUTY//--------------------------
RegisterServerEvent('offDuty:taco')
AddEventHandler('offDuty:taco', function(job)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.job.name == 'taco' then
		xPlayer.setJob('offtaco',  xPlayer.job.grade)
		TriggerClientEvent('okokNotify:Alert', _source, "", "You are now Off Duty", 10000, 'success')
	end
end)
RegisterServerEvent('onDuty:offtaco')
AddEventHandler('onDuty:offtaco', function(job)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.job.name == 'offtaco' then
		xPlayer.setJob('taco',  xPlayer.job.grade)
		TriggerClientEvent('okokNotify:Alert', _source, "", "You are now On Duty", 10000, 'success')
	end
end)
