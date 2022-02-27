ESX = nil
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)
RegisterServerEvent("st:bag2")
AddEventHandler("st:bag2", function(target_id)
    local _source = source
    local targetid = GetPlayerIdentifier(target_id)
    local xPlayer2 = ESX.GetPlayerFromId(target_id)
    local esya = xPlayer2.getInventoryItem('bag').count
    if esya >= 1 then
        TriggerClientEvent('st:bag3', _source, targetid)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Karşıdakinin çantası yok', lenght = 8000 })
    end
end)