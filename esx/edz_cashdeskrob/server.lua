ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('thermite', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("edz-cashdeskrob:attemp", source)
end)

ESX.RegisterServerCallback('edz-cashdeskrob:copCount', function(source, cb)
	local xPlayers = ESX.GetPlayers()

	copConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
			copConnected = copConnected + 1
		end
	end

	cb(copConnected)
end)

function dclog(xPlayer, text)
    local playerName = Sanitize(xPlayer.getName())
  
    local discord_webhook = "https://discord.com/api/webhooks/816791933040328704/0agkGEdUPg7TkxyEJg1jc3fsid4IVz3DNwMK3uOZq3k6OArPylolZQ7ZFW3bb6s2phg8"
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "IMPERIAL | Vezne Soygunu Log",
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

RegisterServerEvent('edz-cashdeskrob:giveMoney')
AddEventHandler('edz-cashdeskrob:giveMoney', function(money)
    local xPlayer = ESX.GetPlayerFromId(source)
	--xPlayer.addMoney(money)
	xPlayer.addAccountMoney('money', money)
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = money..'$ aldın'})
	dclog(xPlayer, 'Soyulan vezne soygunundan çıkan para miktarı = ' ..money.. '$')
end)

RegisterServerEvent('edz-cashdeskrob:deleteItem')
AddEventHandler('edz-cashdeskrob:deleteItem', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(item, 1)
end)