local kelepceleyenKisiler = {}

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)




ESX.RegisterUsableItem('handcuffs', function(source)
	TriggerClientEvent("kelepcele:menuAc", source)
end)

RegisterServerEvent('kelepcele:requestarrest')
AddEventHandler('kelepcele:requestarrest', function(targetid, playerheading, playerCoords,  playerlocation)
		local _source = source   
	    local xPlayer = ESX.GetPlayerFromId(_source)
		local handcuffs = xPlayer.getQuantity('handcuffs')
	
		if handcuffs > 0 then
			if kelepceleyenKisiler[targetid] == nil then
				xPlayer.removeInventoryItem('handcuffs', 1)
				TriggerClientEvent('kelepcele:getarrested', targetid, playerheading, playerCoords, playerlocation)
				TriggerClientEvent('kelepcele:doarrested', _source)
				kelepceleyenKisiler[targetid] = _source
			else
				TriggerClientEvent('esx:showNotification', _source, ('Oyuncu zaten kelepçeli.'))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, ('Kelepçen yok.'))
		end
end)

RegisterServerEvent('kelepcele:requestrelease')
AddEventHandler('kelepcele:requestrelease', function(targetid, playerheading, playerCoords,  playerlocation)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if kelepceleyenKisiler[targetid] == nil then
		TriggerClientEvent('esx:showNotification', _source, ('Oyuncu kelepçeli olmamalı.'))
	else
		if kelepceleyenKisiler[targetid] == _source then
			xPlayer.addInventoryItem('handcuffs', 1)
			TriggerClientEvent('kelepcele:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
			TriggerClientEvent('kelepcele:douncuffing', _source)
			TriggerClientEvent('esx_policejob:handcuff', targetid, false)
			kelepceleyenKisiler[targetid] = nil
		else
			TriggerClientEvent('esx:showNotification', _source, ('Sadece kişiyi kelepçeleyen kişinin kelepçesini açabilir.'))
		end
	end
end)

RegisterServerEvent('kelepcele:kelepce')
AddEventHandler('kelepcele:kelepce', function(targetid, playerheading, playerCoords,  playerlocation)
	local _source = source   
	local xPlayer = ESX.GetPlayerFromId(_source)
	local handcuffs = xPlayer.getQuantity('handcuffs')

	if kelepceleyenKisiler[targetid] == nil then
		if handcuffs > 0 then
			xPlayer.removeInventoryItem('handcuffs', 1)
			TriggerClientEvent('kelepcele:getarrested', targetid, playerheading, playerCoords, playerlocation)
			TriggerClientEvent('kelepcele:doarrested', _source)
			kelepceleyenKisiler[targetid] = _source
			triggerWaitAndToggle(targetid,true)
		else
			TriggerClientEvent('esx:showNotification', _source, ('Kelepçen yok.'))
		end
	else
		if kelepceleyenKisiler[targetid] == _source then
			xPlayer.addInventoryItem('handcuffs', 1)
			TriggerClientEvent('kelepcele:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
			TriggerClientEvent('kelepcele:douncuffing', _source)
			kelepceleyenKisiler[targetid] = nil
			triggerWaitAndToggle(targetid,false)
		else
			TriggerClientEvent('esx:showNotification', _source, ('Sadece kişiyi kelepçeleyen kişinin kelepçesini açabilir.'))
		end
	end
end)

function triggerWaitAndToggle(targetid,waitFirst)
	if waitFirst then
		Citizen.Wait(3000)
	end
		TriggerClientEvent('esx_policejob:handcuff', targetid)
end

RegisterServerEvent('kelepcele:softKelepce')
AddEventHandler('kelepcele:softKelepce', function(targetid)
	local _source = source   
	local xPlayer = ESX.GetPlayerFromId(_source)
	local handcuffs = xPlayer.getQuantity('handcuffs')

	if kelepceleyenKisiler[targetid] == nil then
		if handcuffs > 0 then
			xPlayer.removeInventoryItem('handcuffs', 1)
			TriggerClientEvent('esx_policejob:handcuff', targetid)
			kelepceleyenKisiler[targetid] = _source
		else
			TriggerClientEvent('esx:showNotification', _source, ('Kelepçen yok.'))
		end
	else
		if kelepceleyenKisiler[targetid] == _source then
			xPlayer.addInventoryItem('handcuffs', 1)
			TriggerClientEvent('esx_policejob:handcuff', targetid)
			kelepceleyenKisiler[targetid] = nil
		end
	end
end)



local datas = {}
RegisterServerEvent('kelepce:zorlaAc')
AddEventHandler('kelepce:zorlaAc',function(targetid, playerheading, playerCoords,  playerlocation)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if kelepceleyenKisiler[targetid] == nil then
		TriggerClientEvent('esx:showNotification', _source, ('Oyuncu kelepçeli olmamalı.'))
	else
	  TriggerClientEvent("kelepce:kirmaBaslat",_source,targetid, playerheading, playerCoords,  playerlocation)
	end	
end)

RegisterServerEvent('kelepce:zorlaDone')
AddEventHandler('kelepce:zorlaDone',function(targetid, playerheading, playerCoords,  playerlocation)
	TriggerClientEvent('kelepcele:getuncuffed', targetid, playerheading, playerCoords,  playerlocation)
	TriggerClientEvent('kelepcele:douncuffing', source)
	kelepceleyenKisiler[targetid] = nil
end)

ESX.RegisterServerCallback("kelepce:kelepceliMi",function(source,cb,id)
	if kelepceleyenKisiler[id] ~= nil then
		cb(true)
	else
		cb(false)
	end
end)

AddEventHandler("kelepcele:bobbyPin",function(id)
	if kelepceleyenKisiler[id] ~= nil then
		kelepceleyenKisiler[id] = nil
	end
end)