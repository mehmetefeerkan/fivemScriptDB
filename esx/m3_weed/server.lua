ESX = nil
loctable = {}
policetable = {}

cf = {
	EnableDiscordLog = true,
	WebhookUrl = '',
	WebhookName = 'm3 logger',
	WebhookAvatarUrl = 'https://i.imgyukle.com/2020/05/11/r8k2GI.png',
}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
	getCurrentLocation()
end)

ESX.RegisterServerCallback('m3-drug:ikontrol', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local quantity = xPlayer.getQuantity(item)
    
    cb(quantity)
end)

function getCurrentLocation()
	exports.ghmattimysql:execute('SELECT * FROM m3_weedcoords WHERE burned = @burned', {['@burned'] = 0}, function(results)
		if results[1] ~= nil then
			for i=1, #results, 1 do
				if not results[i].burned then
					loctable.coord = vector3(results[i].x, results[i].y, results[i].z)
					loctable.radius = results[i].radius
					return
				end
			end
		else
			loctable.coord = vector3(-940.2, 2208.79, 148.54)
			loctable.radius = 1.0
		end
	end)
end

ESX.RegisterServerCallback('m3:weed:server:getFieldCoord', function(source, cb)
	cb(loctable)
end)

RegisterServerEvent('m3:weed:server:burnField')
AddEventHandler('m3:weed:server:burnField', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
		if #policetable > 0 then
			for k, v in pairs(policetable) do
				if xPlayer.identifier == v then
					return
				end
			end
		end
		table.insert(policetable, xPlayer.identifier)
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Tarlayı yakmak için gerekli kalan polis sayısı: '..(Config.NeededCops - #policetable)})
		Citizen.Wait(60000)
		for k, v in pairs(policetable) do
			if xPlayer.identifier == v then
				table.remove(policetable, k)
				TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Tarlayı yakma isteğin artık geçersiz! Eğer hala yakmak istiyorsan tekrar yazmalısın.'})
			end
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Bunu yapamazsın!'})
	end
end)

Citizen.CreateThread(function()
	while true do
		if #policetable >= Config.NeededCops then
			MySQL.Async.execute('UPDATE m3_weedcoords SET burned = @burned WHERE x = @x AND y = @y AND z = @z', {['@x'] = loctable.coord.x, ['@y'] = loctable.coord.y, ['@z'] = loctable.coord.z, ['@burned'] = 1})
			for k, v in pairs(policetable) do
				local xPlayer = ESX.GetPlayerFromIdentifier(v)
				TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Tarla artık kullanılamaz halde!'})
			end
			TriggerClientEvent('m3:weed:client:burnFX', -1, loctable.coord)
			policetable = {}
			loctable.coord = vector3(-940.2, 2208.78, 148.54)
			loctable.radius = 1.0
		end
		Citizen.Wait(1000)
	end
end)

RegisterServerEvent('m3:weed:server:giveWeed')
AddEventHandler('m3:weed:server:giveWeed', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local count = Config.GiveWeedCount
	
	if xPlayer.canCarryItem('ot', count) then
		xPlayer.addInventoryItem('ot', count)
		TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = count..'x Esrar elde ettin!'})
		if cf.EnableDiscordLog then
			dclog(xPlayer, count..'x esrar elde etti!')
		end
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
	end
end)

RegisterServerEvent('m3:weed:server:giveSeed')
AddEventHandler('m3:weed:server:giveSeed', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local count = Config.GiveSeedCount
	local random = math.random(1, 2)
	
	if random > 1 then
		if xPlayer.canCarryItem('weed_seed_x', count) then
			xPlayer.addInventoryItem('weed_seed_x', count)
			TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = count..'x dişi esrar tohumu elde ettin!'})
			if cf.EnableDiscordLog then
				dclog(xPlayer, count..'x dişi esrar tohumu elde ettin!')
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
		end
	else
		if xPlayer.canCarryItem('weed_seed_y', count) then
			xPlayer.addInventoryItem('weed_seed_y', count)
			TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = count..'x erkek esrar tohumu elde ettin!'})
			if cf.EnableDiscordLog then
				dclog(xPlayer, count..'x erkek esrar tohumu elde ettin!')
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Daha fazlasını taşıyamazsın!'})
		end
	end
end)

RegisterServerEvent('m3:weed:server:removeSeed')
AddEventHandler('m3:weed:server:removeSeed', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer.getQuantity('weed_seed_x') > 0 then
		xPlayer.removeInventoryItem('weed_seed_x', 1)
	end
end)

RegisterServerEvent('m3:weed:server:removeSeedForSeed')
AddEventHandler('m3:weed:server:removeSeedForSeed', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer.getQuantity('weed_seed_y') > 0 then
		xPlayer.removeInventoryItem('weed_seed_y', 1)
	end
end)

ESX.RegisterUsableItem('weed_seed', function(source)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Bunu yapamazsın!'})
		return
	end

	TriggerClientEvent('m3:weed:client:usedSeed', source, loctable)
end)

ESX.RegisterUsableItem('weed_seed_y', function(source)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'Bunu yapamazsın!'})
		return
	end

	TriggerClientEvent('m3:weed:client:usedSeedForSeed', source, loctable)
end)

function dclog(xPlayer, text)
	local playerName = Sanitize(xPlayer.getName())
	
	local discord_webhook = GetConvar('discord_webhook', cf.WebhookUrl)
	if discord_webhook == '' then
	  return
	end
	local headers = {
	  ['Content-Type'] = 'application/json'
	}
	local data = {
	  ["username"] = cf.WebhookName,
	  ["avatar_url"] = cf.WebhookAvatarUrl,
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

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		print('[^2m3:weed^0] - Started!')
	end
end)