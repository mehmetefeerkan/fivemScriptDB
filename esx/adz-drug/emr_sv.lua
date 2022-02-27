ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('emrdrug:add')
AddEventHandler('emrdrug:add', function(name, amount)
	if name == "joint" or "maydanoz1g" or "maydanoz5g" or "maydanoz25g" or "roka1g" or "roka5g" or "roka25g" or "drugbag" or "sarmakagit" or "islaktohum" or "ufalanmisot" or "kucukot" then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.addInventoryItem(name, amount)
	end
end)

RegisterServerEvent('emrdrug:remove')
AddEventHandler('emrdrug:remove', function(name, amount)
	if name == "joint" or "maydanoz1g" or "maydanoz5g" or "maydanoz25g" or "roka1g" or "roka5g" or "roka25g" or "drugbag" or "sarmakagit" or "islaktohum" or "ufalanmisot" or "kucukot" then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem(name, amount)
	end
end)

ESX.RegisterUsableItem("roka1g", function(source)
  	TriggerClientEvent("emrdrug:drugeffect", source, "candoldur", "DrugsTrevorClownsFight", 30000, "roka1g")
end)

ESX.RegisterUsableItem("joint", function(source)
	TriggerClientEvent("emrdrug:drugeffect", source, "hızlıkoş", "DrugsTrevorClownsFight", 30000, "joint")
end)

ESX.RegisterUsableItem("maydanoz1g", function(source)
	TriggerClientEvent("emrdrug:drugeffect", source, "armordoldur", "DrugsTrevorClownsFight", 30000, "maydanoz1g")
end)

ESX.RegisterUsableItem('islaktohum', function(source)
    TriggerClientEvent('emrdrug:ufala', source)
end)

ESX.RegisterUsableItem('ufalanmisot', function(source)
    TriggerClientEvent('emrdrug:kurut', source)
end)

ESX.RegisterUsableItem('kucukot', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getQuantity('kucukot') > 2 and xPlayer.getQuantity('sarmakagit') > 0 then
        TriggerClientEvent('emrdrug:sar', source)
    else
        TriggerClientEvent('notification', source, 'Bir şeyler eksik', 2)
    end
end)

ESX.RegisterServerCallback('emrdrug:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getQuantity(item)
	cb(quantity)
end)