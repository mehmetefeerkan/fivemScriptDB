Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("yordi:cleaningcloth")
AddEventHandler("yordi:cleaningcloth", function()
	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)

	if DoesEntityExist(vehicle) then
		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
		Citizen.CreateThread(function()
		Citizen.Wait(10000)
		SetVehicleDirtLevel(vehicle, 0)
		ClearPedTasksImmediately(playerPed)

	if SetVehicleDirtLevel(vehicle, 0) then
		exports['mythic_notify']:DoHudText('success', 'Araç başarıyla temizlendi')

			end
		end)
	end
end)