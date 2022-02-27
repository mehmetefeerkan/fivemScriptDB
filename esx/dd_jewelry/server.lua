--------------[[JEWEL]]-----------------
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('jewel:StartLooting')
AddEventHandler('jewel:StartLooting', function()
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local rdm = math.random(1,3)
	xPlayer.addInventoryItem('jewels', rdm)
end)
RegisterServerEvent('jewel:endoHeist')
AddEventHandler('jewel:endoHeist', function()
	local _source = source
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('okokNotify:Alert', xPlayers[i], "", "Jewel robbery has been completed!", 5000, 'warning')
		end
	end
	TriggerClientEvent('okokNotify:Alert', _source, "", "Jewel robbery has been completed!", 5000, 'warning')
end)