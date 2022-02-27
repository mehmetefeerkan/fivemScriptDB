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
    if xPlayer.getInventoryItem('tacoeti').count >= 1 then
        if xPlayer.getInventoryItem('tacoekmegi').count >= 1 then
            if xPlayer.getInventoryItem('tacomalzemesi').count >= 1 then
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
    if xPlayer.getInventoryItem('taco').count >= 1 then
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
    if xPlayer.getInventoryItem('tacopaketi').count >= 1 then
        xPlayer.removeInventoryItem('tacopaketi', 1)
        Citizen.Wait(500)
        xPlayer.addMoney(money)
        dclog(xPlayer, '** 1 adet paketlenmiş taco sattı kazandığı miktar = ' ..money.. ' $ amerikan doları**')
    end
end)

ESX.RegisterServerCallback('utx-taco:malzemekontrol', function(source, cb, item, gereklisayi)
	local xPlayer = ESX.GetPlayerFromId(source)
    local itemcount = xPlayer.getInventoryItem(item).count
    local itemname = xPlayer.getInventoryItem(item).label
	if itemcount >= gereklisayi then
		cb(true)
	else
        activity = 0
        TriggerClientEvent('esx:showNotification', source, 'Üzerinde yeterli '..itemname..' yok!')
	end
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
      ["username"] = "IMPERIAL LOG",
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