ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterCommand('carfix', function(source, args, raw)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    ESX.TriggerServerCallback('Zex_Carfix:fetchUserRank', function(playerRank)
        if playerRank == 'mod' or playerRank == 'admin' or playerRank == 'superadmin' then
            SetVehicleDeformationFixed(vehicle)
            SetVehicleFixed(vehicle)
            SetVehicleTyreFixed(vehicle, 4)
            exports['mythic_notify']:DoHudText('success', 'Aracınız tamir edildi')
        else
            exports['mythic_notify']:DoHudText('error', 'Yetkin yetmiyor')
        end
    end)
end)