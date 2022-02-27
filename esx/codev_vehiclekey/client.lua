ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("codev_vehiclekey:client:vehiclelock")
AddEventHandler("codev_vehiclekey:client:vehiclelock", function(plaka)
	local animdict = "anim@heists@keycard@" -- anim "exit"
	RequestAnimDict(animdict)
	while not HasAnimDictLoaded(animdict) do
		Citizen.Wait(1)
	end
    local pPed = PlayerPedId()
	local pCoords = GetEntityCoords(pPed)
	vehicles = ESX.Game.GetVehiclesInArea(pCoords, 20)
		if #vehicles == 0 then
			TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Yakınlarda hiç araç yok!'})
		else
			found = false
			for i=1, #vehicles, 1 do
				if found then
					break
				end
			    local vCoords = GetEntityCoords(vehicles[i])
				local distance = GetDistanceBetweenCoords(pCoords, vCoords.x, vCoords.y, vCoords.z, true)
				if distance < 20.0 then
				local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicles[i]))
					if plaka == plate then
						
						local prop = GetHashKey('p_car_keys_01')
                        while not HasModelLoaded(prop) do
                            RequestModel(prop)
                            Citizen.Wait(10)
                        end
                        local keyFob = CreateObject(prop, 1.0, 1.0, 1.0, 1, 1, 0)
						found = true
						local lock = GetVehicleDoorLockStatus(vehicles[i])
						AttachEntityToEntity(keyFob, pPed, GetPedBoneIndex(pPed, 57005), 0.09, 0.04, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
						if lock == 1 or lock == 0 then
							SetVehicleDoorShut(vehicles[i], 0, false)
							SetVehicleDoorShut(vehicles[i], 1, false)
							SetVehicleDoorShut(vehicles[i], 2, false)
							SetVehicleDoorShut(vehicles[i], 3, false)
							SetVehicleDoorsLocked(vehicles[i], 2)
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 1.0)
							TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Araç kilitlendi.'})
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), animdict, "exit", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							SetVehicleLights(vehicles[i], 2)
							Citizen.Wait(150)
							SetVehicleLights(vehicles[i], 0)
							Citizen.Wait(150)
							SetVehicleLights(vehicles[i], 2)
							Citizen.Wait(150)
							SetVehicleLights(vehicles[i], 0)
						elseif lock == 2 then
							SetVehicleDoorsLocked(vehicles[i], 1)
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "unlock", 1.0)
							TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Araç açıldı.'})
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), animdict, "exit", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							SetVehicleLights(vehicles[i], 2)
							Citizen.Wait(150)
							SetVehicleLights(vehicles[i], 0)
							Citizen.Wait(150)
							SetVehicleLights(vehicles[i], 2)
							Citizen.Wait(150)
							SetVehicleLights(vehicles[i], 0)
						end
						Citizen.Wait(2000)
						DeleteObject(keyFob)
						SetModelAsNoLongerNeeded(prop)
						return
                    else
                        TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Geçersiz anahtar!'})
					end
				end
			end
		end
end)