AddEventHandler('playerDropped', function(reason)
	local source = source	
	local players = GetPlayers()
	if #players > 1 then
		local randomPlayerIndex = math.random( #players )
		local player = players[ randomPlayerIndex ]
		--print('Disconnected player name: ' .. GetPlayerName(source))
		if(GetPlayerName(player) == GetPlayerName(source)) then
			if(randomPlayerIndex > 1) then
				randomPlayerIndex = randomPlayerIndex - 1
				--print('Decreased by 1')
			else
				randomPlayerIndex = randomPlayerIndex + 1
				--print('Increased by 1')
			end
			player = players[ randomPlayerIndex ]
		end
		TriggerClientEvent('eventDeleteVehicles', player, source)
		--print('Source ' .. source)
		--print('Triggering event for ' .. player)
	end
end)

RegisterNetEvent("getNetID")
AddEventHandler('getNetID', function()	
	--print('Source ' .. source)
	TriggerClientEvent('playerConnected', source, source)
end)