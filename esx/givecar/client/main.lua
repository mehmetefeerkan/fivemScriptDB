ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)



RegisterNetEvent('raider:spawnVehicleBySql')
AddEventHandler('raider:spawnVehicleBySql', function(model,plate)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	ESX.Game.SpawnVehicle(model, coords, 90.0, function(vehicle)
		TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
		
		local newPlate     = plate
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		vehicleProps.plate = newPlate
		TriggerServerEvent('raider:setVehicleBySql', vehicleProps)
	end)
end)


RegisterNetEvent('raider:spawnYouVehicleBySql')
AddEventHandler('raider:spawnYouVehicleBySql', function(model,plate,youId)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	ESX.Game.SpawnVehicle(model, coords, 90.0, function(vehicle)
		TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
		print(playerPed)
		
		local newPlate     = plate
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		vehicleProps.plate = newPlate
		TriggerServerEvent('raider:setYouVehicleBySql', vehicleProps,youId)
	end)
end)