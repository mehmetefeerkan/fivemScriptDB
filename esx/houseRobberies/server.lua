local ESX = nil
local robbableItems = {
 [1] = {chance = 3, id = 0, name = 'Cash', quantity = math.random(1, 2)}, -- really common
 [2] = {chance = 1, id = 'WEAPON_PISTOL50', name = 'Pistol', isWeapon = true}, -- rare
 [3] = {chance = 3, id = 'raspberry', name = 'Raspberry', quantity = math.random(0, 1)}, -- really common
 [4] = {chance = 3, id = 'secure_card', name = 'Secure Card', quantity = math.random(0, 1)}, -- rare
 [5] = {chance = 6, id = 'id_card_f', name = 'Malicous Access Card', quantity = 1}, -- rare
 [6] = {chance = 7, id = 'id_card', name = 'Bigbank Access Card', quantity = 1}, -- rare
 [7] = {chance = 10, id = 'flashDrive', name = 'Flash Drive', quantity = 1}, -- rare
 [8] = {chance = 10, id = 'thermal_charge', name = 'Thermal Charge', quantity = 1}, -- rare
 [9] = {chance = 10, id = 'black_chip', name = 'Integrated Chip', quantity = 1}, -- rare
 [10] = {chance = 10, id = 'hackerDevice', name = 'Hacking Device', quantity = 1}, -- rare
 [11] = {chance = 3, id = 'advancedlockpick', name = 'Lockpick', quantity = math.random(0, 3)},
 [12] = {chance = 3, id = 'gold', name = 'Gold', quantity = math.random(0, 3)},
 [13] = {chance = 2, id = 'WEAPON_SWITCHBLADE', name = 'Switchblade', isWeapon = true}, -- rare
 [14] = {chance = 8, id = 'c4_bank', name = 'C4', quantity = math.random(0, 3)},
 [15] = {chance = 8, id = 'WEAPON_MOLOTOV', name = 'Molotov', isWeapon = true}, -- rare
}

--[[chance = 1 is very common, the higher the value the less the chance]]--

TriggerEvent('esx:getSharedObject', function(obj)
 ESX = obj
end)

ESX.RegisterUsableItem('advancedlockpick', function(source) --Hammer high time to unlock but 100% call cops
 local source = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(source)
 TriggerClientEvent('houseRobberies:attempt', source, xPlayer.getInventoryItem('advancedlockpick').count)
end)

RegisterServerEvent('houseRobberies:removeLockpick')
AddEventHandler('houseRobberies:removeLockpick', function()
 local source = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(source)
 xPlayer.removeInventoryItem('advancedlockpick', 1)
 TriggerClientEvent('okokNotify:Alert', source, "", "The lockpick bent out of shape.", 3000, 'error')
end)

RegisterServerEvent('houseRobberies:giveMoney')
AddEventHandler('houseRobberies:giveMoney', function()
 local source = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(source)
 local cash = math.random(10000, 30000)
 xPlayer.addAccountMoney('black_money',cash)
 TriggerClientEvent('okokNotify:Alert', source, "", 'You found $'..cash, 3000, 'success')
end)


RegisterServerEvent('houseRobberies:searchItem')
AddEventHandler('houseRobberies:searchItem', function()
 local source = tonumber(source)
 local item = {}
 local xPlayer = ESX.GetPlayerFromId(source)
 local gotID = {}


 for i=1, math.random(1, 2) do
  item = robbableItems[math.random(1, #robbableItems)]
  if math.random(1, 10) >= item.chance then
   if tonumber(item.id) == 0 and not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.addMoney(item.quantity)
    TriggerClientEvent('okokNotify:Alert', source, "", 'You found $'..item.quantity, 3000, 'success')
   elseif item.isWeapon and not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.addWeapon(item.id, 50)
    TriggerClientEvent('okokNotify:Alert', source, "", "Item Added!", 3000, 'success')
   elseif not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.addInventoryItem(item.id, item.quantity)
    TriggerClientEvent('okokNotify:Alert', source, "", "Item Added!", 3000, 'success')
   end
  end
 end
end)
