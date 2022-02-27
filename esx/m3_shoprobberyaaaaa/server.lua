ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('m3:shoprobbery:copCount', function(source, cb)
	local xPlayers = ESX.GetPlayers()

	copConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or  xPlayer.job.name == 'sheriff' then
			copConnected = copConnected + 1
		end
	end

	cb(copConnected)
end)

ESX.RegisterServerCallback('m3:shoprobbery:getTime', function(source, cb)
    cb(os.time())
end)

ESX.RegisterServerCallback('m3:shoprobbery:getShops', function(source, cb, shopid)
	MySQL.Async.fetchAll('SELECT * FROM m3_robshops WHERE shopid = @shopid', {
		['@shopid'] = shopid,
	}, function(result)
		if result[1] ~= nil then
			cb(result[1])
		else
			cb(nil)
		end
	end)
end)

RegisterServerEvent('m3:shoprobbery:robbedUpdate')
AddEventHandler('m3:shoprobbery:robbedUpdate', function(id)
    if id ~= nil then
        MySQL.Async.execute("UPDATE m3_robshops SET robtime = @robtime WHERE shopid = @shopid", {['@shopid'] = id, ['robtime'] =  os.time()}) --  
    end
end)

RegisterServerEvent('m3:shoprobbery:giveMoney')
AddEventHandler('m3:shoprobbery:giveMoney', function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.addMoney(money)
	TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Kasadan ' .. money .. '$ çıktı!', length = 4000})
	if Config.EnableDiscordLog then
		dclog(xPlayer, 'Market kasasını açmayı başardı. **Kazanç**: '..money..'$')
	end
end)

RegisterServerEvent('m3:shoprobbery:blipRobCop')
AddEventHandler('m3:shoprobbery:blipRobCop', function(x, y ,z)
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
			TriggerClientEvent('m3:shoprobbery:blipRobCopC', xPlayer.source, x, y ,z)
		end
	end
end)

RegisterServerEvent('m3:shoprobbery:notifyPolice')
AddEventHandler('m3:shoprobbery:notifyPolice', function()
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Market soygunu var!', length = 10000})
		end
	end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		print('[^2m3:shoprobbery^0] - Started!')
	end
end)

function dclog(xPlayer, text)
	local playerName = Sanitize(xPlayer.getName())
	
	local discord_webhook = GetConvar('discord_webhook', Config.DiscordWebhook)
	if discord_webhook == '' then
	  return
	end
	local headers = {
	  ['Content-Type'] = 'application/json'
	}
	local data = {
	  ["username"] = Config.WebhookName,
	  ["avatar_url"] = Config.WebhookAvatarUrl,
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
