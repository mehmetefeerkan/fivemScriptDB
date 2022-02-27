ESX = nil
local Vehicles
local Webhook = "https://discord.com/api/webhooks/904986948265967636/Y_dkEssAXnytsOmVGl2bsQLaSHLri53SYu8V25S_AuQm9nH1ENlOzA_z35w7zjKhBRPw"
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('dd_custom:buyMod')
AddEventHandler('dd_custom:buyMod', function(price,modName,myCar)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	price = tonumber(price)

	if Config.IsMechanicJobOnly then
		local societyAccount

		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
			societyAccount = account
		end)

		if price < societyAccount.money then
			TriggerClientEvent('dd_custom:installMod', _source)
			TriggerClientEvent('okokNotify:Alert', _source, "LS CUSTOM", _U('purchased'), 3000, 'info')

			societyAccount.removeMoney(price)
			-- local msg = "👨‍🔧 MECHAN🔩C: **"..xPlayer.name .. "** \n PLATE: **"..myCar.plate.. "** \nMOD TYPE: **" .. modName .. "**"
			-- sendToDiscord(Webhook, 16711680, "Mech Upgrades", msg, " ")
		else
			TriggerClientEvent('dd_custom:cancelInstallMod', _source)
			TriggerClientEvent('okokNotify:Alert', _source, "LS CUSTOM", _U('not_enough_money'), 3000, 'info')
		end
	else
		if price < xPlayer.getMoney() then
			TriggerClientEvent('dd_custom:installMod', _source)
			TriggerClientEvent('okokNotify:Alert', _source, "LS CUSTOM", _U('purchased'), 3000, 'info')
			xPlayer.removeMoney(price)
			-- local msg = "👨‍🔧 MECHAN🔩C: **"..xPlayer.name .. "** \n PLATE: **"..myCar.plate.. "** \nMOD TYPE: **" .. modName .. "**"
			-- sendToDiscord(Webhook, 16711680, "Mech Upgrades", msg, " ")
		else
			TriggerClientEvent('dd_custom:cancelInstallMod', _source)
			TriggerClientEvent('okokNotify:Alert', _source, "LS CUSTOM", _U('not_enough_money'), 3000, 'info')
		end
	end
end)

RegisterServerEvent('dd_custom:refreshOwnedVehicle')
AddEventHandler('dd_custom:refreshOwnedVehicle', function(vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT vehicle FROM users_cars WHERE plate = @plate', {
		['@plate'] = vehicleProps.plate
	}, function(result)
		if result[1] then
			local vehicle = json.decode(result[1].vehicle)

			if vehicleProps.model == vehicle.model then
				MySQL.Async.execute('UPDATE users_cars SET vehicle = @vehicle WHERE plate = @plate', {
					['@plate'] = vehicleProps.plate,
					['@vehicle'] = json.encode(vehicleProps)
				})
			else
				print(('dd_custom: %s attempted to upgrade vehicle with mismatching vehicle model!'):format(xPlayer.identifier))
			end
		end
	end)
end)

RegisterServerEvent('dd_custom:GetPlateOwner')
AddEventHandler('dd_custom:GetPlateOwner', function(myCar,amount)
	local _source = source
	local xTarget = ESX.GetPlayerFromId(source)
	local sender = ESX.GetPlayerFromId(source)
	local query = [[
	SELECT * FROM users_cars LEFT JOIN users ON users_cars.owner = users.identifier WHERE users_cars.plate LIKE @plate LIMIT 1
	]]

	MySQL.Async.fetchAll(query, {
	['plate'] = myCar.plate,
	['@owner'] = xTarget.identifier
	}, function(result)

	if result[1] then
		MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
			['@identifier'] = xTarget.identifier,
			['@sender'] = 'Dig Deep Mechanics',
			['@target_type'] = 'society',
			['@target'] = 'society_mechanic',
			['@label'] = 'Upgrade and Cosmetics billing',
			['@amount'] = amount
		}, function(result)
			if result then
				TriggerClientEvent('okokNotify:Alert', xTarget.source, "LS CUSTOM", "New bill received.", 3000, 'info')
				local msg = "👨‍🔧 MECHAN🔩C: **"..sender.name .. "** \n CAR OWNER: **"..xTarget.name.. "** \n PLATE: **"..myCar.plate.. "** \nTOTAL BILL: **" .. amount .. "**"
				sendToDiscord(Webhook, 16711680, "Mech Upgrades", msg, " ")
			else
				print("not online")
				local msg = "👨‍🔧 MECHAN🔩C: **"..sender.name .. "** \n CAR OWNER: **"..xTarget.name.. "** \n PLATE: **"..myCar.plate.. "** \nTOTAL BILL: **" .. amount .. "**"
				sendToDiscord(Webhook, 16711680, "Mech Upgrades", msg, " ")
			end
		end)
		elseif not result[1] then
			TriggerClientEvent('okokNotify:Alert', _source, "LS CUSTOM", "Vehicle with plate: ["..myCar.plate.."] Not found.", 3000, 'info')
		end
	end)
end)

function sendToDiscord(webhook, color, name, message, footer)
	local embed = {
		{
			["color"] = color,
			["title"] = "**UPGRADES / COSMETICS LOGS**",
			["description"] = message,
			["footer"] = {
			["text"] = "DD MECHAN🔩C",
			},
		}
	}
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end