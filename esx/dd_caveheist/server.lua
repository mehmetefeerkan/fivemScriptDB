
local rob = false
local robbers = {}
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('dd_caveheist:rob')
AddEventHandler('dd_caveheist:rob', function()

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

	local savedSource = source
	local span = Config.robbingVault
	TriggerClientEvent('dd_caveheist:currentlyrobbing', source)
	TriggerClientEvent('dd_caveheist:starLooting', source)
	local totalspan = span*1000*6
	SetTimeout(totalspan, function()
		
		if Config.moneyType == 'cash' then
			xPlayer.addMoney(Config.Reward)
		elseif Config.moneyType == 'black' then
			xPlayer.addAccountMoney('black_money', Config.Reward)
		end
		TriggerClientEvent('dd_caveheist:robberycomplete', savedSource, Config.Reward)
		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' then
				TriggerClientEvent('okokNotify:Alert', xPlayers[i], "NEWS", "Robbery completed at Cave", 5000, 'warning')
				TriggerClientEvent('dd_caveheist:killblip', xPlayers[i])
			end
		end
	end)
end)

RegisterServerEvent('dd_caveheist:drill')
AddEventHandler('dd_caveheist:drill', function()

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
			if xPlayer.getInventoryItem('drill').count >= 1 then
				TriggerClientEvent('dd_caveheist:currentlydrilling', source)
				for i=1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' then
						TriggerClientEvent('okokNotify:Alert', xPlayers[i], "NEWS", "Robbery progress at Cave", 5000, 'warning')			
						TriggerClientEvent('dd_caveheist:setblip', xPlayers[i])
					end
				end
			else
				TriggerClientEvent('okokNotify:Alert', source, "", "You need a drill", 3000, 'info')	
			end
		else
			TriggerClientEvent('okokNotify:Alert', source, "", 'Cops Requirement: '..Config.NumberOfCopsRequired, 3000, 'info')	
		end

end)

-- Plant a bomb

RegisterServerEvent('dd_caveheist:plantbomb')
AddEventHandler('dd_caveheist:plantbomb', function()

    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()

	local savedSource = source
	xPlayer.removeInventoryItem('c4_bank', 1)
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' then
			TriggerClientEvent('okokNotify:Alert', xPlayers[i], "NEWS", "Bomb has been planted", 5000, 'warning')
		end
	end
	TriggerClientEvent('dd_caveheist:plantbombcomplete', savedSource)
	if(xPlayer)then
		TriggerClientEvent('okokNotify:Alert', xPlayer, "", 'Bomb has been planted.', 3000, 'info')	
	end

end)

RegisterServerEvent('dd_caveheist:opendoor')
AddEventHandler('dd_caveheist:opendoor', function(x,y,z, doortype)
	TriggerClientEvent('dd_caveheist:opendoors', -1, x,y,z, doortype)
	-- TriggerEvent("_rc_news:StartTimer")
	TriggerEvent("dd_news:PostNews", 'Cave')
end)

RegisterServerEvent('dd_caveheist:plantbombtoall')
AddEventHandler('dd_caveheist:plantbombtoall', function(x,y,z, boxtype)
    SetTimeout(10000, function()
        TriggerClientEvent('dd_caveheist:plantedbomb', -1, x,y,z, boxtype)
    end)
end)

RegisterServerEvent('dd_caveheist:closedoor')
AddEventHandler('dd_caveheist:closedoor', function()
	local cooldowntimer = Config.TimeToCloseGates*1000
	TriggerClientEvent('okokNotify:Alert', -1, "", 'Cave gate will close in '..Config.TimeToCloseGates..' seconds', 3000, 'warning')	
	SetTimeout((cooldowntimer), function()
		TimerHasEnded()
	end)
end)
function TimerHasEnded()
    TriggerClientEvent('dd_caveheist:closedoor', -1)
	TriggerClientEvent('okokNotify:Alert', -1, "", 'Cave gate closed', 3000, 'warning')	
end

RegisterServerEvent('dd_caveheist:plantbomb')
AddEventHandler('dd_caveheist:plantbomb', function()
    TriggerClientEvent('dd_caveheist:plantbomb', -1)
end)
