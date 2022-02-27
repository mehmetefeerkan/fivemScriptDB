Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

    SetEntityCoords(PlayerPedId(), 262.4, 274.1, 415.73, 0.0)
    Citizen.Wait(4000)

