ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


-- RegisterServerEvent('esx_outlawalert:gunshotInProgress')
-- AddEventHandler('esx_outlawalert:gunshotInProgress', function(targetCoords, adres, playerGender)
-- 	if playerGender == 0 then
-- 		playerGender = _U('male')
-- 	else
-- 		playerGender = _U('female')
-- 	end

-- 	TriggerClientEvent('esx_outlawalert:outlawNotify', -1, 'Ateş bildirimi', playerGender, adres)
-- 	TriggerClientEvent('esx_outlawalert:gunshotInProgress', -1, targetCoords)
-- end)


RegisterServerEvent('esx_outlawalert:gunshotInProgress')
AddEventHandler('esx_outlawalert:gunshotInProgress', function(targetCoords, adres, playerGender)
	if playerGender == 0 then
		playerGender = 'Erkek'
	else
		playerGender = 'Kadın'
	end
	mytype = 'police'
    data = {["code"] = '10-22', ["name"] = 'Silah sesleri duyuldu', ["loc"] = adres, ["sex"] = playerGender}
    length = 5500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:gunshotInProgress', -1, targetCoords)
end, false)

RegisterServerEvent('esx_outlawalert:vezneRobberyinProgress')
AddEventHandler('esx_outlawalert:vezneRobberyinProgress', function(targetCoords, adres, playerGender)
	if playerGender == 0 then
		playerGender = 'Erkek'
	else
		playerGender = 'Kadın'
	end
	mytype = 'error'
    data = {["code"] = '10-22', ["name"] = 'Banka veznesi soyuluyor', ["loc"] = adres, ["sex"] = playerGender}
    length = 5500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:gunshotInProgress', -1, targetCoords)
end, false)

RegisterServerEvent('esx_outlawalert:blaineRobberyinProgress')
AddEventHandler('esx_outlawalert:blaineRobberyinProgress', function(targetCoords, adres, playerGender)
	if playerGender == 0 then
		playerGender = 'Erkek'
	else
		playerGender = 'Kadın'
	end
	mytype = 'error'
    data = {["code"] = '10-22', ["name"] = 'Blaine County Saving Bank soyuluyor', ["loc"] = adres, ["sex"] = playerGender}
    length = 5500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:gunshotInProgress', -1, targetCoords)
end, false)

RegisterServerEvent('esx_outlawalert:vangelicorobberyinProgress')
AddEventHandler('esx_outlawalert:vangelicorobberyinProgress', function(targetCoords, adres, playerGender)
	if playerGender == 0 then
		playerGender = 'Erkek'
	else
		playerGender = 'Kadın'
	end
	mytype = 'error'
    data = {["code"] = '10-22', ["name"] = 'Kuyumcu soyuluyor', ["loc"] = adres, ["sex"] = playerGender}
    length = 5500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:gunshotInProgress', -1, targetCoords)
end, false)

RegisterServerEvent('esx_outlawalert:banktruckrobberyinProgress')
AddEventHandler('esx_outlawalert:banktruckrobberyinProgress', function(targetCoords, adres, playerGender)
	if playerGender == 0 then
		playerGender = 'Erkek'
	else
		playerGender = 'Kadın'
	end
	mytype = 'error'
    data = {["code"] = '10-22', ["name"] = 'Banka aracı soyuluyor', ["loc"] = adres, ["sex"] = playerGender}
    length = 5500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:gunshotInProgress', -1, targetCoords)
end, false)

RegisterServerEvent('esx_outlawalert:houserobberyinProgress')
AddEventHandler('esx_outlawalert:houserobberyinProgress', function(targetCoords, adres, playerGender)
	if playerGender == 0 then
		playerGender = 'Erkek'
	else
		playerGender = 'Kadın'
	end
	mytype = 'error'
    data = {["code"] = '10-22', ["name"] = 'Ev soyuluyor', ["loc"] = adres, ["sex"] = playerGender}
    length = 5500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:gunshotInProgress', -1, targetCoords)
end, false)

RegisterServerEvent('esx_outlawalert:shoprobberyinProgress')
AddEventHandler('esx_outlawalert:shoprobberyinProgress', function(targetCoords, adres, playerGender)
	if playerGender == 0 then
		playerGender = 'Erkek'
	else
		playerGender = 'Kadın'
	end
	mytype = 'error'
    data = {["code"] = '10-22', ["name"] = 'Market soyuluyor', ["loc"] = adres, ["sex"] = playerGender}
    length = 5500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:gunshotInProgress', -1, targetCoords)
end, false)

RegisterServerEvent('esx_outlawalert:atmrobberyinProgress')
AddEventHandler('esx_outlawalert:atmrobberyinProgress', function(targetCoords, adres, playerGender)
	if playerGender == 0 then
		playerGender = 'Erkek'
	else
		playerGender = 'Kadın'
	end
	mytype = 'error'
    data = {["code"] = '10-22', ["name"] = 'Atm soyuluyor', ["loc"] = adres, ["sex"] = playerGender}
    length = 5500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:gunshotInProgress', -1, targetCoords)
end, false)

RegisterServerEvent('esx_outlawalert:gunshotInVehicleProgress')
AddEventHandler('esx_outlawalert:gunshotInVehicleProgress', function(targetCoords, adres, playerGender, model, plate, colorinfo, dir)
	if playerGender == 0 then
		playerGender = 'Erkek'
	else
		playerGender = 'Kadın'
	end
	mytype = 'police'
    data = {["code"] = '20-01', ["name"] = 'DriveBy', ["loc"] = adres, ["sex"] = playerGender, ["model"] = model, ["plate"] = plate, ["color"] = colorinfo, ["heading"] = dir }
    length = 5500
    TriggerClientEvent('esx_outlawalert:outlawNotifyDetailedrecklessdriver', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:gunshotInVehicleProgress', -1, targetCoords)
end, false)


--[[
RegisterServerEvent('esx_outlawalert:carcrashS')  -- ÇALIŞMIYOR
AddEventHandler('esx_outlawalert:carcrashS', function(targetCoords,  adres, playerGender, colorinfo, plate, model, dir)
	if playerGender == 0 then
		playerGender = 'Erkek'
	else
		playerGender = 'Kadın'
	end
	mytype = 'police'
    data = {["code"] = '10-01', ["name"] = 'Araç kazası', ["loc"] = adres, ["sex"] = playerGender, ["color"] = colorinfo, ["plate"] = plate , ["model"] = model ..'', ["heading"] = dir}
    length = 3500
    TriggerClientEvent('esx_outlawalert:outlawNotifyDetailed', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:carcrashS', -1, targetCoords)
end, false)

RegisterServerEvent('esx_outlawalert:recklessdriverS')
AddEventHandler('esx_outlawalert:recklessdriverS', function(targetCoords,  adres, playerGender, colorinfo, plate, model, dir)
	if playerGender == 0 then
		playerGender = 'Erkek'
	else
		playerGender = 'Kadın'
	end
	mytype = 'police'
    data = {["code"] = '4061', ["name"] = 'Yüksek Hız', ["loc"] = adres, ["sex"] = playerGender, ["color"] = colorinfo, ["plate"] = plate , ["model"] = model ..'', ["heading"] = dir}
    length = 10000
    TriggerClientEvent('esx_outlawalert:outlawNotifyDetailedrecklessdriver', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:recklessdriverS', -1, targetCoords)
end, false)
--]]

-- RegisterServerEvent('esx_outlawalert:hotwireAlert')
-- AddEventHandler('esx_outlawalert:hotwireAlert', function(targetCoords,  adres, playerGender, colorinfo, plate, model, dir)
-- 	if playerGender == 0 then
-- 		playerGender = 'Erkek'
-- 	else
-- 		playerGender = 'Kadın'
-- 	end
-- 	mytype = 'police'
--     data = {["code"] = '10-61', ["name"] = 'Yüksek Hız', ["loc"] = adres, ["sex"] = playerGender, ["color"] = colorinfo, ["plate"] = plate , ["model"] = model ..'', ["heading"] = dir}
--     length = 3500
--     TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
--     TriggerClientEvent('esx_outlawalert:hotwireAlertS', -1, targetCoords)
-- end, false)




----------------------------
--
---						311 - 991
--
-------------------------------



RegisterServerEvent('esx_outlawalert:policecode')
AddEventHandler('esx_outlawalert:policecode', function(targetCoords, adres, playerGender)
	
	if playerGender == 0 then
		playerGender = 'Erkek'
	else
		playerGender = 'Kadın'
	end
	mytype = 'police'
    data = {["code"] = '911-331', ["name"] = 'Yaralı Memur', ["loc"] = adres, ["sex"] = playerGender}
    length = 5500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:policecode', -1, targetCoords)
end, false)


RegisterServerEvent('esx_outlawalert:policecodea')
AddEventHandler('esx_outlawalert:policecodea', function(targetCoords, adres, playerGender, playerName)	
	if playerGender == 0 then
		playerGender = 'Erkek'
	else
		playerGender = 'Kadın'
	end
	mytype = 'police'
    data = {["code"] = '911-331', ["name"] = 'Destek çağrısı', ["loc"] = adres, ["sex"] = playerGender}
    length = 5500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:policecodea', -1, targetCoords)
end, false)




RegisterServerEvent('esx_outlawalert:emsalerts')
AddEventHandler('esx_outlawalert:emsalerts', function(targetCoords, adres, playerGender)
	if playerGender == 0 then
		playerGender = 'Erkek'
	else
		playerGender = 'Kadın'
	end
	mytype = 'ambulance'
    data = {["code"] = '54-21', ["name"] = 'Yaralı ihbarı', ["loc"] = adres, ["sex"] = playerGender}
    length = 5500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:emsNeeded', -1, targetCoords)
end, false)


ESX.RegisterServerCallback('esx_outlawalert:isVehicleOwner', function(source, cb, plate)
	local identifier = GetPlayerIdentifier(source, 0)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == identifier)
		else
			cb(false)
		end
	end)
end)
