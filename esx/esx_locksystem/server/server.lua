ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- RegisterServerEvent('InteractSound_SV:PlayWithinDistance')
-- AddEventHandler('InteractSound_SV:PlayWithinDistance', function(maxDistance, soundFile, soundVolume)
--     TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, source, maxDistance, soundFile, soundVolume)
-- end)

ESX.RegisterServerCallback('carlock:isVehicleSOwner', function(source, cb, plate)
	local identifier = GetPlayerIdentifier(source, 0)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == identifier)
		else
			cb(false)
		end
	end)
end)