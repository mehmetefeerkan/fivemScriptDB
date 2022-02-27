ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bros-burgers:etvers')
AddEventHandler('bros-burgers:etvers', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('rawx') >= 1 then
    if xPlayer.canCarryItem('rawy', 5) then
        xPlayer.removeInventoryItem('rawx', 1)
        Citizen.Wait(250)
        xPlayer.addInventoryItem('rawy', 5)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end
end)

RegisterServerEvent('bros-burgers:tavukkoftevers')
AddEventHandler('bros-burgers:tavukkoftevers', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('acetone') >= 5 then
    if xPlayer.getQuantity('chemicals') >= 5 then
    if xPlayer.canCarryItem('rawy', 1) then
        xPlayer.removeInventoryItem('acetone', 5)
        Citizen.Wait(250)
        xPlayer.removeInventoryItem('chemicals', 5)
        Citizen.Wait(250)
        xPlayer.addInventoryItem('rawy', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
else
    TriggerClientEvent('esx:showNotification', src, 'Üzerinde yeterli malzeme yok!')
end
else
    TriggerClientEvent('esx:showNotification', src, 'Üzerinde yeterli malzeme yok!')
end
end)

RegisterServerEvent('bros-burgers:patatesver')
AddEventHandler('bros-burgers:patatesver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('burgerekmegi', 1) then
        xPlayer.addInventoryItem('burgerekmegi', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('bros-burgers:ekmekver')
AddEventHandler('bros-burgers:ekmekver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('burgerekmegi', 1) then
        xPlayer.addInventoryItem('burgerekmegi', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('bros-burgers:ketcapver')
AddEventHandler('bros-burgers:ketcapver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('ketcap', 1) then
        xPlayer.addInventoryItem('ketcap', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('bros-burgers:mayonezvers')
AddEventHandler('bros-burgers:mayonezvers', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('battery') >= 1 then
    if xPlayer.canCarryItem('rawx', 1) then
        xPlayer.removeInventoryItem('battery', 1)
         Citizen.Wait(250)
        xPlayer.addInventoryItem('rawx', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde yeterli malzeme yok!')
    end
end
end)

RegisterServerEvent('bros-burgers:marulver')
AddEventHandler('bros-burgers:marulver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('marul', 1) then
        xPlayer.addInventoryItem('marul', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('bros-burgers:chedarvers')
AddEventHandler('bros-burgers:chedarvers', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('chemicals', 1) then
        xPlayer.addInventoryItem('chemicals', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('bros-burgers:susamliekmekver')
AddEventHandler('bros-burgers:susamliekmekver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('susamliekmek', 1) then
        xPlayer.addInventoryItem('susamliekmek', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('bros-burgers:burgervers')
AddEventHandler('bros-burgers:burgervers', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('glass') >= 20 then
        if xPlayer.getQuantity('plastic') >= 20 then
                if xPlayer.canCarryItem('dalgictupu', 1) then
                    xPlayer.removeInventoryItem('glass', 20)
                    Citizen.Wait(250)
                    xPlayer.removeInventoryItem('plastic', 20)
                    Citizen.Wait(250)
                    xPlayer.addInventoryItem('dalgictupu', 1)
                else
                    TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
                end
        else
            TriggerClientEvent('esx:showNotification', src, 'Üzerinde yeterli malzeme yok!')
        end
    end
end)

RegisterServerEvent('bros-burgers:tavukvers')
AddEventHandler('bros-burgers:tavukvers', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('glass') >= 10 then
        if xPlayer.getQuantity('plastic') >= 10 then
                if xPlayer.canCarryItem('fixtool', 1) then
                    xPlayer.removeInventoryItem('glass', 10)
                    Citizen.Wait(250)
                    xPlayer.removeInventoryItem('plastic', 10)
                    Citizen.Wait(250)
                    xPlayer.addInventoryItem('fixtool', 1)
                else
                    TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
                end
        else
            TriggerClientEvent('esx:showNotification', src, 'Üzerinde yeterli malzeme yok!')
        end
    end
end)

RegisterServerEvent('bros-burgers:pizzaver')
AddEventHandler('bros-burgers:pizzaver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('glass') >= 20 then
        if xPlayer.getQuantity('plastic') >= 20 then
                if xPlayer.canCarryItem('lockpick', 1) then
                    xPlayer.removeInventoryItem('glass', 20)
                    Citizen.Wait(250)
                    xPlayer.removeInventoryItem('plastic', 20)
                    Citizen.Wait(250)
                    xPlayer.addInventoryItem('lockpick', 1)
                else
                    TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
                end
        else
            TriggerClientEvent('esx:showNotification', src, 'Üzerinde yeterli malzeme yok!')
        end
    end
end)

RegisterServerEvent('bros-burgers:paketvers')
AddEventHandler('bros-burgers:paketvers', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('rawy') >= 1 then
        if xPlayer.canCarryItem('karbuyusu', 1) then
            xPlayer.removeInventoryItem('rawy', 1)
            Citizen.Wait(500)
            xPlayer.addInventoryItem('karbuyusu', 1)
        else
            TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
        end
    end
end)

RegisterServerEvent('bros-burgers:tavukpaketvers')
AddEventHandler('bros-burgers:tavukpaketvers', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('rawy') >= 1 then
        if xPlayer.canCarryItem('buzbuyusu', 1) then
            xPlayer.removeInventoryItem('rawy', 1)
            Citizen.Wait(500)
            xPlayer.addInventoryItem('buzbuyusu', 1)
        else
            TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
        end
    end
end)

RegisterServerEvent('bros-burgers:burgersat')
AddEventHandler('bros-burgers:burgersat', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local money = math.random(Config.MinParaMiktar, Config.MaxParaMiktar)
    if xPlayer.getQuantity('burgerpaketi') >= 1 then
        xPlayer.removeInventoryItem('burgerpaketi', 1)
        Citizen.Wait(500)
        xPlayer.addMoney(money)
    end
end)

ESX.RegisterServerCallback('bros-burgers:malzemekontrol', function(source, cb, item, gereklisayi)
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

RegisterServerEvent('bros-jobvehs:takemoney')
AddEventHandler('bros-jobvehs:takemoney', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeAccountMoney('bank', 100)
    TriggerClientEvent('esx:showNotification', src, 'Depozito olarak banka hesabınızdan 100$ kesildi!')
end)

ESX.RegisterServerCallback("bros-jobvehs:givemoney", function(source, cb, verilecekpara)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.addAccountMoney('bank', verilecekpara)
    cb(true)
end)

