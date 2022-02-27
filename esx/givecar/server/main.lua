ESX = nil

local Categories = {}
local Vehicles   = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)  
 

	RegisterServerEvent('raider:setVehicleBySql')
	AddEventHandler('raider:setVehicleBySql', function (vehicleProps)
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
		{
			['@owner']   = xPlayer.identifier,
			['@plate']   = vehicleProps.plate,
			['@vehicle'] = json.encode(vehicleProps)
		}, function (rowsChanged)
			TriggerClientEvent('esx:showNotification', _source,'Alınan Aracın Plakası: '..vehicleProps.plate)
		end)
	end)

	RegisterServerEvent('raider:setYouVehicleBySql')
	AddEventHandler('raider:setYouVehicleBySql', function (vehicleProps,youId)
		local _source = youId
		local xPlayer = ESX.GetPlayerFromId(_source)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
		{
			['@owner']   = xPlayer.identifier,
			['@plate']   = vehicleProps.plate,
			['@vehicle'] = json.encode(vehicleProps)
		}, function (rowsChanged)
			TriggerClientEvent('esx:showNotification', _source,'Verilen Aracın Plakası: '..vehicleProps.plate)
		end)
	end)
