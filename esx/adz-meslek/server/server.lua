ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    print("^7[^1patex_otmethsc^7] - ^2Aktif! ^0") 
end)

RegisterServerEvent("cylex_yanmeslekv2:server:process")
AddEventHandler("cylex_yanmeslekv2:server:process", function(location)
    local player = ESX.GetPlayerFromId(source)
    if not player or location == nil then return TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Bir hata oluştu! Relog atıp tekrar deneyin."})end
    local item = player.getQuantity(location.itemName)
    local requiredItem = player.getQuantity(location.requiredItem)
    if item or location.process == "sell" then
        if location.process == "pickup" then
            if player.canCarryItem(location.itemName, location.addCount) then
                player.addInventoryItem(location.itemName, location.addCount)
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Ağırlık sınırına ulaştın!"})
            end
        elseif location.process == "exchange" then
            if requiredItem >= location.removeCount then
                if player.canCarryItem(location.itemName, location.addCount) then
                    player.removeInventoryItem(location.requiredItem, location.removeCount)
                    player.addInventoryItem(location.itemName, location.addCount)
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Ağırlık sınırına ulaştın!"})
                end
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Yetersiz eşya!"})
            end
        elseif location.process == "package" then
            if requiredItem >= location.removeCount then
                if player.canCarryItem(location.itemName, location.addCount) then
                    player.removeInventoryItem(location.requiredItem, location.removeCount)
                    player.addInventoryItem(location.itemName, location.addCount)
                end
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Yetersiz eşya!"})
            end
        elseif location.process == "sell" then
            if requiredItem >= location.removeCount then
                player.removeInventoryItem(location.requiredItem, location.removeCount)
                player.addMoney(location.price)
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Yetersiz eşya!"})
            end
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Bir hata oluştu! Yetkililere ulaş."})
        print("[cylex_yanmeslekv2] - HATA - cylex_yanmeslekv2:server:process eventinde items tablosunda olmayan bir item sorgulandi!") 
        print("[cylex_yanmeslekv2] Item "..location.itemName.. " olmali.")
    end
end)

ESX.RegisterServerCallback('cylex_yanmeslekv2:checkCount', function(source, cb, itemName) 
    local player = ESX.GetPlayerFromId(source)
    local item = player.getQuantity(itemName)
    if item then
        cb(item)
    else
        cb(0)
    end
end)