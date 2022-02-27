ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('repair', function(source, args, raw)
    TriggerClientEvent('LRP-RepairZone:Repair', source)
end)

ESX.RegisterServerCallback('LRP-RepairZone:RemoveMoney', function(source, cb, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    if (xPlayer.getMoney() >= price) then
        xPlayer.removeMoney(price)
        cb(true)
    elseif (xPlayer.getBank() >= price) then
        xPlayer.removeAccountMoney('bank', price)
        cb(true)
    else
        cb(false)
    end
end)
