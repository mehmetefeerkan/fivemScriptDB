ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('utx-taco:etver')
AddEventHandler('utx-taco:etver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('tacoeti', 1) then
        xPlayer.addInventoryItem('tacoeti', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('utx-taco:ekmekver')
AddEventHandler('utx-taco:ekmekver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('tacoekmegi', 1) then
        xPlayer.addInventoryItem('tacoekmegi', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('utx-taco:malzemever')
AddEventHandler('utx-taco:malzemever', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('tacomalzemesi', 1) then
        xPlayer.addInventoryItem('tacomalzemesi', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('utx-taco:tacover')
AddEventHandler('utx-taco:tacover', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('tacoeti') >= 1 then
        if xPlayer.getQuantity('tacoekmegi') >= 1 then
            if xPlayer.getQuantity('tacomalzemesi') >= 1 then
                if xPlayer.canCarryItem('taco', 1) then
                    xPlayer.removeInventoryItem('tacoeti', 1)
                    Citizen.Wait(250)
                    xPlayer.removeInventoryItem('tacoekmegi', 1)
                    Citizen.Wait(250)
                    xPlayer.removeInventoryItem('tacomalzemesi', 1)
                    Citizen.Wait(500)
                    xPlayer.addInventoryItem('taco', 1)
                else
                    TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
                end
            else
                TriggerClientEvent('esx:showNotification', src, 'Üzerinde yeterli taco malzemesi yok!')
            end
        else
            TriggerClientEvent('esx:showNotification', src, 'Üzerinde yeterli taco ekmeği yok!')
        end
    end
end)

RegisterServerEvent('utx-taco:paketver')
AddEventHandler('utx-taco:paketver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('taco') >= 1 then
        if xPlayer.canCarryItem('tacopaketi', 1) then
            xPlayer.removeInventoryItem('taco', 1)
            Citizen.Wait(500)
            xPlayer.addInventoryItem('tacopaketi', 1)
        else
            TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
        end
    end
end)

RegisterServerEvent('utx-taco:tacosat')
AddEventHandler('utx-taco:tacosat', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local money = math.random(Config.MinParaMiktar, Config.MaxParaMiktar)
    if xPlayer.getQuantity('tacopaketi') >= 1 then
        xPlayer.removeInventoryItem('tacopaketi', 1)
        Citizen.Wait(500)
        xPlayer.addMoney(money)
    end
end)

ESX.RegisterServerCallback('utx-taco:malzemekontrol', function(source, cb, item, gereklisayi)
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
