ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local blips = {}

print('[^2m3_gps^0] - Started!')

ESX.RegisterUsableItem('gps', function(source)
	local _source = source
	if GetCurrentResourceName() == 'm3_gps' then
		TriggerClientEvent('m3:gps:Used', _source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Script adını m3_gps olarak ayarlayınız!'})
	end
end)

ESX.RegisterServerCallback('m3:gps:getCharName', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer ~= nil then
		MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
		}, function(result)
			if result[1] ~= nil then
				cb(result[1].firstname, result[1].lastname)
			else
				cb(nil)
			end
		end)
	end
end)

ESX.RegisterServerCallback('m3:gps:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local items = xPlayer.getInventoryItem(item)
		if items == nil then
			cb(0)
		else
			cb(items.count)
		end
	end
end)

RegisterServerEvent('m3:gps:addBlip')
AddEventHandler('m3:gps:addBlip', function(fname, lname, jobname, code)
	local _source = source
	table.insert(blips, {firstname = fname, lastname = lname, job = jobname, code = code, plid = tonumber(_source)})
end)

RegisterServerEvent('m3:gps:dropBlip')
AddEventHandler('m3:gps:dropBlip', function(source)
	local _source = source
	for k, i in pairs(blips) do
		if blips[k].plid == tonumber(_source) then
			table.remove(blips, k)
		end
	end
end)

RegisterServerEvent('m3:gps:dropBlipCtoS')
AddEventHandler('m3:gps:dropBlipCtoS', function(firstname, lastname, job, code)
	local _source = source
	for k, i in pairs(blips) do
		if firstname == blips[k].firstname and lastname == blips[k].lastname and job == blips[k].job and code == blips[k].code then
			table.remove(blips, k)
		end
	end
end)

ESX.RegisterServerCallback('m3:gps:getBlips', function(source, cb, job)
	cb(blips)
end)

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if item.name == 'gps' and item.count < 1 then
		TriggerEvent('m3:gps:dropBlip', _source)
		TriggerClientEvent('m3:gps:dropBlips', _source)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		blips = {}
		print('[^2m3_gps^0] - GPS blipleri bosaltildi.')
	end
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source 		= source
	local xPlayer 		= ESX.GetPlayerFromId(_source)

	-- Did the player ever join?
	if _source ~= nil then
		

		-- Is it worth telling all clients to refresh?
		Citizen.Wait(5000)
		TriggerEvent('m3:gps:dropBlip', _source)
	end
end)

