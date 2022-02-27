ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



 RegisterServerEvent('itemver')
 AddEventHandler('itemver', function()
     local xPlayer = ESX.GetPlayerFromId(source)
     print('1')
    
     xPlayer.addInventoryItem('cash', 31)
    
 end)

RegisterServerEvent('kagan-toptanci:item')
AddEventHandler('kagan-toptanci:item', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)

    for k,v in pairs(Config.Recipes[item].RequiredItems) do
        if xPlayer.getInventoryItem(v.Item).count > v.Count then
            miktar = xPlayer.getInventoryItem(v.Item).count
            paramiktar = Config.Recipes[item].GiveItem.Count * miktar
            xItem = xPlayer.removeInventoryItem(v.Item, miktar)
            xPlayer.addMoney(paramiktar)
            dclog(xPlayer, 'Toptancıya -   ' ..miktar.. ' adet ' ..v.Item.. ' sattı. Satışdan aldığı para   ' ..paramiktar ..'$ amerikan doları')
        else
            --['mythic_notify']:DoHudText('type', 'Sattın')
        end
    end
end)


function dclog(xPlayer, text)
    local playerName = Sanitize(xPlayer.getName())
    
    local discord_webhook = GetConvar('discord_webhook', 'https://discord.com/api/webhooks/835573417687121941/Tk2I9a3Mj9sS_B-DSsP1e-BtmyjpIDKAQZzfv4QOkgGb5AejN5-ddB55K1Gu3wiDyLiX')
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = 'IMPERIAL | Toptancı Log',
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
