
ESX                             = nil

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end) 

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(5)
    end
end

RegisterNetEvent("hasan:ontamirkit")
AddEventHandler("hasan:ontamirkit",function()
    local playerPed = PlayerPedId()
    local vehicle   = ESX.Game.GetVehicleInDirection()
    coords  = GetEntityCoords(playerPed)
    cars = ESX.Game.GetVehiclesInArea(coords, 10)
    if IsPedInAnyVehicle(GetPlayerPed(), false) then
        TriggerEvent("notification","Araçta bunu yapamazsın",2)
    else
        if #cars == 0 then
            TriggerEvent("notification","Yakında araç yok",2)
        else
            SetVehicleDoorOpen(vehicle, 4)
            loadAnimDict( "mini@repair" ) 
            TaskPlayAnim( PlayerPedId(), "mini@repair", "fixing_a_ped", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
                local bits = exports["reload-skillbar"]:taskBar(3500,math.random(5,15))
                if bits ~= 100 then
                    TriggerEvent("notification","Başaramadın",2)
                    TriggerServerEvent("removeitem","fixtool")
                    ClearPedTasks(PlayerPedId()) 
                else  
                    ClearPedTasks(PlayerPedId()) 
                    Citizen.Wait(100)
                    loadAnimDict( "mini@repair" ) 
                    TaskPlayAnim( PlayerPedId(), "mini@repair", "fixing_a_ped", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
                    local bits2 = exports["reload-skillbar"]:taskBar(5000,math.random(5,15))
                        if bits2 ~= 100 then
                            TriggerEvent("notification","Başaramadın",2)
                            TriggerServerEvent("removeitem","fixtool")
                            ClearPedTasks(PlayerPedId()) 
                        else
                            exports["hsn-bar"]:taskBar(8500, "Tamir Ediliyor! ")
                            TriggerServerEvent("removeitem","fixtool")
                            SetVehicleFixed(vehicle)
                            SetVehicleDeformationFixed(vehicle)
                            SetVehicleUndriveable(vehicle, false)
                            SetVehicleEngineOn(vehicle, true, true)
                            ClearPedTasks(PlayerPedId()) 
                            SetVehicleDoorShut(vehicle, 4)
                    end
                end   
            end
        end
end)   



