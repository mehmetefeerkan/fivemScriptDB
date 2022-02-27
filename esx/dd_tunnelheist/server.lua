
local rob = false
local robbers = {}
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('dd_tunnelheist:rob')
AddEventHandler('dd_tunnelheist:rob', function()

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	if xPlayer.getInventoryItem('blowtorch').count >= 1 then
		local savedSource = source
		local span = Config.robbingVault
		xPlayer.removeInventoryItem('blowtorch', 1)
		TriggerClientEvent('dd_tunnelheist:currentlyrobbing', source)
		TriggerClientEvent('dd_tunnelheist:startblowtorch', source)
		
		SetTimeout(span*1000, function()
			
			if Config.moneyType == 'cash' then
				xPlayer.addMoney(Config.Reward)
			elseif Config.moneyType == 'black' then
				xPlayer.addAccountMoney('black_money', Config.Reward)
			end
			TriggerClientEvent('dd_tunnelheist:robberycomplete', savedSource, Config.Reward)
			local xPlayers = ESX.GetPlayers()
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' then
					TriggerClientEvent('okokNotify:Alert', xPlayers[i], "", "Robbery completed at Tunnel Vault", 5000, 'warning')
					TriggerClientEvent('dd_tunnelheist:killblip', xPlayers[i])
				end
			end
		end)
	else
		TriggerClientEvent('okokNotify:Alert', source, "", "You need a blowtorch", 5000, 'warning')
	end
end)

RegisterServerEvent('dd_tunnelheist:hack')
AddEventHandler('dd_tunnelheist:hack', function()

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
		local cops = 0
		for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
				cops = cops + 1
			end
		end
		if(cops >= Config.NumberOfCopsRequired)then
			if xPlayer.getInventoryItem('raspberry').count >= 1 then
				xPlayer.removeInventoryItem('raspberry', 1)
				local xitem='xekit'
				TriggerEvent('inv_inUse:xItem', source,xitem)
				TriggerClientEvent('dd_tunnelheist:currentlyhacking', source)
			else
				TriggerClientEvent('okokNotify:Alert', source, "", "You need a raspberry to hack the gate", 5000, 'warning')
			end
		else
			TriggerClientEvent('okokNotify:Alert', source, "", 'Cops Requirement: '..Config.NumberOfCopsRequired, 5000, 'warning')
		end

end)

-- Plant a bomb

RegisterServerEvent('dd_tunnelheist:plantbomb')
AddEventHandler('dd_tunnelheist:plantbomb', function()

    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()

	local savedSource = source
	xPlayer.removeInventoryItem('c4_bank', 1)
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' then
			TriggerClientEvent('okokNotify:Alert', xPlayers[i], "", "Bomb has been planted at Tunnel Gate", 5000, 'warning')
		end
	end
	TriggerClientEvent('dd_tunnelheist:plantbombcomplete', savedSource)
	if(xPlayer)then
		TriggerClientEvent('okokNotify:Alert', xPlayer, "", "Bomb has been planted", 5000, 'warning')
	end

end)

RegisterServerEvent('dd_tunnelheist:opendoor')
AddEventHandler('dd_tunnelheist:opendoor', function(x,y,z, doortype)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' then
			TriggerClientEvent('okokNotify:Alert', xPlayers[i], "", "Robbery in progress at Tunnel", 5000, 'warning')	
			TriggerClientEvent('dd_tunnelheist:setblip', xPlayers[i])
		end
	end
	TriggerClientEvent('dd_tunnelheist:opendoors', -1, x,y,z, doortype)
	TriggerEvent("dd_news:PostNews", 'Tunnel')
end)

RegisterServerEvent('dd_tunnelheist:plantbombtoall')
AddEventHandler('dd_tunnelheist:plantbombtoall', function(x,y,z, doortype)
    SetTimeout(20000, function()
        TriggerClientEvent('dd_tunnelheist:plantedbomb', -1, x,y,z, doortype)
    end)
end)

RegisterServerEvent('dd_tunnelheist:closedoor')
AddEventHandler('dd_tunnelheist:closedoor', function()
	local cooldowntimer = Config.TimeToCloseGates*1000
	TriggerClientEvent('okokNotify:Alert', -1, "", 'Tunnel gate will close in '..Config.TimeToCloseGates..' seconds', 10000, 'warning')
	SetTimeout((cooldowntimer), function()
		TimerHasEnded()
	end)
end)
function TimerHasEnded()
    TriggerClientEvent('dd_tunnelheist:closedoor', -1)
	TriggerClientEvent('okokNotify:Alert', -1, "", "Tunnel gate closed", 5000, 'warning')
end

RegisterServerEvent('dd_tunnelheist:plantbomb')
AddEventHandler('dd_tunnelheist:plantbomb', function()
    TriggerClientEvent('dd_tunnelheist:plantbomb', -1)
end)

