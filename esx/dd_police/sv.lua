ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'police', 'Police Alert', true, true)
TriggerEvent('esx_society:registerSociety', 'police', 'Police', 'society_police', 'society_police', 'society_police', {type = 'public'})

RegisterNetEvent('dd_police:LoadOut')
AddEventHandler('dd_police:LoadOut', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon('WEAPON_STUNGUN', 1)
	Citizen.Wait(1000)
	xPlayer.addInventoryItem('cuff_key', 1)
	Citizen.Wait(1000)
	xPlayer.addInventoryItem('pol_cuff', 3)	
	Citizen.Wait(1000)
	xPlayer.addInventoryItem('radio', 1)
	Citizen.Wait(1000)
	xPlayer.addInventoryItem('badge', 1)			
	Citizen.Wait(1000)
	xPlayer.addInventoryItem('bulletproof', 1)			
end)

RegisterNetEvent('dd_police:putInVehicle')
AddEventHandler('dd_police:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('dd_police:putInVehicle', target)
	else
		print(('dd_police: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('dd_police:OutVehicle')
AddEventHandler('dd_police:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('dd_police:OutVehicle', target)
	else
		print(('dd_police: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

ESX.RegisterServerCallback('dd_police:getOtherPlayerData', function(source, cb, target, notify)
	local xPlayer = ESX.GetPlayerFromId(target)

	TriggerClientEvent('okokNotify:Alert', source, "POLICE", "You are being searched by the Officer", 3000, 'warning')

	if xPlayer then
		local data = {
			name = xPlayer.getName(),
			job = xPlayer.job.label,
			grade = xPlayer.job.grade_label,
			inventory = xPlayer.getInventory(),
			accounts = xPlayer.getAccounts(),
			weapons = xPlayer.getLoadout()
		}

		if Config.EnableESXIdentity then
			data.dob = xPlayer.get('dateofbirth')
			data.height = xPlayer.get('height')

			if xPlayer.get('sex') == 'm' then
				data.sex = 'male'
			end
			if xPlayer.get('sex') == 'f' then
				data.sex = 'female'
			end
		end

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status then
				data.drunk = ESX.Math.Round(status.percent)
			end

			if Config.EnableLicenses then
				TriggerEvent('esx_license:getLicenses', target, function(licenses)
					data.licenses = licenses
					cb(data)
				end)
			else
				cb(data)
			end
		end)
	end
end)

ESX.RegisterServerCallback('dd_police:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('dd_police:getVehicleInfos', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT owner FROM users_cars WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		local retrivedInfo = {plate = plate}

		if result[1] then
			local xPlayer = ESX.GetPlayerFromIdentifier(result[1].owner)

			-- is the owner online?
			if xPlayer then
				retrivedInfo.owner = xPlayer.getName()
				cb(retrivedInfo)
			else
				MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier',  {
					['@identifier'] = result[1].owner
				}, function(result2)
					if result2[1] then
						if Config.EnableESXIdentity then
							retrivedInfo.owner = ('%s %s'):format(result2[1].firstname, result2[1].lastname)
						else
							retrivedInfo.owner = result2[1].firstname
						end

						cb(retrivedInfo)
					else
						cb(retrivedInfo)
					end
				end)
			end
		else
			cb(retrivedInfo)
		end
	end)
end)

ESX.RegisterServerCallback('dd_police:getVehicleFromPlate', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT owner FROM users_cars WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] then
			MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					cb(('%s %s'):format(result2[1].firstname, result2[1].lastname), true)
				else
					cb(result2[1].firstname, true)
				end

			end)
		else
			cb('unknown', false)
		end
	end)
end)

RegisterNetEvent('dd_police:spawned')
AddEventHandler('dd_police:spawned', function()
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer and xPlayer.job.name == 'police' then
		Citizen.Wait(5000)
		TriggerClientEvent('dd_police:updateBlip', -1)
	end
end)

RegisterNetEvent('dd_police:forceBlip')
AddEventHandler('dd_police:forceBlip', function()
	TriggerClientEvent('dd_police:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('dd_police:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'police')
	end
end)
----------------------------NEWS ALERT---------------------------------------------
timermax = 3 -- In minutes.
cooldown = 0
ispriority = false
ishold = false

RegisterNetEvent('dd_police:isPriority')
AddEventHandler('dd_police:isPriority', function()
	ispriority = true
	Citizen.Wait(1)
	TriggerClientEvent('dd_police:UpdatePriority', -1, ispriority)
end)

RegisterNetEvent('dd_police:cooldownt')
AddEventHandler('dd_police:cooldownt', function()
	if ispriority == true then
		ispriority = false
		TriggerClientEvent('dd_police:UpdatePriority', -1, ispriority)
	end
	Citizen.Wait(1)
	if ishold == true then
		ishold = false
		TriggerClientEvent('dd_police:UpdateHold', -1, ishold)
	end

	Citizen.Wait(1)
	if cooldown == 0 then
		cooldown = 0
		cooldown = cooldown + timermax
			------------------//CITYNEWS NOTIFICATIONS//---------------------
			TriggerClientEvent('okokNotify:Alert', -1, "POLICE", "🛑 Priority Cooldown", timermax * 100000, 'warning')
			Citizen.Wait (timermax * 100000)
			ispriority = true
			Citizen.Wait(1)
			TriggerClientEvent('dd_police:UpdatePriority', -1, ispriority)
			TriggerClientEvent('okokNotify:Alert', -1, "POLICE", "City is Safe", 120 * 1000, 'warning')
		
		while cooldown > 0 do
			cooldown = cooldown - 1
		end

	elseif cooldown ~= 0 then
		CancelEvent()	
	end
end)
RegisterNetEvent('dd_police:onhold')
AddEventHandler('dd_police:onhold', function()
	isonhold = true
	TriggerClientEvent('okokNotify:Alert', -1, "POLICE", "🛑 Other Robberies in the City are temporary on-hold.", 120 * 1000, 'warning')
end)
---------------------------------------------ANIMATIONS-------------------------------------------------------
RegisterServerEvent('dd_police:requestarrest')
AddEventHandler('dd_police:requestarrest', function(targetid, playerheading, playerCoords,  playerlocation)
	_source = source
	TriggerClientEvent('dd_police:getarrested', targetid, playerheading, playerCoords, playerlocation)
	TriggerClientEvent('dd_police:doarrested', _source)
end)
RegisterServerEvent('dd_police:requestrelease')
AddEventHandler('dd_police:requestrelease', function(targetid, playerheading, playerCoords,  playerlocation)
	_source = source
	TriggerClientEvent('dd_police:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
	TriggerClientEvent('dd_police:douncuffing', _source)
end)
RegisterServerEvent('dd_police:requestdrag')
AddEventHandler('dd_police:requestdrag', function(targetid, playerheading, playerCoords,  playerlocation)
	_source = source
	TriggerClientEvent('dd_police:drag', target, source)
	TriggerClientEvent('dd_police:dodragging', _source)
end)
RegisterNetEvent('dd_police:drag')
AddEventHandler('dd_police:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('dd_police:drag', target, source)
	TriggerClientEvent('dd_police:dodragging', source)
end)

RegisterServerEvent('onDuty:offpolice')
AddEventHandler('onDuty:offpolice', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob('police',  xPlayer.job.grade)
	TriggerClientEvent('okokNotify:Alert', _source, "POLICE", "You are now On Duty", 3000, 'success')
end)
RegisterServerEvent('offDuty:police')
AddEventHandler('offDuty:police', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.hasWeapon('WEAPON_CARBINERIFLE') or
		xPlayer.hasWeapon('WEAPON_COMBATPISTOL') or
		xPlayer.hasWeapon('WEAPON_ASSAULTSMG') or
		xPlayer.hasWeapon('WEAPON_PUMPSHOTGUN') then
		TriggerClientEvent('okokNotify:Alert', _source, "POLICE", "Please deposit weapons except Pistol and Taser", 3000, 'info')
	else
		xPlayer.setJob('offpolice',  xPlayer.job.grade)
		TriggerClientEvent('okokNotify:Alert', _source, "POLICE", "You are now Off Duty", 3000, 'success')
	end
end)

RegisterServerEvent('dd_police:openBadge')
AddEventHandler('dd_police:openBadge', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if target ~= nil then
		TriggerClientEvent('chat:addMessage', target, {
			template = '<div style="padding: 5px; margin: 5px; background-image: linear-gradient(-90deg, rgba(46,49,146, 1), rgba(46,49,146, 0.50)); border-radius: 2px; font-weight: bold;">{0}</div>',
			args = {'[DCPD]👮🏼‍♂️: '..xPlayer.getName()..'|'..xPlayer.job.grade_label}, color = {255,255,255}})
		TriggerClientEvent('chat:addMessage', source, {
			template = '<div style="padding: 5px; margin: 5px; background-image: linear-gradient(-90deg, rgba(46,49,146, 1), rgba(46,49,146, 0.50)); border-radius: 2px; font-weight: bold;">{0}</div>',
			args = {'[DCPD]👮🏼‍♂️: '..xPlayer.getName()..'|'..xPlayer.job.grade_label}, color = {255,255,255}})
	else
		TriggerClientEvent('chat:addMessage', source, {
			template = '<div style="padding: 5px; margin: 5px; background-image: linear-gradient(-90deg, rgba(46,49,146, 1), rgba(46,49,146, 0.50)); border-radius: 2px; font-weight: bold;">{0}</div>',
			args = {'[DCPD]👮🏼‍♂️: '..xPlayer.getName()..'|'..xPlayer.job.grade_label}, color = {255,255,255}})
	end
end)

-- RegisterServerEvent('dd_police:openBadge')
-- AddEventHandler('dd_police:openBadge', function(ID, targetID)
-- 	local identifier = ESX.GetPlayerFromId(ID).identifier
-- 	local _source 	 = ESX.GetPlayerFromId(targetID).source
-- 	TriggerClientEvent('dd_police:ShowMyBadge', _source)
-- 	-- TriggerClientEvent( 'badge:shot', _source, source )
-- end)

