ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('utx-balik:tacover')
AddEventHandler('utx-balik:tacover', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('meth') >= 1 then
        xPlayer.removeInventoryItem('meth', 2)
        Citizen.Wait(500)
        xPlayer.addInventoryItem('balikcik', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Balıksız pişircen herhalde!')
    end
end)

RegisterServerEvent('utx-balik:paketver')
AddEventHandler('utx-balik:paketver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('balikcik') >= 1 then
        if xPlayer.canCarryItem('balikekmek', 1) then
            xPlayer.removeInventoryItem('balikcik', 1)
            Citizen.Wait(500)
            xPlayer.addInventoryItem('balikekmek', 1)
        end
    end
end)

RegisterServerEvent('utx-balik:tacosat')
AddEventHandler('utx-balik:tacosat', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local money = math.random(Config.MinParaMiktar, Config.MaxParaMiktar)
    if xPlayer.getQuantity('balikekmek') >= 1 then
        xPlayer.removeInventoryItem('balikekmek', 1)
        Citizen.Wait(500)
        xPlayer.addMoney(money)
    end
end)

ESX.RegisterServerCallback('utx-balik:malzemekontrol', function(source, cb, item, gereklisayi)
	local xPlayer = ESX.GetPlayerFromId(source)
    local itemcount = xPlayer.getQuantity(item)
    local itemname = xPlayer.getQuantity(item)
	if itemcount >= gereklisayi then
		cb(true)
	else
        activity = 0
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde yeterli '..itemname..' yok!')
	end
end)
