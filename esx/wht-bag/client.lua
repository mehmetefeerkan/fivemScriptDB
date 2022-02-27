ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("client:success")
AddEventHandler("client:success", function()
     exports["np-taskbar"]:taskBar(2000, "Çantayı takıyorsun")
    TaskPlayAnim(PlayerPedId(), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "Çanta - "..ESX.GetPlayerData().identifier)
        TriggerEvent("inventory:client:SetCurrentStash", "Çanta - "..ESX.GetPlayerData().identifier)
        ClearPedTasks(PlayerPedId())
end)

animbags = function()
    while not HasAnimLoaded("clothingshirt") do
        Citizen.Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end