ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

RegisterCommand('kosetut', function(source, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local copsOnDuty = 0
    local Players = ESX.GetPlayers()
    for i = 1, #Players do
        local xPlayer = ESX.GetPlayerFromId(Players[i])
        if xPlayer["job"]["name"] == "police" then
            copsOnDuty = copsOnDuty + 1
        end
    end

    if copsOnDuty < Config.MinPolis then
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "Yeteri kadar polis yok. Gerekli polis sayısı: "..Config.MinPolis, length = 10000})
    return
    end

    TriggerClientEvent('sydres:OpenMenu', _source)
end)




ESX.RegisterServerCallback('sydres:TakeInfo', function(source, cb, pltItem) -- when player interaction to weed, take info from db
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local itemcount = xPlayer.getQuantity(pltItem.name)
    local itemlabel = xPlayer.getQuantity(pltItem.name)
    local silincekitem = math.random(1, 5)
    local tanefiyatimeth = 150
    local tanefiyatiweed = 110
    local alinacakparameth = silincekitem * tanefiyatimeth
    local alinacakparaweed = silincekitem * tanefiyatiweed
    local cbtable = {}
    if itemcount < 1 then
        table.insert(cbtable,{statu = false, itemlabel = itemlabel , price = pltItem.price})

    else
        local itemamount = math.random((pltItem.price / 10 )* 9, ( pltItem.price / 10 ) * 11)
        if pltItem.name == "meth" then
            table.insert(cbtable,{statu = true, itemlabel = itemlabel,  price = itemamount})
            xPlayer.removeInventoryItem(pltItem.name, silincekitem)
            xPlayer.addMoney(alinacakparameth)
        end
        if pltItem.name == "weed" then
            table.insert(cbtable,{statu = true, itemlabel = itemlabel,  price = itemamount})
            xPlayer.removeInventoryItem(pltItem.name, silincekitem)
            xPlayer.addMoney(alinacakparaweed)
        end
    end
    cb(cbtable[1])
    
end)

RegisterServerEvent('sydres:udanyzakup')
AddEventHandler('sydres:udanyzakup', function(x, y, z)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local infoPsy = math.random(1,100)
    if infoPsy <= 30 then --%30 ihtimalle polisi arıyor
    TriggerClientEvent('sydres:infoPolicja', -1, x, y, z)
    Wait(500)
    end
end)

RegisterServerEvent('sydres:policeNotify')
AddEventHandler('sydres:policeNotify', function(x, y, z)
    local infoPsy = math.random(1,100)
    if infoPsy <= Config.PoliceNotify then --%30 ihtimalle polisi arıyor
    TriggerClientEvent('sydres:infoPolicja', -1, x, y, z)
    Wait(500)
    end
end)

ESX.RegisterUsableItem('hackertablet', function(source)
    local player = ESX.GetPlayerFromId(source)
    TriggerClientEvent('sydres:OpenMenu', source)
    player.showNotification('Hacker Tableti!')
end)
