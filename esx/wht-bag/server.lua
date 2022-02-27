ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem("bag", function(source, item)
    local src = source
    TriggerClientEvent("client:success", src)
end)