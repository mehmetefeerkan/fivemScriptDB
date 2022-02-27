ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('carlock:isVehicleOwner', function(source, cb, plate)
	local identifier = GetPlayerIdentifier(source, 0)

	exports.ghmattimysql:execute('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
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

ESX.RegisterServerCallback('carlock:isVehicleOwnerSociety', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local job = nil

	if xPlayer.job.name == 'legion' then
		job = 'legion'
	else
		job = 'unemployed'
	end

	exports.ghmattimysql:execute('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = 'society:' .. job,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == 'society:' .. job)
		else
			cb(false)
		end
	end)
end)