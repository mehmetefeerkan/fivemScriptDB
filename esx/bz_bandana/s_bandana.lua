ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

itemler = {
	'morbandana',
	'kirmizibandana',
	'mavibandana',
	'greenbandana',
	'saribandana'
}

ESX.RegisterServerCallback('bz:bandana', function(source, cb, target)

local xPlayer = ESX.GetPlayerFromId(target)
local yPlayer = ESX.GetPlayerFromId(source)

local data = {
	name = GetPlayerName(target),
	envanter = xPlayer.inventory
}

local itemyokla = false
for i=1, #itemler, 1 do
	local items = tostring(itemler[i])
	local bandanacheck = xPlayer.getInventoryItem(items).count
    if bandanacheck > 0 then
        itemyokla = true
		yPlayer.addInventoryItem(items, 1)
		xPlayer.removeInventoryItem(items, 1)
		Wait(100)
		yPlayer.removeInventoryItem(items, 1)
		TriggerClientEvent('notification', source, 'Helal bee, Takımına bir sayı daha yazdırdın!', 1)

		if items ~= 'ballasbandana' and (xPlayer.job.name == 'mavi' or xPlayer.job.name == 'kirmizi' or xPlayer.job.name == 'yesil' or xPlayer.job.name == 'sari') and yPlayer.job.name == 'mor'  then
			local arti = MySQL.Async.fetchScalar("SELECT mor FROM bz_bandana", {}, function(mor)
			if mor then
			local ekle = json.decode(mor)
			
			MySQL.Async.execute('UPDATE bz_bandana SET mor=@mor', {
			['@mor'] = json.encode(ekle) + 1
			})
		
			end
			end)
		elseif items ~= 'cripsbandana' and (xPlayer.job.name == 'mor' or xPlayer.job.name == 'kirmizi' or xPlayer.job.name == 'yesil' or xPlayer.job.name == 'sari') and yPlayer.job.name == 'mavi' then
			local arti = MySQL.Async.fetchScalar("SELECT mavi FROM bz_bandana", {}, function(mavi)
			if mavi then
			local ekle = json.decode(mavi)
			
			MySQL.Async.execute('UPDATE bz_bandana SET mavi=@mavi', {
			['@mavi'] = json.encode(ekle) + 1
			})
		
			end
			end)
		elseif items ~= 'bloodsbandana' and (xPlayer.job.name == 'mavi' or xPlayer.job.name == 'mor' or xPlayer.job.name == 'yesil' or xPlayer.job.name == 'sari') and yPlayer.job.name == 'kirmizi' then
			local arti = MySQL.Async.fetchScalar("SELECT kirmizi FROM bz_bandana", {}, function(kirmizi)
			if kirmizi then
			local ekle = json.decode(kirmizi)
			
			MySQL.Async.execute('UPDATE bz_bandana SET kirmizi=@kirmizi', {
			['@kirmizi'] = json.encode(ekle) + 1
			})
		
			end
			end)
		elseif items ~= 'greenbandana' and (xPlayer.job.name == 'mavi' or xPlayer.job.name == 'mor' or xPlayer.job.name == 'kirmizi' or xPlayer.job.name == 'sari') and yPlayer.job.name == 'yesil' then
			local arti = MySQL.Async.fetchScalar("SELECT yesil FROM bz_bandana", {}, function(yesil)
			if yesil then
			local ekle = json.decode(yesil)
			
			MySQL.Async.execute('UPDATE bz_bandana SET yesil=@yesil', {
			['@yesil'] = json.encode(ekle) + 1
			})
		
			end
			end)
		elseif items ~= 'vagosbandana' and (xPlayer.job.name == 'mavi' or xPlayer.job.name == 'mor' or xPlayer.job.name == 'yesil' or xPlayer.job.name == 'kirmizi') and yPlayer.job.name == 'sari' then
			local arti = MySQL.Async.fetchScalar("SELECT sari FROM bz_bandana", {}, function(sari)
			if sari then
			local ekle = json.decode(sari)
			
			MySQL.Async.execute('UPDATE bz_bandana SET sari=@sari', {
			['@sari'] = json.encode(ekle) + 1
			})
		
			end
			end)
		end
		

		break
    end
end

if not itemyokla then
TriggerClientEvent('notification', source, 'Üzerinde bandanası yok!', 2)
end

cb(data)

end)

RegisterCommand('bandanalist', function(source)

local xPlayer = ESX.GetPlayerFromId(source)

MySQL.Async.fetchAll('SELECT * FROM bz_bandana', {}, function(ceteler)
if ceteler then
for i=1, #ceteler, 1 do
local mor = json.decode(ceteler[i].mor)
local sari = json.decode(ceteler[i].sari)
local kirmizi = json.decode(ceteler[i].kirmizi)
local yesil = json.decode(ceteler[i].yesil)
local mavi = json.decode(ceteler[i].mavi)

TriggerClientEvent('chatMessage', xPlayer.source, '^0^*mavi Takımı ^1'..json.encode(mavi)..'^0 bandana toplamış!')
TriggerClientEvent('chatMessage', xPlayer.source, '^0^*mor Takımı ^1'..json.encode(mor)..'^0 bandana toplamış!')
TriggerClientEvent('chatMessage', xPlayer.source, '^0^*kirmizi Takımı ^1'..json.encode(kirmizi)..'^0 bandana toplamış!')
TriggerClientEvent('chatMessage', xPlayer.source, '^0^*yesil Takımı ^1'..json.encode(yesil)..'^0 bandana toplamış!')
TriggerClientEvent('chatMessage', xPlayer.source, '^0^*sari Takımı ^1'..json.encode(sari)..'^0 bandana toplamış!')



end
end
end)

end)