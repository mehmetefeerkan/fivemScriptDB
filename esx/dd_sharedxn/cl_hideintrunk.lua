local inTrunk = false
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
RegisterCommand('trunk', function(source, args)
    local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 10.0, 0, 70)
    if DoesEntityExist(vehicle) then
        local trunk = GetEntityBoneIndexByName(vehicle, 'boot')
        if trunk ~= -1 then
            local coords = GetWorldPositionOfEntityBone(vehicle, trunk)
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), coords, true) <= 2.5 then
                if not inTrunk then
                    local player = ESX.Game.GetClosestPlayer()
                    local playerPed = GetPlayerPed(player)
                    if DoesEntityExist(playerPed) then
                        if not IsEntityAttached(playerPed) or GetDistanceBetweenCoords(GetEntityCoords(playerPed), GetEntityCoords(PlayerPedId()), true) >= 5.0 then
                            SetCarBootOpen(vehicle)
                            Wait(350)
                            AttachEntityToEntity(PlayerPedId(), vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)	
                            loadDict('timetable@floyd@cryingonbed@base')
                            TaskPlayAnim(PlayerPedId(), 'timetable@floyd@cryingonbed@base', 'base', 8.0, -8.0, -1, 1, 0, false, false, false)
                            Wait(50)
                            inTrunk = true
                            SetEntityCollision(PlayerPedId(), false, false)
                            exports['dd_utils']:ShowXn('show','red','[/trunk] Leave trunk')
                            Wait(1500)
                            SetEntityVisible(PlayerPedId(), false, false)
                            SetVehicleDoorShut(vehicle, 5)
                            
                        else
                            exports['okokNotify']:Alert("", "Someone is already hiding in that vehicle!", 3000, 'error')
                        end
                    end
                else
                    exports['dd_utils']:HideXn()
                    SetCarBootOpen(vehicle)
                    SetEntityCollision(PlayerPedId(), true, true)
                    Wait(750)
                    inTrunk = false
                    DetachEntity(PlayerPedId(), true, true)
                    SetEntityVisible(PlayerPedId(), true, false)
                    ClearPedTasks(PlayerPedId())
                    SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -0.5, -0.75))
                    Wait(250)
                    SetVehicleDoorShut(vehicle, 5)
                end
            end
        end
    end
end)
loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end
