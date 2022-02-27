local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone = nil, {}, false, nil, nil
local NPCHasSpawnedTowable, NPCLastCancel, NPCHasBeenNextToTowable, NPCTargetDeleterZone = false, GetGameTimer() - 5 * 60000, false, false
local isDead, isBusy = false, false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('st:hijack')
AddEventHandler('st:hijack', function()
    local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				--ESX.ShowNotification(_U('inside_vehicle'))
				exports['mythic_notify']:SendAlert('error', 'Bu işlemi aracın içerisinde yapamazsın')
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(10000)

					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					TriggerServerEvent('cylex:AddInLog', "mechanic", "hijack_vehicle", GetPlayerName(PlayerId()))
					--ESX.ShowNotification(_U('vehicle_unlocked'))
					exports['mythic_notify']:SendAlert('inform', 'Araç kilidi açıldı')
					isBusy = false
				end)
			else
				--ESX.ShowNotification(_U('no_vehicle_nearby'))
				exports['mythic_notify']:SendAlert('error', 'Yakınında araç yok')
			end
end)

RegisterNetEvent('st:mechimpound')
AddEventHandler('st:mechimpound', function()
    local playerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(playerPed) then
				local vehicle = GetVehiclePedIsIn(playerPed, false)

				if GetPedInVehicleSeat(vehicle, -1) == playerPed then
					--ESX.ShowNotification(_U('vehicle_impounded'))
					exports['mythic_notify']:SendAlert('inform', 'Araç haczedildi')
					ESX.Game.DeleteVehicle(vehicle)
					TriggerServerEvent('fizzfau-impound')
				else
					--ESX.ShowNotification(_U('must_seat_driver'))
					exports['mythic_notify']:SendAlert('error', 'Bu işlemi yapabilmek için sürücü koltuğunda olmalısın')
				end
			else
				local vehicle = ESX.Game.GetVehicleInDirection()

				if DoesEntityExist(vehicle) then
					--ESX.ShowNotification(_U('vehicle_impounded'))
					exports['mythic_notify']:SendAlert('inform', 'Araç haczedildi')
					ESX.Game.DeleteVehicle(vehicle)
					TriggerServerEvent('fizzfau-impound')
				else
					--ESX.ShowNotification(_U('must_near'))
					exports['mythic_notify']:SendAlert('error', 'Aracın yakınında olman gerekiyor')
				end
			end
end)

RegisterNetEvent('st:mechrepair')
AddEventHandler('st:mechrepair', function()
	local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = "araçta olmamalısın"})
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(20000)

					SetVehicleFixed(vehicle)
					SetVehicleEngineHealth(vehicle, 1000.0)
					SetVehicleDeformationFixed(vehicle)
					SetVehicleUndriveable(vehicle, false)
					SetVehicleEngineOn(vehicle, true, true)
					ClearPedTasks(playerPed)

					TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = "Araç tamir edildi"})
					isBusy = false
				end)
			else
				TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = "Yakınında araç yok"})
			end
end)

RegisterNetEvent('st:mechclean')
AddEventHandler('st:mechclean', function()
    local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = "Araçta olmamalısın."})
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(10000)

					SetVehicleDirtLevel(vehicle, 0)
					ClearPedTasksImmediately(playerPed)

					TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = "Araç temizlendi."})
					isBusy = false
				end)
			else
				TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = "Yakınında araç yok."})
			end
end)

RegisterNetEvent('st:fatura')
AddEventHandler('st:fatura', function()
   ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
				title = "Fatura"
			}, function(data, menu)
				local amount = tonumber(data.value)

				if amount == nil or amount < 0 then
					TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text ="Geçersiz miktar"})
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = "Yakında kimse yok"})
					else
						menu.close()
						TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_mechanic', "Mekanik", amount)
					end
				end
			end, function(data, menu)
				menu.close()
			end)
end)

RegisterNetEvent('st:fatura2')
AddEventHandler('st:fatura2', function()
   ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
				title = "Fatura"
			}, function(data, menu)
				local amount = tonumber(data.value)

				if amount == nil or amount < 0 then
					TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text ="Geçersiz miktar"})
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = "Yakında kimse yok"})
					else
						menu.close()
						TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_mechanictwo', "Mekanik 2", amount)
					end
				end
			end, function(data, menu)
				menu.close()
			end)
end)

RegisterNetEvent('st:fatura3')
AddEventHandler('st:fatura3', function()
   ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
				title = "Fatura"
			}, function(data, menu)
				local amount = tonumber(data.value)

				if amount == nil or amount < 0 then
					TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text ="Geçersiz miktar"})
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = "Yakında kimse yok"})
					else
						menu.close()
						TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_mechanicthree', "Mekanik 3", amount)
					end
				end
			end, function(data, menu)
				menu.close()
			end)
end)

RegisterNetEvent('st:fatura4')
AddEventHandler('st:fatura4', function()
   ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
				title = "Fatura"
			}, function(data, menu)
				local amount = tonumber(data.value)

				if amount == nil or amount < 0 then
					TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text ="Geçersiz miktar"})
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = "Yakında kimse yok"})
					else
						menu.close()
						TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_mechanicfour', "Mekanik 4", amount)
					end
				end
			end, function(data, menu)
				menu.close()
			end)
end)
RegisterNetEvent('st:fatural')
AddEventHandler('st:fatural', function()
   ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
				title = "Fatura"
			}, function(data, menu)
				local amount = tonumber(data.value)

				if amount == nil or amount < 0 then
					TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text ="Geçersiz miktar"})
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = "Yakında kimse yok"})
					else
						menu.close()
						TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_mechaniclost', "Mekanik Lost", amount)
					end
				end
			end, function(data, menu)
				menu.close()
			end)
end)