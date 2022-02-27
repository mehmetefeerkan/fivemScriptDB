ESX                = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'mechanic', 'Alert Mechanic', true, true)
TriggerEvent('esx_society:registerSociety', 'mechanic', 'mechanic', 'society_mechanic', 'society_mechanic', 'society_mechanic', {type = 'public'})

RegisterNetEvent('dd_mech:removeItem')
AddEventHandler('dd_mech:removeItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 1)
end)
-------------------------//JOB BLIPS----------------------------------------------------------------------------------
AddEventHandler('playerDropped', function()
	local playerId = source
	if playerId then
		local xPlayer = ESX.GetPlayerFromId(playerId)
		if xPlayer and xPlayer.job.name == 'mechanic' then
			Citizen.Wait(5000)
			TriggerClientEvent('dd_mech:updateBlip', -1)
		end
	end
end)

RegisterNetEvent('dd_mech:spawned')
AddEventHandler('dd_mech:spawned', function()
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer and xPlayer.job.name == 'mechanic' then
		Citizen.Wait(5000)
		TriggerClientEvent('dd_mech:updateBlip', -1)
	end
end)

RegisterNetEvent('dd_mech:forceBlip')
AddEventHandler('dd_mech:forceBlip', function()
	TriggerClientEvent('dd_mech:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('dd_mech:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'mechanic')
	end
end)
-----------------------//ON OFF DUTY//--------------------------
RegisterServerEvent('offDuty:mechanic')
AddEventHandler('offDuty:mechanic', function(job)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.job.name == 'mechanic' then
		xPlayer.setJob('offmechanic',  xPlayer.job.grade)
		TriggerClientEvent('okokNotify:Alert', _source, "MECH", "You are now off duty", 3000, 'info')
	end
end)
RegisterServerEvent('onDuty:offmechanic')
AddEventHandler('onDuty:offmechanic', function(job)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.job.name == 'offmechanic' then
		xPlayer.setJob('mechanic',  xPlayer.job.grade)
		TriggerClientEvent('okokNotify:Alert', _source, "MECH", "You are now on duty", 3000, 'info')
	end
end)

ESX.RegisterUsableItem('tyrekit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('dd_mech:fixTyre', source)
end)

ESX.RegisterUsableItem('repairkit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('dd_mech:repairkit', source)
end)