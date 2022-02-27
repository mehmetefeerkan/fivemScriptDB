ESX = nil
local Usinglimit = false
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- [[HARVESTING]]--
RegisterServerEvent('dd_jobs:startHarvest')
AddEventHandler('dd_jobs:startHarvest', function(itemNeeded, Part, rdm)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemNeeded)
	if Usinglimit then
		if sourceItem.limit ~= -1 and sourceItem.count > sourceItem.limit then
			TriggerClientEvent('okokNotify:Alert', source, "", "You cannot hold more", 3000, 'error')
			TriggerClientEvent(Part..':Full', source, true)
		else
			xPlayer.addInventoryItem(itemNeeded, rdm)			
		end
	else
		if xPlayer.canCarryItem(itemNeeded, rdm) then
			xPlayer.addInventoryItem(itemNeeded, rdm)
		else
			TriggerClientEvent('okokNotify:Alert', source, "", "You cannot hold more", 3000, 'error')
			TriggerClientEvent(Part..':Full', source, true)
		end
	end
end)
--[[ITEM CHECKING]]--
RegisterServerEvent('dd_jobs:startCheck')
AddEventHandler('dd_jobs:startCheck', function(itemNeeded,Part,a,b)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local nItem = xPlayer.getInventoryItem(itemNeeded)
	if nItem.count > 0 then
		TriggerClientEvent('dd_jobs:start'..Part, _source, itemNeeded,a,b)
	else
		TriggerClientEvent('okokNotify:Alert', _source, "", 'Not enough item to start a task', 6000, 'error')
	end
end)
--[[PROCESSING]]--
RegisterServerEvent('dd_jobs:startProcess')
AddEventHandler('dd_jobs:startProcess', function(itemNeeded,itemReturn,qty)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemReturn)
	local xItem = xPlayer.getInventoryItem(itemNeeded)
	if xItem.count < qty then
		TriggerClientEvent('okokNotify:Alert', source, "", 'Not enough item to process', 6000, 'error')
	else
		if Usinglimit then
			if sourceItem.limit ~= -1 and sourceItem.count > sourceItem.limit then
				TriggerClientEvent('okokNotify:Alert', source, "", "You cannot hold more", 3000, 'error')
			else
				xPlayer.removeInventoryItem(itemNeeded, qty)
				xPlayer.addInventoryItem(itemReturn, qty)			
			end
		else
			if xPlayer.canCarryItem(itemReturn, qty) then
				xPlayer.removeInventoryItem(itemNeeded, qty)
				xPlayer.addInventoryItem(itemReturn, qty)
			else
				TriggerClientEvent('okokNotify:Alert', source, "", "You cannot hold more", 3000, 'error')
			end
		end
	end
end)
RegisterServerEvent('dd_jobs:startProcess1')
AddEventHandler('dd_jobs:startProcess1', function(itemNeeded,qty)
	local xPlayer = ESX.GetPlayerFromId(source)

	local sourceItem1 = xPlayer.getInventoryItem('iron')
	local sourceItem2 = xPlayer.getInventoryItem('copper')
	local sourceItem3 = xPlayer.getInventoryItem('silver')
	local sourceItem4 = xPlayer.getInventoryItem('gold')
	local sourceItem5 = xPlayer.getInventoryItem('steel_pooch')
	local a,b,c,d,e=math.random(1,2),math.random(2,3),math.random(1,2),math.random(1,2),math.random(2,4)

	local xItem = xPlayer.getInventoryItem(itemNeeded)
	if xItem.count <= qty then
		TriggerClientEvent('okokNotify:Alert', source, "", 'Not enough item to process', 6000, 'error')
	else
		if Usinglimit then
			
			if (sourceItem1.limit ~= -1 and sourceItem1.count > sourceItem1.limit) or
				(sourceItem2.limit ~= -1 and sourceItem2.count > sourceItem2.limit) or
				(sourceItem3.limit ~= -1 and sourceItem3.count > sourceItem3.limit) or
				(sourceItem4.limit ~= -1 and sourceItem4.count > sourceItem4.limit) or
				(sourceItem5.limit ~= -1 and sourceItem5.count > sourceItem5.limit) then
					TriggerClientEvent('okokNotify:Alert', source, "", "You cannot hold more", 3000, 'error')
			else
				xPlayer.removeInventoryItem(itemNeeded, qty)
				xPlayer.addInventoryItem('iron', a)	
				xPlayer.addInventoryItem('copper', b)	
				xPlayer.addInventoryItem('silver', c)	
				xPlayer.addInventoryItem('gold', d)	
				xPlayer.addInventoryItem('steel_pooch', e)
				TriggerClientEvent('okokNotify:Alert', source, "", 'Melted: '..a..' Iron, '..b..' Copper, '..c..' Silver, '..e..' Steel and '..d..' Gold.', 6000, 'success')		
			end
		else
			if xPlayer.canCarryItem('iron', a) then
				xPlayer.addInventoryItem('iron', a)
			else
				TriggerClientEvent('okokNotify:Alert', source, "", "You cannot hold more iron", 3000, 'error')
			end
			if xPlayer.canCarryItem('copper', b) then
				xPlayer.addInventoryItem('copper', b)
			else
				TriggerClientEvent('okokNotify:Alert', source, "", "You cannot hold more copper", 3000, 'error')
			end
			if xPlayer.canCarryItem('silver', c) then
				xPlayer.addInventoryItem('silver', c)
			else
				TriggerClientEvent('okokNotify:Alert', source, "", "You cannot hold more silver", 3000, 'error')
			end
			if xPlayer.canCarryItem('gold', d) then
				xPlayer.addInventoryItem('gold', d)
			else
				TriggerClientEvent('okokNotify:Alert', source, "", "You cannot hold more gold", 3000, 'error')
			end
			if xPlayer.canCarryItem('steel_pooch', e) then
				xPlayer.addInventoryItem('steel_pooch', e)
			else
				TriggerClientEvent('okokNotify:Alert', source, "", "You cannot hold more steel", 3000, 'error')
			end
			xPlayer.removeInventoryItem(itemNeeded, qty)
		end
	end
end)
--[[RESELL]]--
RegisterServerEvent('dd_jobs:startResell')
AddEventHandler('dd_jobs:startResell', function(product,rndmqlty)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local Count = xPlayer.getInventoryItem(product).count
	local GTotal = Count * rndmqlty
	xPlayer.removeInventoryItem(product, Count)
	xPlayer.addMoney(GTotal)
end)
--[[SYNC SMOKE]]--
RegisterServerEvent('dd_jobs:SyncSmoke')
AddEventHandler('dd_jobs:SyncSmoke', function(x,y,z)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('dd_jobs:SyncSmoke',xPlayers[i],x,y,z,'a') 
	end		
end)

RegisterServerEvent('sidejobs.cansell')
AddEventHandler('sidejobs.cansell', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer.getInventoryItem('cacao').count >= 1 or
		xPlayer.getInventoryItem('potato').count >= 1 or 
		xPlayer.getInventoryItem('tomato').count >= 1 or
		xPlayer.getInventoryItem('lettuce').count >= 1 or
		xPlayer.getInventoryItem('coffee_beans').count >= 1 or
		xPlayer.getInventoryItem('milk').count >= 1
		then
		TriggerClientEvent('sidejobs.cansell', _source)
	else
		TriggerClientEvent('okokNotify:Alert', _source, "", 'Not enough product to sell', 6000, 'info')
	end
end)