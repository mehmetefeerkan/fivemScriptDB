ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('mxa-selling:sell')
AddEventHandler('mxa-selling:sell', function (item, price)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local miktar = xPlayer.getInventoryItem(item).count
    local xItem = xPlayer.getInventoryItem(item)
        if item ~= nil or price ~= nil then
        if xItem.count >= 1 then
            xPlayer.addMoney(price * xItem.count)
            xPlayer.removeInventoryItem(item, xItem.count)
            xPlayer.showNotification(''..item..' eşyasını '..price*xItem.count..'$ dolara sattın ')
            dclog(xPlayer, 'Alıcıya item sattı "' ..item.. '" sattığı item miktarı - ('..miktar..')  Satışdan aldığı para ' ..price*xItem.count..'$ amerikan doları')
        else
            xPlayer.showNotification('Neye baktın adamım!?')
            --xPlayer.showNotification('Üstünde alacağım eşyadan yeterli sayıda yok')
            --xPlayer.showNotification('Üstünüzde şu eşyadan '..item..' yeterli sayıda yok')
        end
    end
end)

function dclog(xPlayer, text)
    local playerName = Sanitize(xPlayer.getName())
  
    local discord_webhook = "https://discord.com/api/webhooks/816793015837655041/jNJ-iNwsLbRib8kVxzURpZkxF0sGa2_o--sJm4I_pjR84I3OdSnYdmneKeVfn-Fty8PJ"
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "IMPERIAL | NPC Alıcı Log",
      ["avatar_url"] = "https://cdn.discordapp.com/attachments/811012743246774272/811012863514247168/unknown.jpg",
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