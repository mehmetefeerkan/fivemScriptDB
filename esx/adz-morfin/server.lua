ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--[[

BU SCRIPT Kaves#0359 TARAFINDAN YAZILMIŞTIR.
THIS SCRIPT WAS WRITTEN BY Kaves#0359

]]--


ESX.RegisterServerCallback("kaves_meth:checkItem", function(source, cb, itemname, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getQuantity(itemname)
    if item >= count then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent("kaves_meth:removeItem")
AddEventHandler("kaves_meth:removeItem", function(itemname, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(itemname, count)
end)

RegisterServerEvent("kaves_meth:giveItem")
AddEventHandler("kaves_meth:giveItem", function(itemname, count)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.canCarryItem(itemname, count) then
            xPlayer.addInventoryItem(itemname, count)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Envanterinde boş yer yok!', style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })           
    end
end)

