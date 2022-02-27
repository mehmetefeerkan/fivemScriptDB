ESX = nil
webhook = ''
local DISCORDS_NAME = "back logger"
local DISCORDS_IMAGE = "https://cdn.discordapp.com/attachments/748908369414455302/779298688400883753/0r2EZV.png" -- default is FiveM logo

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



-- RegisterServerEvent('itemver')
-- AddEventHandler('itemver', function()
--     local xPlayer = ESX.GetPlayerFromId(source)
--     print('1')
    
--     xPlayer.addInventoryItem('cash', 31)
    
-- end)

RegisterServerEvent('kagan-toptanci:item')
AddEventHandler('kagan-toptanci:item', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)

    for k,v in pairs(Config.Recipes[item].RequiredItems) do
        if xPlayer.getQuantity(v.Item) > v.Count then
            miktar = xPlayer.getQuantity(v.Item)
            paramiktar = Config.Recipes[item].GiveItem.Count * miktar
            xItem = xPlayer.removeInventoryItem(v.Item, miktar)
            -- xPlayer.addInventoryItem(Config.Recipes[item].GiveItem.Item, Config.Recipes[item].GiveItem.Count)
            xPlayer.addMoney(paramiktar)
            -- TriggerClientEvent('sup-notif', source, item.. ' Sattın', 1)
            -- exports['mythic_notify']:SendAlert('success', 'x'.. miktar ..' '.. item .. ' sattın')
            sendToDiscord("Karaborsacı - Satış", " **"..getPlayerInfo(source).."** kişisi toptancıya **".. miktar .. "x " ..item .."** sattı, **" .. paramiktar .. "$** kazandı.", 16744576, webhook)
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = ''.. miktar ..'x '.. item .. ' sattın, ' .. paramiktar .. '$ kazandın.', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
            -- dclog(xPlayer, 'Toptancida eşya sattı eşya - ' ..v.Item.. ' miktarı - ' ..miktar.. '  Satışdan Aldıgı Para   ' ..paramiktar ..'$')
        else
          TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Üzerinizde bu eşyadan en az 2 adet olmali.', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
        end
    end


end)

function sendToDiscord(name, message, color, selam)
	local connect = {
		  {
			  ["color"] = color,
			  ["title"] = "**".. name .."**",
			--   ["url"] = "https://bulogsistemithermitetarafındanyapılmıstır.com",
			  ["description"] = message,
			  ["footer"] = {
			  ["text"] = os.date('!%Y-%m-%d - %H:%M:%S') .. " - Back Roleplay",
			  },
		  }
	  }
	PerformHttpRequest(selam, function(err, text, headers) end, 'POST', json.encode({username = DISCORDS_NAME, embeds = connect, avatar_url = DISCORDS_IMAGE}), { ['Content-Type'] = 'application/json' })
end

function getPlayerInfo(player)
	local _player = player
	local infoString = GetPlayerName(_player) .. " (" .. _player .. ")"
	-- if Config.BilgileriPaylas then
		for k,v in pairs(GetPlayerIdentifiers(_player)) do
			if string.sub(v, 1, string.len("discord:")) == "discord:" then
				infoString = infoString .. "\n<@" .. string.gsub(v,"discord:","") .. ">"
			else
				infoString = infoString .. "\n" .. v
			end
		end
	-- end
	return infoString
end
