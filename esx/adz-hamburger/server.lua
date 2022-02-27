ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bros-burger:etver')
AddEventHandler('bros-burger:etver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('burgereti', 1) then
        xPlayer.addInventoryItem('burgereti', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('bros-burger:tavukkoftever')
AddEventHandler('bros-burger:tavukkoftever', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('tavukkofte', 1) then
        xPlayer.addInventoryItem('tavukkofte', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('bros-burger:patatesver')
AddEventHandler('bros-burger:patatesver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('burgerekmegi', 1) then
        xPlayer.addInventoryItem('burgerekmegi', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('bros-burger:ekmekver')
AddEventHandler('bros-burger:ekmekver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('burgerekmegi', 1) then
        xPlayer.addInventoryItem('burgerekmegi', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('bros-burger:ketcapver')
AddEventHandler('bros-burger:ketcapver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('ketcap', 1) then
        xPlayer.addInventoryItem('ketcap', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('bros-burger:mayonezver')
AddEventHandler('bros-burger:mayonezver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('mayonez', 1) then
        xPlayer.addInventoryItem('mayonez', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('bros-burger:marulver')
AddEventHandler('bros-burger:marulver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('marul', 1) then
        xPlayer.addInventoryItem('marul', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('bros-burger:chedarver')
AddEventHandler('bros-burger:chedarver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('chedar', 1) then
        xPlayer.addInventoryItem('chedar', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('bros-burger:susamliekmekver')
AddEventHandler('bros-burger:susamliekmekver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('susamliekmek', 1) then
        xPlayer.addInventoryItem('susamliekmek', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
    end
end)

RegisterServerEvent('bros-burger:burgerver')
AddEventHandler('bros-burger:burgerver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('burgereti') >= 1 then
        if xPlayer.getQuantity('burgerekmegi') >= 1 then
            if xPlayer.getQuantity('patates') >= 5 then
                if xPlayer.canCarryItem('hamburger', 1) then
                    xPlayer.removeInventoryItem('burgereti', 1)
                    Citizen.Wait(250)
                    xPlayer.removeInventoryItem('burgerekmegi', 1)
                    Citizen.Wait(250)
                    xPlayer.removeInventoryItem('patates', 5)
                    Citizen.Wait(500)
                    xPlayer.addInventoryItem('hamburger', 1)
                else
                    TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
                end
            else
                TriggerClientEvent('esx:showNotification', src, 'Üzerinde yeterli malzeme yok!')
            end
        else
            TriggerClientEvent('esx:showNotification', src, 'Üzerinde yeterli malzeme yok!')
        end
    end
end)

RegisterServerEvent('bros-burger:tavukver')
AddEventHandler('bros-burger:tavukver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('tavukkofte') >= 1 then
        if xPlayer.getQuantity('mayonez') >= 1 then
            if xPlayer.getQuantity('marul') >= 5 then
                if xPlayer.canCarryItem('fowlburger', 1) then
                    xPlayer.removeInventoryItem('tavukkofte', 1)
                    Citizen.Wait(250)
                    xPlayer.removeInventoryItem('mayonez', 1)
                    Citizen.Wait(250)
                    xPlayer.removeInventoryItem('marul', 5)
                    Citizen.Wait(500)
                    xPlayer.addInventoryItem('fowlburger', 1)
                else
                    TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
                end
            else
                TriggerClientEvent('esx:showNotification', src, 'Üzerinde yeterli malzeme yok!')
            end
        else
            TriggerClientEvent('esx:showNotification', src, 'Üzerinde yeterli malzeme yok!')
        end
    end
end)

RegisterServerEvent('bros-burger:pizzaver')
AddEventHandler('bros-burger:pizzaver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('susamliekmek') >= 1 then
        if xPlayer.getQuantity('ketcap') >= 1 then
            if xPlayer.getQuantity('chedar') >= 1 then
                if xPlayer.canCarryItem('pizza', 1) then
                    xPlayer.removeInventoryItem('susamliekmek', 1)
                    Citizen.Wait(250)
                    xPlayer.removeInventoryItem('ketcap', 1)
                    Citizen.Wait(250)
                    xPlayer.removeInventoryItem('chedar', 1)
                    Citizen.Wait(500)
                    xPlayer.addInventoryItem('pizza', 1)
                else
                    TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
                end
            else
                TriggerClientEvent('esx:showNotification', src, 'Üzerinde yeterli malzeme yok!')
            end
        else
            TriggerClientEvent('esx:showNotification', src, 'Üzerinde yeterli malzeme yok!')
        end
    end
end)

RegisterServerEvent('bros-burger:paketver')
AddEventHandler('bros-burger:paketver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('domates') >= 5 then
        if xPlayer.canCarryItem('ketcap', 1) then
            xPlayer.removeInventoryItem('domates', 5)
            Citizen.Wait(500)
            xPlayer.addInventoryItem('ketcap', 1)
        else
            TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
        end
    end
end)

RegisterServerEvent('bros-burger:tavukpaketver')
AddEventHandler('bros-burger:tavukpaketver', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('file_patates') >= 5 then
        if xPlayer.canCarryItem('patates', 1) then
            xPlayer.removeInventoryItem('file_patates', 5)
            Citizen.Wait(500)
            xPlayer.addInventoryItem('patates', 1)
        else
            TriggerClientEvent('esx:showNotification', src, 'Üzerinde bunu taşıyacak yer yok!')
        end
    end
end)

RegisterServerEvent('bros-burger:burgersat')
AddEventHandler('bros-burger:burgersat', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local money = math.random(Config.MinParaMiktar, Config.MaxParaMiktar)
    if xPlayer.getQuantity('burgerpaketi') >= 1 then
        xPlayer.removeInventoryItem('burgerpaketi', 1)
        Citizen.Wait(500)
        xPlayer.addMoney(money)
    end
end)

ESX.RegisterServerCallback('bros-burger:malzemekontrol', function(source, cb, item, gereklisayi)
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

RegisterServerEvent('bros-jobveh:takemoney')
AddEventHandler('bros-jobveh:takemoney', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.removeAccountMoney('bank', 100)
    TriggerClientEvent('esx:showNotification', src, 'Depozito olarak banka hesabınızdan 100$ kesildi!')
end)

ESX.RegisterServerCallback("bros-jobveh:givemoney", function(source, cb, verilecekpara)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    xPlayer.addAccountMoney('bank', verilecekpara)
    cb(true)
end)

