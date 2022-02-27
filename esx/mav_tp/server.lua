ESX = nil

RegisterCommand("tp", function(source, args, user)
	local x = tonumber(args[1])
	local y = tonumber(args[2])
	local z = tonumber(args[3])
	
	if x and y and z then
		TriggerClientEvent('esx:teleport', source, {
			x = x,
			y = y,
			z = z
		})
	else
		TriggerClientEvent('chatMessage', source, "SISTEM", {255, 0, 0}, "Invalid coordinates!")
	end
end)

RegisterCommand("obje", function(source, args, user)
	TriggerClientEvent('esx:spawnObject', source, args[1])
end)