local PlayerHackTimer = {}
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem("roka1g", function(source)
  TriggerClientEvent("mertdrug:armordoldur", source, "DrugsMichaelAliensFight", 30000)
end)

ESX.RegisterUsableItem("maydanoz1g", function(source)
  TriggerClientEvent("mertdrug:candoldur", source, "DrugsMichaelAliensFight", 30000) -- DrugsTrevorClownsFight
end)

ESX.RegisterUsableItem("joint", function(source)
	TriggerClientEvent("mertdrug:hizlikosma", source, "DrugsMichaelAliensFight", 30000)
end)

RegisterServerEvent('mertdrug:remove')
AddEventHandler('mertdrug:remove', function(amount, name)
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.removeInventoryItem(name, amount)
end)

RegisterServerEvent('mertdrug:add')
AddEventHandler('mertdrug:add', function(amount, name)
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.addInventoryItem(name, amount)
end)

ESX.RegisterServerCallback('mertdrug:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count
	cb(quantity)
end)