ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local instances = {}
local houses = {}

RegisterServerEvent('loaf_housing:leaveHouse')
AddEventHandler('loaf_housing:leaveHouse', function(house)
    local src = source
    if instances[houses[house]]['players'][src] then
        local oldPlayers = instances[houses[house]]['players']
        local newPlayers = {}
        for k, v in pairs(oldPlayers) do
            if v ~= src then
                newPlayers[k] = v
            end
        end
        instances[houses[house]]['players'] = newPlayers
    end
end)

RegisterServerEvent('loaf_housing:exitHouse')
AddEventHandler('loaf_housing:exitHouse', function(id)
    local src = source
    if instances[src] then
        for k, v in pairs(instances['players']) do
            TriggerClientEvent('loaf_housing:exitHouse', v, id)
            table.remove(instances, src)
            table.remove(houses, id)
        end
    else
        for k, v in pairs(instances) do
            if v['players'][src] then
                table.remove(v['players'], src)
            end
        end
    end
end)

RegisterServerEvent('loaf_housing:buyHouse')
AddEventHandler('loaf_housing:buyHouse', function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
        local house = json.decode(result[1].house)
        if house.houseId == 0 then
            MySQL.Async.fetchAll("SELECT * FROM bought_houses WHERE houseid=@houseid", {['@houseid'] = id}, function(result)
                local newHouse = ('{"owns":false,"furniture":[],"houseId":%s}'):format(id)
                if not result[1] then
                    if xPlayer.getAccount('bank').money >= Config.Houses[id]['price'] then
                        xPlayer.removeAccountMoney('bank', Config.Houses[id]['price'])
                        MySQL.Async.execute("UPDATE users SET house=@house WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@house'] = newHouse}) 
                        MySQL.Sync.execute("INSERT INTO bought_houses (houseid) VALUES (@houseid)", {['houseid'] = id})
                        dclog(xPlayer, 'Depo ev satın aldı  ' ..Config.Houses[id]['price'].. '$')
                        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Depo Ev satın aldınız şifresi: '..  Config.Houses[id]['pincode'])
                    else
                        if xPlayer.getMoney() >= Config.Houses[id]['price'] then
                            xPlayer.removeMoney(Config.Houses[id]['price'])
                            MySQL.Sync.execute("INSERT INTO bought_houses (houseid) VALUES (@houseid)", {['houseid'] = id})
                            MySQL.Async.execute("UPDATE users SET house=@house WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@house'] = newHouse}) 
                            dclog(xPlayer, 'Depo ev satın aldı  ' ..Config.Houses[id]['price'].. '$')
                            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Depo Ev satın aldınız şifresi: '..  Config.Houses[id]['pincode'])
                        else
                            TriggerClientEvent('esx:showNotification', source, 'Üzerinde yeterli para yok!')
                        end
                    end
                end
            end)
        end
    end)
    Wait(1500)
    TriggerClientEvent('loaf_housing:reloadHouses', -1)
end)

RegisterServerEvent("kagan-stash:setRoommate")
AddEventHandler("kagan-stash:setRoommate", function(target, houseID)
    local owner = ESX.GetPlayerFromId(source)
	local _target = target
	local tPlayer = ESX.GetPlayerFromId(_target)
    local newHouse = ('{"owns":false,"furniture":[],"houseId":%s}'):format(houseID)
    MySQL.Async.execute("UPDATE users SET house=@house WHERE identifier=@identifier", {['@identifier'] = tPlayer.identifier, ['@house'] = newHouse}) 
end)

function dclog(xPlayer, text)
    local playerName = Sanitize(xPlayer.getName())
    
    local discord_webhook = GetConvar('discord_webhook', 'https://discord.com/api/webhooks/814542734965997638/GFZLWrDIHOpGqizgZdLynv38zUUMzXJ71psPUBnYftjZ6sIfzIgoPMtMxa7vWT8CPJsX')
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = 'IMPERIAL | Depo Ev İşlemleri',
      ["avatar_url"] = 'https://cdn.discordapp.com/attachments/811012743246774272/811012863514247168/unknown.jpg',
      ["embeds"] = {{
        ["author"] = {
          ["name"] = playerName .. ' - ' .. xPlayer.identifier
        },
        ["color"] = 1942002,
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
      }}
    }
    data['embeds'][1]['description'] = text
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end

function Sanitize(str)
    local replacements = {
        ['&' ] = '&amp;',
        ['<' ] = '&lt;',
        ['>' ] = '&gt;',
        ['\n'] = '<br/>'
    }

    return str
        :gsub('[&<>\n]', replacements)
        :gsub(' +', function(s)
            return ' '..('&nbsp;'):rep(#s-1)
        end)
end

RegisterServerEvent('kagan-givehouse')
AddEventHandler('kagan-givehouse', function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
        local house = json.decode(result[1].house)
        if house.houseId == 0 then
            MySQL.Async.fetchAll("SELECT * FROM bought_houses WHERE houseid=@houseid", {['@houseid'] = id}, function(result)
                local newHouse = ('{"owns":false,"furniture":[],"houseId":%s}'):format(id)
                if not result[1] then
                    MySQL.Async.execute("UPDATE users SET house= @house WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@house'] = newHouse}) 
                    MySQL.Sync.execute("INSERT INTO bought_houses (houseid) VALUES (@houseid)", {['houseid'] = id})
                end
            end)
        end
    end)
    Wait(1500)
    TriggerClientEvent('loaf_housing:reloadHouses', -1)
end)


RegisterServerEvent('loaf_housing:sellHouse')
AddEventHandler('loaf_housing:sellHouse', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
        local house = json.decode(result[1].house)
        if Config.Houses[house.houseId]['price'] then
            xPlayer.addMoney(Config.Houses[house.houseId]['price'] * (Config.SellPercentage/100))
            local money =  Config.Houses[house.houseId]['price'] * Config.SellPercentage/100
            TriggerClientEvent('esx:showNotification', xPlayer.source, ("Evi %s fiyatına sattın."):format(math.floor(Config.Houses[house.houseId]['price'] * (Config.SellPercentage/100))))
            MySQL.Async.execute("UPDATE users SET house=@house WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@house'] = '{"owns":false,"furniture":[],"houseId":0}'}) 
            MySQL.Async.execute("DELETE FROM bought_houses WHERE houseid=@houseid", {['@houseid'] = house.houseId})
        end
        dclog(xPlayer, 'Depo evini sattı  - ' ..Config.Houses[house.houseId]['price'] * (Config.SellPercentage/100)..'$') 

    end)
    Wait(1500)
    TriggerClientEvent('loaf_housing:reloadHouses', -1)
end)

RegisterServerEvent('loaf_housing:getOwned')
AddEventHandler('loaf_housing:getOwned', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
        local house = json.decode(result[1].house)
        MySQL.Async.fetchAll("SELECT * FROM bought_houses", {}, function(result)
            TriggerClientEvent('loaf_housing:setHouse', xPlayer.source, house, result)
        end)
    end)
end)RegisterServerEvent('sand-housing:getpin')
AddEventHandler('sand-housing:getpin', f)



RegisterServerEvent('loaf_housing:furnish')
AddEventHandler('loaf_housing:furnish', function(house, furniture)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.execute("UPDATE users SET house=@house WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@house'] = json.encode(house)}) 
    MySQL.Async.execute("UPDATE users SET bought_furniture=@bought_furniture WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@bought_furniture'] = json.encode(furniture)}) 
end)

ESX.RegisterServerCallback('loaf_housing:hasGuests', function(source, cb)
    local hasGuest = false
    for k, v in pairs(instances[source]['players']) do
        local playerlist = GetPlayers()
        for id, src in pairs(playerlist) do
            if v ~= source and v == tonumber(src) then
                hasGuest = true
                break
            end
        end
    end
    cb(hasGuest)
end)


ESX.RegisterServerCallback('sp-housing:getPin', function(source, cb, houseid)
    MySQL.Async.fetchAll('SELECT * FROM bought_houses WHERE houseid=@houseid',
        {['@houseid'] = houseid},
        function(result)
        if result[1] ~= nil then
            print(result[1].housepin)
            cb(tonumber(result[1].housepin))
        end
    end)
end)

RegisterServerEvent('sp-housing:password')
AddEventHandler('sp-housing:password', function(houseid, password)

    MySQL.Async.execute("UPDATE bought_houses SET housepin=@password WHERE houseid=@houseid",
    {
        ['@password'] = password,
        ['@houseid'] = houseid
    })

end)
