ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('redux:userpeds:spawnPed')
AddEventHandler('redux:userpeds:spawnPed', function()
	ESX.TriggerServerCallback('redux:userpeds:pedCheck', function(result)
		if result ~= nil then
			spawnped(result)
		end		
	end)
end)

RegisterCommand('pedyenile', function()
	ESX.TriggerServerCallback('redux:userpeds:pedCheck', function(result)
		if result ~= nil then
			spawnped(result)
		end		
	end)
end)

function spawnped(results)
	local pedmodel = results.pedmodel
	if pedmodel ~= nil then
		Model = GetHashKey(pedmodel)
		if IsModelValid(Model) then
			if not HasModelLoaded(Model) then
				RequestModel(Model)
				while not HasModelLoaded(Model) do
					Citizen.Wait(5)
				end
			end
			
			SetPlayerModel(PlayerId(), Model)
			
			SetModelAsNoLongerNeeded(Model)

			Citizen.Wait(100)

			print(results.randomized)

			if not tonumber(results.randomized) then
				SetPedRandomProps(GetPlayerPed(-1))
				SetPedRandomComponentVariation(GetPlayerPed(-1), true)

				TriggerEvent('skinchanger:getSkin', function(skin)
					TriggerServerEvent('esx_skin:save', skin)
				end)
				TriggerServerEvent('redux:userpeds:saveRandomized')
			else
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin, height)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end
		end
	end
end

AddEventHandler('playerSpawned', function(spawn)
	ESX.TriggerServerCallback('redux:userpeds:pedCheck', function(result)
		if result ~= nil then
			spawnped(result)
		end		
	end)
end)