ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('lsrp-lockpickfo:getBobbyPins', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    --local bobbypins = xPlayer.getInventoryItem('bobbypin')
    local advancedlockpick = xPlayer.getInventoryItem('advancedlockpick')
        if advancedlockpick == nil then
            cb(0)
        else
            cb(advancedlockpick.count)
        end
end)

RegisterServerEvent('lsrp-lockpickfo:removePin')
AddEventHandler('lsrp-lockpickfo:removePin', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('bobbypin', 1)
end)