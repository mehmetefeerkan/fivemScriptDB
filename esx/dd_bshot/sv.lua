ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'bshot', 'Burger Shot', true, true)
TriggerEvent('esx_society:registerSociety', 'bshot', 'bshot', 'society_bshot', 'society_bshot', 'society_bshot', {type = 'public'})

RegisterNetEvent('dd_bshot:removeItem')
AddEventHandler('dd_bshot:removeItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 1)
end)

RegisterNetEvent('dd_bshot:addItem')
AddEventHandler('dd_bshot:addItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(item)
	if DD.Usinglimit then
		if sourceItem.limit ~= -1 and sourceItem.count > sourceItem.limit then
			TriggerClientEvent('okokNotify:Alert', source, "", "Cannot hold anymore", 3000, 'error')
		else
			xPlayer.addInventoryItem(item, 5)				
		end
	else
		if xPlayer.canCarryItem(item, 5) then
			xPlayer.addInventoryItem(item, 5)
		else
			TriggerClientEvent('okokNotify:Alert', source, "", "You cannot hold more", 3000, 'error')
		end
	end
end)

--------------------------//CRAFTING//---------------------------------
ESX.RegisterServerCallback('dd_bshot:sprunk', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local curMoney = xPlayer.getMoney()
	if curMoney >= DD.sprunk then
		cb(true)
	else
		cb(false)
	end
end)
ESX.RegisterServerCallback('dd_bshot:bleeder', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local c_patty = xPlayer.getInventoryItem('c_patty').count
	local cheese = xPlayer.getInventoryItem('cheese').count
	local buns = xPlayer.getInventoryItem('buns').count
	local chilysauce = xPlayer.getInventoryItem('chilysauce').count
	if c_patty >= 2 and cheese >= 1 and buns >=1 and chilysauce >= 1 then
		cb(true)
	else
		cb(false)
	end
end)
ESX.RegisterServerCallback('dd_bshot:stopper', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local c_patty = xPlayer.getInventoryItem('c_patty').count
	local cheese = xPlayer.getInventoryItem('cheese').count
	local buns = xPlayer.getInventoryItem('buns').count
	local vegetables = xPlayer.getInventoryItem('vegetables').count
	local chilysauce = xPlayer.getInventoryItem('chilysauce').count
	if c_patty >= 4 and cheese >= 4 and buns >=1 and vegetables >= 2 and chilysauce >= 1 then
		cb(true)
	else
		cb(false)
	end
end)

RegisterNetEvent('dd_bshot:assemblingSUCCESSS')
AddEventHandler('dd_bshot:assemblingSUCCESSS', function(tae, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(tae, count)
	-- TriggerClientEvent('okokNotify:Alert', source, "", "You have successfully created a menu", 3000, 'success')
	if tae == 'sprunk' then
		xPlayer.removeMoney(DD.sprunk)
	elseif tae == 'bleeder' then
		xPlayer.removeInventoryItem('c_patty', 2)
		xPlayer.removeInventoryItem('cheese', 1)
		xPlayer.removeInventoryItem('buns', 1)
		xPlayer.removeInventoryItem('chilysauce', 1)
	elseif tae == 'stopper' then
		xPlayer.removeInventoryItem('c_patty', 4)
		xPlayer.removeInventoryItem('cheese', 4)
		xPlayer.removeInventoryItem('vegetables', 2)
		xPlayer.removeInventoryItem('buns', 1)
		xPlayer.removeInventoryItem('chilysauce', 1)
	end
end)

RegisterServerEvent('dd_bshot:OrderCL')
AddEventHandler('dd_bshot:OrderCL', function(product)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local buyer = xPlayer.getName()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'bshot' then
			TriggerClientEvent('okokNotify:Alert', xPlayers[i], "🍔 Burger Shot", "Name: "..buyer.." Order 1 piece of "..product, 10000, 'success')
		end
	end
end)
-----------------------//ON OFF DUTY//--------------------------
RegisterServerEvent('offDuty:bshot')
AddEventHandler('offDuty:bshot', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.job.name == 'bshot' then
		xPlayer.setJob('offbshot',  xPlayer.job.grade)
		TriggerClientEvent('okokNotify:Alert', source, "", "You are now Off Duty", 10000, 'success')
	end
end)
RegisterServerEvent('onDuty:offbshot')
AddEventHandler('onDuty:offbshot', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.job.name == 'offbshot' then
		xPlayer.setJob('bshot',  xPlayer.job.grade)
		TriggerClientEvent('okokNotify:Alert', source, "", "You are now On Duty", 10000, 'success')
	end
end)
