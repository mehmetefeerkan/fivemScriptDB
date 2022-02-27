ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('ArmorBelt', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('ArmorBelt', 1)
    TriggerClientEvent('fizzfau-armor:armorcikra', source)
end)

ESX.RegisterUsableItem('SmallArmor', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('SmallArmor', 1)
    TriggerClientEvent('fizzfau-armor:SmallArmor', source)
end)

ESX.RegisterUsableItem('MedArmor', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('MedArmor', 1)
    TriggerClientEvent('fizzfau-armor:MedArmor', source)
end)

ESX.RegisterUsableItem('HeavyArmor', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('HeavyArmor', 1)
    TriggerClientEvent('fizzfau-armor:HeavyArmor', source)
end)

RegisterServerEvent("armor0")
AddEventHandler("armor0", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem("SmallArmor", 1)
end)

RegisterServerEvent("armor1")
AddEventHandler("armor1", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem("MedArmor", 1)
end)

RegisterServerEvent("armor2")
AddEventHandler("armor2", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem("HeavyArmor", 1)
end)