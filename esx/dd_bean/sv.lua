ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'beanmachine', 'Bean Machine', true, true)
TriggerEvent('esx_society:registerSociety', 'beanmachine', 'beanmachine', 'society_bean', 'society_bean', 'society_bean', {type = 'public'})

RegisterNetEvent('dd_bean:removeItem')
AddEventHandler('dd_bean:removeItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 5)
end)

RegisterNetEvent('dd_bean:addItem')
AddEventHandler('dd_bean:addItem', function(item)
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
ESX.RegisterServerCallback('dd_bean:coffee_b', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local coffee_powder = xPlayer.getInventoryItem('coffee_powder').count
	local coffee_cup = xPlayer.getInventoryItem('coffee_cup').count
	local coffee_sugar = xPlayer.getInventoryItem('coffee_sugar').count
	local coffee_creamer = xPlayer.getInventoryItem('coffee_creamer').count
	if coffee_powder >= 2 and coffee_cup >= 1 and coffee_sugar >=1  and coffee_creamer >=1 then
		cb(true)
	else
		cb(false)
	end
end)
ESX.RegisterServerCallback('dd_bean:coffee_r', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local coffee_powder = xPlayer.getInventoryItem('coffee_powder').count
	local coffee_cup = xPlayer.getInventoryItem('coffee_cup').count
	local coffee_sugar = xPlayer.getInventoryItem('coffee_sugar').count
	local coffee_creamer = xPlayer.getInventoryItem('coffee_creamer').count
	if coffee_powder >= 1 and coffee_cup >= 1 and coffee_sugar >=1  and coffee_creamer >=1 then
		cb(true)
	else
		cb(false)
	end
end)
ESX.RegisterServerCallback('dd_bean:cappuccino', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local coffee_powder = xPlayer.getInventoryItem('coffee_powder').count
	local coffee_cup = xPlayer.getInventoryItem('coffee_cup').count
	local coffee_sugar = xPlayer.getInventoryItem('coffee_sugar').count
	local coffee_creamer = xPlayer.getInventoryItem('coffee_creamer').count
	if coffee_powder >= 2 and coffee_cup >= 1 and coffee_sugar >=1  and coffee_creamer >=2 then
		cb(true)
	else
		cb(false)
	end
end)
ESX.RegisterServerCallback('dd_bean:sandwich', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local curMoney = xPlayer.getMoney()
	if curMoney >= DD.sandwich then -- and buns >=1 then
		cb(true)
	else
		cb(false)
	end
end)
ESX.RegisterServerCallback('dd_bean:cheesecake', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local curMoney = xPlayer.getMoney()
	if curMoney >= DD.cheesecake then -- and buns >=1 then
		cb(true)
	else
		cb(false)
	end
end)
ESX.RegisterServerCallback('dd_bean:donut', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local curMoney = xPlayer.getMoney()
	if curMoney >= DD.donut then -- and buns >=1 then
		cb(true)
	else
		cb(false)
	end
end)
RegisterNetEvent('dd_bean:assemblingSUCCESSS')
AddEventHandler('dd_bean:assemblingSUCCESSS', function(tae, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(tae, count)
	TriggerClientEvent('okokNotify:Alert', source, "", "You have successfully created a menu", 3000, 'success')
	if tae == 'coffee_b' then
		xPlayer.removeInventoryItem('coffee_powder', 2)
		xPlayer.removeInventoryItem('coffee_cup', 1)
		xPlayer.removeInventoryItem('coffee_sugar', 1)
		xPlayer.removeInventoryItem('coffee_creamer', 1)
	elseif tae == 'coffee_r' then
		xPlayer.removeInventoryItem('coffee_powder', 1)
		xPlayer.removeInventoryItem('coffee_cup', 1)
		xPlayer.removeInventoryItem('coffee_sugar', 1)
		xPlayer.removeInventoryItem('coffee_creamer', 1)
	elseif tae == 'cappuccino' then
		xPlayer.removeInventoryItem('coffee_powder', 2)
		xPlayer.removeInventoryItem('coffee_cup', 1)
		xPlayer.removeInventoryItem('coffee_sugar', 1)
		xPlayer.removeInventoryItem('coffee_creamer', 2)
	elseif tae == 'sandwich' then
		xPlayer.removeMoney(DD.sandwich)
	elseif tae == 'cheesecake' then
		xPlayer.removeMoney(DD.cheesecake)
	elseif tae == 'donut' then
		xPlayer.removeMoney(DD.donut)
	end
end)

RegisterServerEvent('dd_bean:OrderCL')
AddEventHandler('dd_bean:OrderCL', function(product)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local buyer = xPlayer.getName()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'beanmachine' then
			TriggerClientEvent('okokNotify:Alert', xPlayers[i], "🍵🥪🧁 Bean Machine", "Name: "..buyer.." Order 1 piece of "..product, 10000, 'success')
		end
	end
end)
--------------------//ON OFF DUTY//------------------------------
-----------------------//ON OFF DUTY//--------------------------
RegisterServerEvent('offDuty:bean')
AddEventHandler('offDuty:bean', function(job)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.job.name == 'beanmachine' then
		xPlayer.setJob('offbeanmachine',  xPlayer.job.grade)
		TriggerClientEvent('okokNotify:Alert', source, "", "You are now Off Duty", 10000, 'success')
	end
end)
RegisterServerEvent('onDuty:offbean')
AddEventHandler('onDuty:offbean', function(job)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.job.name == 'offbeanmachine' then
		xPlayer.setJob('beanmachine',  xPlayer.job.grade)
		TriggerClientEvent('okokNotify:Alert', source, "", "You are now On Duty", 10000, 'success')
	end
end)
