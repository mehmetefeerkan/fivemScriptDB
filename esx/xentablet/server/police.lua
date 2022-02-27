-- Car

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

  
 function PoliceGetPlate(plate, cb)
  MySQL.Async.fetchAll("SELECT owned_vehicles.*, users.job, users.firstname, users.lastname, users.dateofbirth, users.phone_number FROM owned_vehicles LEFT JOIN users ON owned_vehicles.owner = users.identifier WHERE plate = @plate", {
    ['@plate'] = plate
  }, cb)
end


RegisterServerEvent('xentablet:police_getPlate')
AddEventHandler('xentablet:police_getPlate', function(plate)
local _source = source
local sourceXPlayer = ESX.GetPlayerFromId(_source)

if sourceXPlayer.job.name ~= 'police' then
		print(('xentablet: %s Polis Olmayan Biri Polis App Kullanmaya Calisti'):format(sourceXPlayer.identifier))
	return
end

  local sourcePlayer = tonumber(source)
    PoliceGetPlate(plate, function (pplates)
      TriggerClientEvent('xentablet:police_getPlate', sourcePlayer, plate, pplates)
    end)
end)

 function PoliceGetPlayVehicle(owner, cb)
  MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner", {
    ['@owner'] = owner
  }, cb)
end


RegisterServerEvent('xentablet:police_getPlayerOwner')
AddEventHandler('xentablet:police_getPlayerOwner', function(owner)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)

	if sourceXPlayer.job.name ~= 'police' then
		print(('xentablet: %s Polis Olmayan Biri Polis App Kullanmaya Calisti'):format(sourceXPlayer.identifier))
		return
    end
  local sourcePlayer = tonumber(source)
    PoliceGetPlayVehicle(owner, function (pplayerowner)
      TriggerClientEvent('xentablet:police_getPlayerOwner', sourcePlayer, owner, pplayerowner)
    end)
end)

function PolicePostNote(plate, note, cb)
  MySQL.Async.insert('INSERT IGNORE INTO police_log (`plate`, `note`) VALUES(@plate, @note)', {
    ['plate'] = plate,
	['note'] = note
  }, cb)
end

RegisterServerEvent('xentablet:police_postLogss')
AddEventHandler('xentablet:police_postLogss', function(plate, note)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)

	if sourceXPlayer.job.name ~= 'police' then
		print(('xentablet: %s Polis Olmayan Biri Polis App Kullanmaya Calisti'):format(sourceXPlayer.identifier))
		return
	end
  PolicePostNote(plate, note)
end)



function PoliceGetNotePlate (plate, cb)
    MySQL.Async.fetchAll("SELECT * FROM police_log WHERE plate = @plate ORDER BY time DESC LIMIT 100", { 
        ['@plate'] = plate
    }, cb)
end

function PoliceAddNote (plate, note)
  local Query = "INSERT INTO police_log (`plate`, `note`) VALUES(@plate, @note);"
  local Query2 = 'SELECT * from police_log WHERE `id` = @id;'
  local Parameters = {
    ['@plate'] = plate,
    ['@note'] = note
  }
  MySQL.Async.insert(Query, Parameters, function (id)
    MySQL.Async.fetchAll(Query2, { ['@id'] = id }, function (reponse)
      TriggerClientEvent('xentablet:police_receive', -1, reponse[1])
    end)
  end)
end


RegisterServerEvent('xentablet:police_plate')
AddEventHandler('xentablet:police_plate', function(plate)
  local sourcePlayer = tonumber(source)
  PoliceGetNotePlate(plate, function (notes)
    TriggerClientEvent('xentablet:police_plate', sourcePlayer, plate, notes)
  end)
end)

RegisterServerEvent('xentablet:police_addNote')
AddEventHandler('xentablet:police_addNote', function(plate, note)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)

	if sourceXPlayer.job.name ~= 'police' then
		print(('xentablet: %s Polis Olmayan Biri Polis App Kullanmaya Calisti'):format(sourceXPlayer.identifier))
		return
	end

  PoliceAddNote(plate, note)
  
end)


function deleteMessage(id)
    MySQL.Sync.execute("DELETE FROM police_log WHERE `id` = @id", {
        ['@id'] = id
    })
end

RegisterServerEvent('xentablet:deleteMessage')
AddEventHandler('xentablet:deleteMessage', function(id)
    deleteMessage(id)
end)

-- Player

 function PoliceGetPlayer(phone_number, cb)
  MySQL.Async.fetchAll("SELECT * FROM users WHERE phone_number = @phone_number", {
    ['@phone_number'] = phone_number
  }, cb)

end

 function PoliceGetIdentyPlayer(lastdigits, cb)
  MySQL.Async.fetchAll("SELECT * FROM users WHERE lastdigits = @lastdigits", {
    ['@lastdigits'] = lastdigits
  }, cb)

end


function PoliceGetPlayerBilling (accountId, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll([===[
      SELECT users.*,
      billing.label,
      billing.amount
      FROM users
      LEFT JOIN billing ON users.identifier = billing.identifier
      ]===], {}, cb)
  end 


RegisterServerEvent('xentablet:police_getPlayer')
AddEventHandler('xentablet:police_getPlayer', function(phone_number)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)

	if sourceXPlayer.job.name ~= 'police' then
		print(('xentablet: %s Polis Olmayan Biri Polis App Kullanmaya Calisti'):format(sourceXPlayer.identifier))
		return
	end
  local sourcePlayer = tonumber(source)
    PoliceGetPlayer(phone_number, function (pfirstnames)
      TriggerClientEvent('xentablet:police_getPlayer', sourcePlayer, phone_number, pfirstnames)
    end)
end)

RegisterServerEvent('xentablet:police_getIdentyPlayer')
AddEventHandler('xentablet:police_getIdentyPlayer', function(lastdigits)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)

	if sourceXPlayer.job.name ~= 'police' then
		print(('xentablet: %s Polis Olmayan Biri Polis App Kullanmaya Calisti'):format(sourceXPlayer.identifier))
		return
	end
  local sourcePlayer = tonumber(source)
    PoliceGetIdentyPlayer(lastdigits, function (pplayeri)
      TriggerClientEvent('xentablet:police_getIdentyPlayer', sourcePlayer, lastdigits, pplayeri)
    end)
end)

RegisterServerEvent('xentablet:police_getPlayerBilling')
AddEventHandler('xentablet:police_getPlayerBilling', function(phone_number, firstname)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)

	if sourceXPlayer.job.name ~= 'police' then
		print(('xentablet: %s Polis Olmayan Biri Polis App Kullanmaya Calisti'):format(sourceXPlayer.identifier))
		return
	end
  local sourcePlayer = tonumber(source)
    PoliceGetPlayerBilling(nil, function (pplayerbil)
      TriggerClientEvent('xentablet:police_getPlayerBilling', sourcePlayer, pplayerbil)
    end)
end)

function PolicePostPNote(firstname, neto, cb)
  MySQL.Async.insert('INSERT IGNORE INTO police_playerlog (`firstname`, `neto`) VALUES(@firstname, @neto)', {
    ['firstname'] = firstname,
	['neto'] = neto
  }, cb)
end

RegisterServerEvent('xentablet:police_postPLogss')
AddEventHandler('xentablet:police_postPLogss', function(firstname, neto)
  PolicePostPNote(firstname, neto)
end)



function PoliceGetNotePlayer (firstname, cb)
    MySQL.Async.fetchAll("SELECT * FROM police_playerlog WHERE firstname = @firstname ORDER BY time DESC LIMIT 100", { 
        ['@firstname'] = firstname
    }, cb)
end

function PoliceAddPlayerNote (firstname, neto)
  local Query = "INSERT INTO police_playerlog (`firstname`, `neto`) VALUES(@firstname, @neto);"
  local Query2 = 'SELECT * from police_playerlog WHERE `id` = @id;'
  local Parameters = {
    ['@firstname'] = firstname,
    ['@neto'] = neto
  }
  MySQL.Async.insert(Query, Parameters, function (id)
    MySQL.Async.fetchAll(Query2, { ['@id'] = id }, function (reponse)
      TriggerClientEvent('xentablet:police_preceive', -1, reponse[1])
    end)
  end)
end


RegisterServerEvent('xentablet:police_player')
AddEventHandler('xentablet:police_player', function(firstname)
  local sourcePlayer = tonumber(source)
  PoliceGetNotePlayer(firstname, function (netos)
    TriggerClientEvent('xentablet:police_player', sourcePlayer, firstname, netos)
  end)
end)

RegisterServerEvent('xentablet:police_addPlayerNote')
AddEventHandler('xentablet:police_addPlayerNote', function(firstname, neto)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)

	if sourceXPlayer.job.name ~= 'police' then
		print(('xentablet: %s Polis Olmayan Biri Polis App Kullanmaya Calisti'):format(sourceXPlayer.identifier))
		return
	end

  PoliceAddPlayerNote(firstname, neto)
end)


function deletePlayerNote(id)
    MySQL.Sync.execute("DELETE FROM police_playerlog WHERE `id` = @id", {
        ['@id'] = id
    })
end

RegisterServerEvent('xentablet:deletePlayerNote')
AddEventHandler('xentablet:deletePlayerNote', function(id)
    deletePlayerNote(id)
end)










--====================================================================================
-- #XenKnighT
--====================================================================================


function getPolice(username, password, cb)
  MySQL.Async.fetchAll("SELECT id, username as author, avatar_url as authorIcon FROM police_accounts WHERE police_accounts.username = @username AND police_accounts.password = @password", {
    ['@username'] = username,
    ['@password'] = password
  }, function (data)
    cb(data[1])
  end)
end


function PoliceCreateAccount(username, password, avatarUrl, cb)
  MySQL.Async.insert('INSERT IGNORE INTO police_accounts (`username`, `password`, `avatar_url`) VALUES(@username, @password, @avatarUrl)', {
    ['username'] = username,
    ['password'] = password,
    ['avatarUrl'] = avatarUrl
  }, cb)
end
-- ALTER TABLE `police_accounts`	CHANGE COLUMN `username` `username` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8_general_ci';


RegisterServerEvent('xentablet:police_login')
AddEventHandler('xentablet:police_login', function(username, password)
  local sourcePlayer = tonumber(source)
  getPolice(username, password, function (user)
    if user == nil then
    else
      TriggerClientEvent('xentablet:police_setAccount', sourcePlayer, username, password, user.authorIcon)
    end
  end)
end)


RegisterServerEvent('xentablet:police_createAccount')
AddEventHandler('xentablet:police_createAccount', function(username, password, avatarUrl)
  local sourcePlayer = tonumber(source)
  PoliceCreateAccount(username, password, avatarUrl, function (id)
    if (id ~= 0) then
      TriggerClientEvent('xentablet:police_setAccount', sourcePlayer, username, password, avatarUrl)
    else
    end
  end)
end)


RegisterServerEvent('xentablet:police_setAvatarUrl')
AddEventHandler('xentablet:police_setAvatarUrl', function(username, password, avatarUrl)
print(username, password, avatarUrl)
  local sourcePlayer = tonumber(source)
  MySQL.Async.execute("UPDATE `police_accounts` SET `avatar_url`= @avatarUrl WHERE police_accounts.username = @username AND police_accounts.password = @password", {
    ['@username'] = username,
    ['@password'] = password,
    ['@avatarUrl'] = avatarUrl
  }, function (result)
    if (result == 1) then
      TriggerClientEvent('xentablet:police_setAccount', sourcePlayer, username, password, avatarUrl)
    else
    end
  end)
end)





function PoliceUserAvatar(identifier, avatarp, cb)
  MySQL.Async.execute("UPDATE `users` SET `avatarp`= @avatarp WHERE users.identifier = @identifier", {
    ['@identifier'] = identifier,
    ['@avatarp'] = avatarp
  }, cb)
end

RegisterServerEvent('xentablet:users_avatarUrl')
AddEventHandler('xentablet:users_avatarUrl', function(identifier, avatarp)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)

	if sourceXPlayer.job.name ~= 'police' then
		print(('xentablet: %s Polis Olmayan Biri Polis App Kullanmaya Calisti'):format(sourceXPlayer.identifier))
		return
end
print(identifier, avatarp)
  PoliceUserAvatar(identifier, avatarp)
end)




