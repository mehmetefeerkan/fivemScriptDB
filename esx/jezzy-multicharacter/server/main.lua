ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('pant-multicharacter:server:disconnect')
AddEventHandler('pant-multicharacter:server:disconnect', function()
    local src = source

    DropPlayer(src, "Panthera Roleplay\'den ayrıldın ve Jezzyi götünden siktin")
end)

RegisterServerEvent('pant-multicharacter:server:loadUserData')
AddEventHandler('pant-multicharacter:server:loadUserData', function(cData)
    local src = source
    local pos = GetSpawnPos(src, identifier)
    local identifier = tonumber(cData.identifier)
    SetLastCharacter(src, identifier)
    SetCharToIdentifier(GetPlayerIdentifiers(src)[1], identifier)
    TriggerClientEvent("esx:kashloaded",src)
    TriggerEvent("esx:onPlayerJoined")
    TriggerClientEvent('apartments:client:setupSpawnUI', src, false, pos,cData)
end)

RegisterServerEvent('pant-multicharacter:server:createCharacter')
AddEventHandler('pant-multicharacter:server:createCharacter', function(data)
    local src = source
    local newData = {}
    newData.identifier = data.identifier
    newData = data
    local spawn = {}
    local identifier = tonumber(data.identifier)
    local identifiertest = GetPlayerIdentifiers(src)[1]
    local steamhex = GetPlayerIdentifiers(src)[1]
    SetLastCharacter(src, identifier)
    SetCharToIdentifier(identifiertest, identifier)
    spawn = { x = 195.55, y = -933.36, z = 29.90 } 
    TriggerClientEvent("esx:kashloaded",src)
    TriggerEvent("esx:onPlayerJoined")
    Citizen.Wait(7500)
    exports['ghmattimysql']:execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height, `identifier` = @identifier WHERE identifier = @identifier', {
        ['@identifier']		= identifiertest,
        ['@firstname']		= data.firstname,
        ['@lastname']		= data.lastname,
        ['@dateofbirth']	= data.birthdate,
        ['@sex']			= data.gender,
        ['@height']			= 150,
        ['@identifier']			= identifier
    })
    print('^2[pant-core]^7 '..GetPlayerName(src)..' has succesfully loaded and jezzy fucked his fucking ass man!')
    TriggerClientEvent("pant-multicharacter:client:closeNUI", src)
    TriggerClientEvent('apartments:client:setupSpawnUI', src, newData)
end)


RegisterServerEvent('pant-multicharacter:server:deleteCharacter')
AddEventHandler('pant-multicharacter:server:deleteCharacter', function(identifier)
    local src = source
    DeleteCharacter(GetPlayerIdentifiers(src)[1], identifier)
end)


ESX.RegisterServerCallback("pant-multicharacter:server:GetUserCharacters", function(source, cb)
    local steamId = GetPlayerIdentifier(source, 0)
    exports['ghmattimysql']:execute('SELECT * FROM users WHERE steam = @steam', {['@steam'] = steamId}, function(result)
        cb(result)
    end)
end)


ESX.RegisterServerCallback("test:yeet", function(source, cb)
    local steamId = GetPlayerIdentifiers(source)[1]
    local plyChars = {}
    
    exports['ghmattimysql']:execute('SELECT * FROM users WHERE steam = @steam', {['@steam'] = steamId}, function(result)
        for i = 1, (#result), 1 do
            result[i].charinfo = json.decode(result[i].charinfo)
            result[i].money = json.decode(result[i].money)
            result[i].job = json.decode(result[i].job)

            table.insert(plyChars, result[i])
        end
        cb(plyChars)
    end)
end)


ESX.RegisterServerCallback("pant-multicharacter:server:getSkin", function(source, cb, identifier)
    local src = source

    ESX.ExecuteSql(false, "SELECT * FROM `playerskins` WHERE `identifier` = '"..identifier.."' AND `active` = 1", function(result)
        if result[1] ~= nil then
            cb(result[1].model, result[1].skin)
        else
            cb(nil)
        end
    end)
end)

function loadHouseData()
    local HouseGarages = {}
    local Houses = {}
	ESX.ExecuteSql(false, "SELECT * FROM `houselocations`", function(result)
		if result[1] ~= nil then
			for k, v in pairs(result) do
				local owned = false
				if tonumber(v.owned) == 1 then
					owned = true
				end
				local garage = v.garage ~= nil and json.decode(v.garage) or {}
				Houses[v.name] = {
					coords = json.decode(v.coords),
					owned = v.owned,
					price = v.price,
					locked = true,
					adress = v.label, 
					tier = v.tier,
					garage = garage,
					decorations = {},
				}
				HouseGarages[v.name] = {
					label = v.label,
					takeVehicle = garage,
				}
			end
		end
		TriggerClientEvent("pant-garages:client:houseGarageConfig", -1, HouseGarages)
		TriggerClientEvent("pant-houses:client:setHouseConfig", -1, Houses)
	end)
end