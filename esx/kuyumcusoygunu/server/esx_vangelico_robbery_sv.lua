local lastrobbed = 0
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_vangelico_robbery:gioielli')
AddEventHandler('esx_vangelico_robbery:gioielli', function(min, max)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local rastgele = math.random(min, max)
	TriggerEvent('DiscordBot:ToDiscord', 'eventpara', 'Ex-RP', xPlayer.identifier..'('..xPlayer.name..') Mücevher Topluyor: ' .. rastgele.. ' Tane ', 'IMAGE_URL', true)
	if xPlayer.canCarryItem('rolex', rastgele) then
		xPlayer.addInventoryItem('rolex', rastgele)
	else
		xPlayer.showNotification("Mücevherleri Alamadın Çünkü Fazla Ağırsın")
	end
end)

RegisterServerEvent('esx_vangelico_robbery:soyguntamam')
AddEventHandler('esx_vangelico_robbery:soyguntamam', function(idno)
	TriggerClientEvent("esx_vangelico_robbery:soyguntamamclient", idno)
end)

RegisterServerEvent('esx_vangelico_robbery:kontrol')
AddEventHandler('esx_vangelico_robbery:kontrol', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if (os.time() - lastrobbed) < Config.SecBetwNextRob and lastrobbed ~= 0 then
		xPlayer.showNotification("Vitrinler Kırılmış Gibi")
	else
		xPlayer.showNotification("Vitrinler Sağlam Gözüküyor")
	end
end)

ESX.RegisterServerCallback('esx_vangelico_robbery:kart-soygun-kontrol', function(source, cb)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	if (os.time() - lastrobbed) < Config.SecBetwNextRob and lastrobbed ~= 0 then
		xPlayer.showNotification("Mücevherci Zaten Soyulmuş")
		cb(false)
	else
		if xPlayer.getQuantity("guvenlikkarti") <= 0 then
			xPlayer.showNotification("Üstünde Gerekli Kart Yok!")
			cb(false)
		else
			lastrobbed = os.time()
			xPlayer.removeInventoryItem("guvenlikkarti", 1)
			cb(true)
		end
	end
end)

RegisterServerEvent('esx_vangelice_robbery:elektrik-kes')
AddEventHandler('esx_vangelice_robbery:elektrik-kes', function()
	TriggerClientEvent("esx_vangelice_robbery:elektrik-kes-client", -1, true)
	Citizen.Wait(1800000)
	TriggerClientEvent("esx_vangelice_robbery:elektrik-kes-client", -1, false)
end)

RegisterServerEvent('esx_vangelice_robbery:kapi-ac')
AddEventHandler('esx_vangelice_robbery:kapi-ac', function()
	TriggerClientEvent("esx_vangelice_robbery:kapi-ac-client", -1)
end)

ESX.RegisterServerCallback('esx_vangelico_robbery:aktif-polis-sayisi', function(source, cb, playerId)
	PoliceConnected = 0
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			PoliceConnected = PoliceConnected + 1
		end	
	end
	cb(PoliceConnected)
end)