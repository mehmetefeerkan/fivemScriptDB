ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local selling = 0

local items = {
    "gomlek_kumasi",
    "pantolon_kumasi",
    "tshirt_kumasi"
}


RegisterServerEvent('kvl-terzi:yuntopla')
AddEventHandler('kvl-terzi:yuntopla', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.canCarryItem('yun', 1) then
        xPlayer.addInventoryItem('yun', 1)
    else
        TriggerClientEvent('esx:showNotification', src, 'Envanterinde yeterli alan yok')
    end
end)

RegisterServerEvent('kvl-terzi:yunprocess')
AddEventHandler('kvl-terzi:yunprocess', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('yun') >= 2 then
        if xPlayer.canCarryItem('islenmis_yun', 1) then
            xPlayer.removeInventoryItem('yun', 2)
            Citizen.Wait(500)
            xPlayer.addInventoryItem('islenmis_yun', 1)
        else
            TriggerClientEvent('esx:showNotification', src, 'Envanterinde yeterli malzeme yok')
        end
    end
end)


RegisterServerEvent('kvl-terzi:kumasuret')
AddEventHandler('kvl-terzi:kumasuret', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local item = items[math.random(1, #items)]
    if xPlayer.getQuantity('islenmis_yun') >= 1 then
        if xPlayer.canCarryItem(item, 1) then
            xPlayer.removeInventoryItem('islenmis_yun', 1)
            Citizen.Wait(500)
            xPlayer.addInventoryItem(item, 1)
        else
            TriggerClientEvent('esx:showNotification', src, 'Envanterinde yeterli malzeme yok')
        end
    end
end)

-----------------------  ## GOMLEK ## -----------------------
RegisterServerEvent('kvl-terzi:gomlekdik')
AddEventHandler('kvl-terzi:gomlekdik', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('gomlek_kumasi') >= 1 then
        if xPlayer.canCarryItem('gomlek', 1) then
            xPlayer.removeInventoryItem('gomlek_kumasi', 1)
            Citizen.Wait(500)
            xPlayer.addInventoryItem('gomlek', 1)
        else
            TriggerClientEvent('esx:showNotification', src, 'Envanterinde yeterli malzeme yok')
        end
    end
end)
-----------------------  ## PANTOLON ## -----------------------
RegisterServerEvent('kvl-terzi:pantolondik')
AddEventHandler('kvl-terzi:pantolondik', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('pantolon_kumasi') >= 1 then
        if xPlayer.canCarryItem('pantolon', 1) then
            xPlayer.removeInventoryItem('pantolon_kumasi', 1)
            Citizen.Wait(500)
            xPlayer.addInventoryItem('pantolon', 1)
        else
            TriggerClientEvent('esx:showNotification', src, 'Envanterinde yeterli malzeme yok')
        end
    end
end)
-----------------------  ## TSHIRT ## -----------------------
RegisterServerEvent('kvl-terzi:tshirtdik')
AddEventHandler('kvl-terzi:tshirtdik', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getQuantity('tshirt_kumasi') >= 1 then
        if xPlayer.canCarryItem('tshirt', 1) then
            xPlayer.removeInventoryItem('tshirt_kumasi', 1)
            Citizen.Wait(500)
            xPlayer.addInventoryItem('tshirt', 1)
        else
            TriggerClientEvent('esx:showNotification', src, 'Envanterinde yeterli malzeme yok')
        end
    end
end)

------------------------------------------------------------
RegisterServerEvent('kvl-terzi:Sell')
AddEventHandler('kvl-terzi:Sell', function(method, sell, item, count, price)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if count >= 0 then
        local reward = count * price
        xPlayer.showNotification("Şu eşyayı: "..item.." şu kadar dolara sattın "..reward)
        xPlayer.removeInventoryItem(item, count)
        xPlayer.addMoney(reward)
        dclog(xPlayer, '** '..count.. ' adet ' ..item.. ' satışı yaptı ' ..reward.. ' $ dolar kazandı**')
     --[[
        if method == 1 then -- ? Diğeri
            if sell >= 30 then
                TriggerEvent("kvl-terzi:AddExp", src, 1) -- 1
            end
        elseif method == 2 then -- ? Kaliteli eşya satımı
            if sell >= 30 then
                TriggerEvent("kvl-terzi:AddExp", src, 3) -- 3 yerine Arttırmak istediğin xp miktarı
            end
        end
        --]]
    else
        xPlayer.showNotification("Üstünde yeterli sayıda: "..item.." Yok")
    end
end)
--[[
RegisterServerEvent('kvl-terzi:AddExp')
AddEventHandler('kvl-terzi:AddExp', function(player, XPS) -- xps = Arttırmak istediğin xp miktarı
    local xPlayer = ESX.GetPlayerFromId(player)
    local result = exports.ghmattimysql:executeSync('SELECT xp FROM users WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier})

    -- ? result[1].xp = Mysqldeki users tablosundaki xp değeri
    if result[1].xp >= 10 then
        return xPlayer.showNotification("XPN MAKSİMUM LİMİTE ULAŞTI") 
    end

    AddXP = result[1].xp + XPS
    exports.ghmattimysql:execute('UPDATE `users` SET `xp` = @xp WHERE identifier = @identifier ', {
        ['@xp'] = AddXP,
        ['@identifier'] = xPlayer.identifier
    })
end)
--]]
ESX.RegisterServerCallback('kvl-terzi:GetMyItems', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)

    local count = xPlayer.getQuantity(item).count

    if count ~= nil and count ~= 0  then
        cb(count)
    else
        xPlayer.showNotification("Üstünde yeterli sayıda: "..item.." Yok")
    end
end)
--[[
RegisterServerEvent('kvl-terzi:GetExp')
AddEventHandler('kvl-terzi:GetExp', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    local result = exports.ghmattimysql:executeSync('SELECT xp FROM users WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier})

    if result ~= nil then
        TriggerClientEvent('kvl-terzi:GetExp', src, result[1].xp)
    else
        TriggerClientEvent('kvl-terzi:GetExp', src, 0)
    end
end)
--]]

function dclog(xPlayer, text)
    local playerName = Sanitize(xPlayer.getName())
  
    local discord_webhook = "https://discord.com/api/webhooks/796648399142912031/DWtLcnfQuCMH3qOpUNbXvfqSOqwH4P7qsHAjojCnvZ9__AIPRZVJ9uV_27PiqmPz_zaE"
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "KVL Logger | Terzi Satış",
      ["avatar_url"] = "https://cdn.discordapp.com/attachments/748889854305239111/796650387955908648/lexia1024.jpg",
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