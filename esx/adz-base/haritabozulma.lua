Citizen.CreateThread(function()
    SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0) -- Level 0
    SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
    SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
    SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
    SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0) -- Level 4

    while true do
        Citizen.Wait(1)
        if IsPedInAnyVehicle(PlayerPedId(), true) then
            SetRadarZoom(1100)
        end
    end
end)

RegisterNetEvent('chat:server:ServerPSA')
AddEventHandler('chat:server:ServerPSA', function()
  local _source = source
  DropPlayer(source, 'Heyyo')
end)