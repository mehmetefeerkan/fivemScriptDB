--====================================================================================
-- #XenKnighT
--====================================================================================
RegisterNetEvent("xentablet:police_getPlate")
AddEventHandler("xentablet:police_getPlate", function(plate, pplates)
  SendNUIMessage({event = 'police_Platee', plate = plate, pplates = pplates})
end)

RegisterNUICallback('police_getPlate', function(data, cb)
  TriggerServerEvent('xentablet:police_getPlate', data.plate, data.firstname, data.lastname, data.dateofbirth, data.job, data.phone_number, data.message)
end)

RegisterNetEvent("xentablet:police_getPlayerOwner")
AddEventHandler("xentablet:police_getPlayerOwner", function(owner, pplayerowner)
  SendNUIMessage({event = 'police_Ownerr', owner = owner, pplayerowner = pplayerowner})
end)

RegisterNUICallback('police_getPlayerOwner', function(data, cb)
  TriggerServerEvent('xentablet:police_getPlayerOwner', data.owner, data.plate)
end)

RegisterNUICallback('police_postLogs', function(data, cb)
  TriggerServerEvent('xentablet:police_postLogss', data.plate or '', data.note)
end)

RegisterNetEvent("xentablet:police_receive")
AddEventHandler("xentablet:police_receive", function(note)
  SendNUIMessage({event = 'police_receive', note = note})
end)

RegisterNetEvent("xentablet:police_plate")
AddEventHandler("xentablet:police_plate", function(plate, notes)
  SendNUIMessage({event = 'police_plate', notes = notes})
end)

RegisterNUICallback('police_addNote', function(data, cb)
  TriggerServerEvent('xentablet:police_addNote', data.plate or '', data.note)
end)

RegisterNUICallback('police_gettPlate', function(data, cb)
  TriggerServerEvent('xentablet:police_plate', data.plate)
end)


RegisterNUICallback('police_receive', function(data, cb)
  TriggerServerEvent('xentablet:police_receive', data.plate, data.note)
end)


RegisterNUICallback('deleteMessage', function(data)
  TriggerServerEvent('xentablet:deleteMessage', data.id)
end)


--====================================================================================
-- #XenKnighT:Player
--====================================================================================

RegisterNetEvent("xentablet:police_getPlayer")
AddEventHandler("xentablet:police_getPlayer", function(phone_number, pfirstnames)
  SendNUIMessage({event = 'police_Playerr', phone_number = phone_number, pfirstnames = pfirstnames})
end)

RegisterNUICallback('police_getPlayer', function(data, cb)
  TriggerServerEvent('xentablet:police_getPlayer', data.firstname, data.lastname, data.dateofbirth, data.job, data.phone_number)
end)

RegisterNetEvent("xentablet:police_getIdentyPlayer")
AddEventHandler("xentablet:police_getIdentyPlayer", function(lastdigits, pplayeri)
  SendNUIMessage({event = 'police_IdentyPlayerr', lastdigits = lastdigits, pplayeri = pplayeri})
end)

RegisterNUICallback('police_getIdentyPlayer', function(data, cb)
  TriggerServerEvent('xentablet:police_getIdentyPlayer', data.firstname, data.lastname, data.dateofbirth, data.job, data.phone_number, data.lastdigits)
end)

RegisterNetEvent("xentablet:police_getPlayerBilling")
AddEventHandler("xentablet:police_getPlayerBilling", function(pplayerbil)
  SendNUIMessage({event = 'police_PlayerBilling', pplayerbil = pplayerbil})
end)

RegisterNUICallback('police_getPlayerBilling', function(data, cb)
  TriggerServerEvent('xentablet:police_getPlayerBilling', data.firstname, data.label, data.amount)
end)

RegisterNUICallback('police_postPLogs', function(data, cb)
  TriggerServerEvent('xentablet:police_postPLogss', data.firstname or '', data.neto)
end)

RegisterNetEvent("xentablet:police_preceive")
AddEventHandler("xentablet:police_preceive", function(neto)
  SendNUIMessage({event = 'police_preceive', neto = neto})
end)

RegisterNetEvent("xentablet:police_player")
AddEventHandler("xentablet:police_player", function(firstname, netos)
  SendNUIMessage({event = 'police_player', netos = netos})
end)

RegisterNUICallback('police_addPlayerNote', function(data, cb)
  TriggerServerEvent('xentablet:police_addPlayerNote', data.firstname, data.neto)
end)

RegisterNUICallback('police_gettPlayer', function(data, cb)
  TriggerServerEvent('xentablet:police_player', data.firstname)
end)


RegisterNUICallback('police_preceive', function(data, cb)
  TriggerServerEvent('xentablet:police_preceive', data.firstname, data.neto)
end)


RegisterNUICallback('deletePlayerNote', function(data)
  TriggerServerEvent('xentablet:deletePlayerNote', data.id)
end)


--====================================================================================
-- #XenKnighT
--====================================================================================


RegisterNetEvent("xentablet:police_setAccount")
AddEventHandler("xentablet:police_setAccount", function(username, password, avatarUrl)
  SendNUIMessage({event = 'police_setAccount', username = username, password = password, avatarUrl = avatarUrl})
end)

RegisterNetEvent("xentablet:police_createAccount")
AddEventHandler("xentablet:police_createAccount", function(account)
  SendNUIMessage({event = 'police_createAccount', account = account})
end)




RegisterNUICallback('police_login', function(data, cb)
  TriggerServerEvent('xentablet:police_login', data.username, data.password)
end)


RegisterNUICallback('police_createAccount', function(data, cb)
  TriggerServerEvent('xentablet:police_createAccount', data.username, data.password, data.avatarUrl)
end)


RegisterNUICallback('police_setAvatarUrl', function(data, cb)
  TriggerServerEvent('xentablet:police_setAvatarUrl', data.username or '', data.password or '', data.avatarUrl)
end)




RegisterNUICallback('users_avatarsUrls', function(data, cb)
  TriggerServerEvent('xentablet:users_avatarUrl', data.identifier or '', data.avatarp)
end)