ESX = nil
local doorInfo = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_doorlock:updateState')
AddEventHandler('esx_doorlock:updateState', function(doorID, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	if type(doorID) ~= 'number' then
		print(('esx_doorlock: %s didn\'t send a number!'):format(xPlayer.identifier))
		return
	end

	if type(state) ~= 'boolean' then
		print(('esx_doorlock: %s attempted to update invalid state!'):format(xPlayer.identifier))
		return
	end

	if not Config.DoorList[doorID] then
		print(('esx_doorlock: %s attempted to update invalid door!'):format(xPlayer.identifier))
		return
	end

	if not IsAuthorized(xPlayer.job.name, Config.DoorList[doorID]) then
		print(('esx_doorlock: %s was not authorized to open a locked door!'):format(xPlayer.identifier))
		return
	end

	doorInfo[doorID] = state

	TriggerClientEvent('esx_doorlock:setState', -1, doorID, state)
end)

ESX.RegisterServerCallback('esx_doorlock:getDoorInfo', function(source, cb)
	cb(doorInfo)
end)

function IsAuthorized(jobName, doorID)
	for _,job in pairs(doorID.authorizedJobs) do
		if job == jobName then
			return true
		end
	end

	return false
end

RegisterServerEvent('esx_doorlock:hack')
AddEventHandler('esx_doorlock:hack', function(mycb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	
				if xPlayer.getInventoryItem('keycard').count >= 1 then
				xPlayer.removeInventoryItem('keycard', 1)

					TriggerClientEvent('esx_doorlock:currentlyhacking', source)
	end
end)