--  V A R I A B L E S --
engineoff = false
saved = false
controlsave_bool = false
-- C O N F I G --
interactionDistance = 3.5 --The radius you have to be in to interact with the vehicle.
lockDistance = 25 --The radius you have to be in to lock your vehicle.
-- E N G I N E --
IsEngineOn = true

RegisterNetEvent('fizzfau:givekey')
AddEventHandler('fizzfau:givekey', function()
	ExecuteCommand('anahtarver')
end)

function notify(type, message)
	exports['mythic_notify']:SendAlert(type, message)
end
function engine()
	local player = GetPlayerPed(-1)
	
	if (IsPedSittingInAnyVehicle(player)) then 
		local vehicle = GetVehiclePedIsIn(player,false)
		
		if IsEngineOn == true then
			IsEngineOn = false
			SetVehicleEngineOn(vehicle,false,false,false)
			notify('error', 'Motor kapandı!')
		else
			IsEngineOn = true
			SetVehicleUndriveable(vehicle,false)
			SetVehicleEngineOn(vehicle,true,false,false)
			notify('success', 'Motor açıldı!')
		end
		
		while (IsEngineOn == false) do
			SetVehicleUndriveable(vehicle,true)
			Citizen.Wait(0)
		end
	end
end

function trunk()
	local player = GetPlayerPed(-1)
			local vehicle = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)
			
			local isopen = GetVehicleDoorAngleRatio(vehicle,5)
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)

	if (GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(PlayerId())) then
			if distanceToVeh <= interactionDistance then
				if (isopen == 0) then
				SetVehicleDoorOpen(vehicle,5,0,0)
				notify('error', 'Bagaj açıldı!')
				else
				SetVehicleDoorShut(vehicle,5,0)
				notify('success', 'Bagaj kapandı!')
				end
			else
				notify('error', "Aracının Yanında Olmalısın!")
			end
	 end
end

local windowup = true

function camlariAc()
	local player = GetPlayerPed(-1)
    		local vehicle = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)
			
			
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
			local camAcikMi1 = IsVehicleWindowIntact(vehicle, 0)
			local camAcikMi2 = IsVehicleWindowIntact(vehicle, 1)
			
	if (GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(PlayerId())) then
		
		if camAcikMi1 or camAcikMi2 then
				
					
				RollDownWindows(vehicle)
				notify('success', 'Camlar açıldı!')
			else
				RollUpWindow(vehicle, 0)
				RollUpWindow(vehicle, 1)
				RollUpWindow(vehicle, 2)
				RollUpWindow(vehicle, 3)
				notify('error', 'Camlar kapandı!')
			end
		end
end

function camlariKapat()
	local player = GetPlayerPed(-1)
    		local vehicle = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)
			
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
			
		if (GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(PlayerId())) then
			
			solcamE = false
			if distanceToVeh <= interactionDistance then		
				ShowNotification("~r~Kayıtlı Aracının Yanında Olmalısın!")
				end
			else

				RollUpWindow(vehicle, 0)
				RollUpWindow(vehicle, 1)
			end
		end

        function hood()
            local player = GetPlayerPed(-1)
                if controlsave_bool == true then
                    vehicle = saveVehicle
                else
                    vehicle = GetVehiclePedIsIn(player,true)
                end
                    
                    local isopen = GetVehicleDoorAngleRatio(vehicle,4)
                    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
        
                        if distanceToVeh <= interactionDistance then
        
                            if (isopen == 0) then
                            SetVehicleDoorOpen(vehicle,4,0,0)
                            else
                            SetVehicleDoorShut(vehicle,4,0)
                            end
                    else
                        ShowNotification("~r~Aracının Yanında Olmalısın!")
                    end
        end
        
        
        --NEON
        function neon()
            
                
                    local veh = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)
                    local ped = GetPlayerPed(PlayerId())
                    
                    
                    
                    
                    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(veh, 1))
                    local acikMi0 = IsVehicleNeonLightEnabled(veh, 0)
                    local acikMi1 = IsVehicleNeonLightEnabled(veh, 1)
                    local acikMi2 = IsVehicleNeonLightEnabled(veh, 2)
                    local acikMi3 = IsVehicleNeonLightEnabled(veh, 3)
                    
                    if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(PlayerId())) then
                    
                        if distanceToVeh <= interactionDistance then
                        
                            if acikMi0 or acikMi1 or acikMi2 or acikMi3 then
        
                            SetVehicleNeonLightEnabled(veh, 0, false)
                            SetVehicleNeonLightEnabled(veh, 1, false)
                            SetVehicleNeonLightEnabled(veh, 2, false)
                            SetVehicleNeonLightEnabled(veh, 3, false)
                            
                            else 
                            
                            SetVehicleNeonLightEnabled(veh, 0, true)
                            SetVehicleNeonLightEnabled(veh, 1, true)
                            SetVehicleNeonLightEnabled(veh, 2, true)
                            SetVehicleNeonLightEnabled(veh, 3, true)
                            
                            end
        
                    else
                        ShowNotification("~r~Aracının Yanında Olmalısın!")
                    end
                    
                end	
        end

		
RegisterNetEvent('fizz:hood')
AddEventHandler('fizz:hood', function(source)
	hood()
end)

RegisterNetEvent('fizz:carlock')
AddEventHandler('fizz:carlock', function(source)
	ExecuteCommand('lockveh')
end)

RegisterNetEvent('fizz:trunk')
AddEventHandler('fizz:trunk', function(source)
	trunk()
end)

RegisterNetEvent('fizz:neon')
AddEventHandler('fizz:neon', function(source)
	neon()
end)

RegisterNetEvent('fizz:camac')
AddEventHandler('fizz:camac', function(source)
	camlariAc()
end)

RegisterNetEvent('fizz:engine')
AddEventHandler('fizz:engine', function(source)
	engine()
end)