
ESX                       = nil
local PhoneNumbers        = {}
local beingHacked = false
local beingCopied = false
local beingTransfered = false

TriggerEvent('esx:getSharedObject', function(obj)
  ESX = obj
end)

----------------------------------------------------
local connect = false

ESX.RegisterServerCallback('dd_cyberheist:CanConnect', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and connect then
	    cb(true)
    else
      TriggerClientEvent('okokNotify:Alert', source, "NETWORK", "Connection Error", 3000, 'error')
  	  cb(false)
    end
end)

RegisterServerEvent("dd_cyberheist:StartConnect")
AddEventHandler("dd_cyberheist:StartConnect", function()
    connect = true
end)

RegisterServerEvent("dd_cyberheist:StartdisConnect")
AddEventHandler("dd_cyberheist:StartdisConnect", function()
    connect = false
end)
RegisterServerEvent("dd_cyberheist:StartHack")
AddEventHandler("dd_cyberheist:StartHack", function()
  local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' then
			TriggerClientEvent('dd_cyberheist:setBlip', xPlayers[i])
		end
	end
	-- TriggerEvent("dd_news:StartTimer")
	TriggerEvent("dd_news:PostNews", 'Cyber Heist')

  local resumeConnection = DD.TimeToResume
    beingHacked = true
    TriggerClientEvent('dd_cyberheist:hacked', -1)
    TriggerClientEvent('okokNotify:Alert', -1, "NETWORK", "Telecommunication was hacked!!!", 10000, 'warning')
    SetTimeout((resumeConnection*60000), function()
    TriggerClientEvent('okokNotify:Alert', -1, "NETWORK", "Network resumes", 10000, 'warning')
    beingHacked = false
    for i=1, #xPlayers, 1 do
      local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
      if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' then
        TriggerClientEvent('dd_cyberheist:killBlip', xPlayers[i])
      end
    end
    TriggerClientEvent('dd_cyberheist:unhacked', -1)
    end)
end)

RegisterServerEvent("dd_cyberheist:StartTransferring")
AddEventHandler("dd_cyberheist:StartTransferring", function(rdm)
  local src = source
  local xPlayer = ESX.GetPlayerFromId(src)
  local xPlayers = ESX.GetPlayers()
  local hacker = xPlayer.getName()
	for i=1, #xPlayers, 1 do
		local xBanker = ESX.GetPlayerFromId(xPlayers[i])
    local bankOwner = xBanker.getName()
    local bankMoney = xBanker.getAccount('bank').money
    if rdm > bankMoney then
      rdm = bankMoney
      xBanker.removeAccountMoney('bank', 1000)
      xPlayer.addAccountMoney('black_money', rdm)
      TriggerClientEvent('okokNotify:Alert', src, "", 'You successfuly transfer '..rdm, 10000, 'warning')
      TriggerClientEvent('okokNotify:Alert', xPlayers[i], "", hacker..' successfuly transfer '..rdm..' from bank account', 10000, 'warning')
    else
      xBanker.removeAccountMoney('bank', 1000)
      xPlayer.addAccountMoney('black_money', rdm)
      TriggerClientEvent('okokNotify:Alert', src, "", 'You successfuly transfer '..rdm..' from '..bankOwner, 10000, 'warning')
      TriggerClientEvent('okokNotify:Alert', xPlayers[i], "", hacker..' successfuly transfer '..rdm..' from bank account', 10000, 'warning')
    end
	end
  
    local resumeConnection = DD.TimeToResume
    beingTransfered = true
    TriggerClientEvent('dd_cyberheist:transfered', -1)
    SetTimeout((resumeConnection*600000), function()
    beingTransfered = false
    TriggerClientEvent('dd_cyberheist:nottransfered', -1)
    end)
end)

ESX.RegisterServerCallback('dd_cyberheist:beingHack', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  if not beingHacked then
    cb(true)
  else
    TriggerClientEvent('okokNotify:Alert', -1, "NETWORK", "Telecommunication was hacked!!!", 10000, 'warning')
    cb(false)
  end
end)
