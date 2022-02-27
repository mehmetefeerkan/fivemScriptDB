ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

end)

RegisterNetEvent('InteractSound_CL:PlayWithinDistance')
AddEventHandler('InteractSound_CL:PlayWithinDistance', function(playerNetId, maxDistance, soundFile, soundVolume)
    local lCoords = GetEntityCoords(PlayerPedId())
    local eCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)))
    local distIs  = Vdist(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z)
    if(distIs <= maxDistance) then
        SendNUIMessage({
            transactionType     = 'playSound',
            transactionFile     = soundFile,
            transactionVolume   = soundVolume
        })
    end
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
	if (IsControlJustPressed(1, 47)) then
		local coords = GetEntityCoords(PlayerPedId())
		local hasAlreadyLocked = false
		cars = ESX.Game.GetVehiclesInArea(coords, 30)
		local carstrie = {}
		local cars_dist = {}		
		notowned = 0
		if #cars == 0 then
		--	TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Etrafında sana ait araç yok.' } )
		else
			for j=1, #cars, 1 do
				local coordscar = GetEntityCoords(cars[j])
				local distance = Vdist(coordscar.x, coordscar.y, coordscar.z, coords.x, coords.y, coords.z)
				table.insert(cars_dist, {cars[j], distance})
			end
			for k=1, #cars_dist, 1 do
				local z = -1
				local distance, car = 999
				for l=1, #cars_dist, 1 do
					if cars_dist[l][2] < distance then
						distance = cars_dist[l][2]
						car = cars_dist[l][1]
						z = l
					end
				end
				if z ~= -1 then
					table.remove(cars_dist, z)
					table.insert(carstrie, car)
				end
			end
			for i=1, #carstrie, 1 do
				local plate = ESX.Math.Trim(GetVehicleNumberPlateText(carstrie[i]))
				ESX.TriggerServerCallback('carlock:isVehicleSOwner', function(owner)
					if owner and hasAlreadyLocked ~= true then
						local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(carstrie[i]))
						vehicleLabel = GetLabelText(vehicleLabel)
						local lock = GetVehicleDoorLockStatus(carstrie[i])
						if lock == 1 or lock == 0 then
							SetVehicleDoorShut(carstrie[i], 0, false)
							SetVehicleDoorShut(carstrie[i], 1, false)
							SetVehicleDoorShut(carstrie[i], 2, false)
							SetVehicleDoorShut(carstrie[i], 3, false)
							SetVehicleDoorsLocked(carstrie[i], 2)
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 50, "lock", 0.1)
							-- TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Araç kilitlendi.' } )
							TriggerEvent('notification', 'Araç kilitlendi.', 2)
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TriggerEvent("dooranim")
							end
							hasAlreadyLocked = true
						elseif lock == 2 then
							SetVehicleDoorsLocked(carstrie[i], 1)
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 50, "lock", 0.1)
							-- TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Araç açıldı.' } )
							TriggerEvent('notification', 'Araç açıldı.', 1)
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TriggerEvent("dooranim")
							end
							hasAlreadyLocked = true
						end
					else
						notowned = notowned + 1
					end
					if notowned == #carstrie then
					--	TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Etrafında sana ait araç yok.' } )
					end	
				end, plate)
			end			
		end
	end
  end
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

RegisterNetEvent( 'dooranim' )
AddEventHandler( 'dooranim', function()
    
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict( "anim@heists@keycard@" ) 
    TaskPlayAnim( PlayerPedId(), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Citizen.Wait(50)
    ClearPedTasks(PlayerPedId())

end)

