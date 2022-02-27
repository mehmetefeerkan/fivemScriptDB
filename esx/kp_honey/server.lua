ESX = nil
local playersProcessing = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('kp_honey:process')
AddEventHandler('kp_honey:process', function()
	if not playersProcessing[source] then
		local _source = source

		playersProcessing[_source] = ESX.SetTimeout(2500, function()
			
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xMin = xPlayer.getInventoryItem('honey_a').count
			if xMin >= 2 then
				xPlayer.removeInventoryItem('honey_a', 2)
				xPlayer.addInventoryItem('honey_b', 1)
			else 
				xPlayer.showNotification('Envanterinde balın kalmadı')
			end
			playersProcessing[_source] = nil
		end)
	end
end)

function CancelProcessing(playerID)
	if playersProcessing[playerID] then
		ESX.ClearTimeout(playersProcessing[playerID])
		playersProcessing[playerID] = nil
	end
end

RegisterServerEvent('kp_honey:cancelProcessing')
AddEventHandler('kp_honey:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)
