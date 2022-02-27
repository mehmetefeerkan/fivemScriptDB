ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'police', Config.MaxInService)
end

RegisterServerEvent('edz:malikontrol')
AddEventHandler('edz:malikontrol', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(target)

    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = xTarget.identifier}, function(result)
        if result[1] ~= nil then
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Kişi adı: ' .. result[1].firstname .. ' ' .. result[1].lastname .. ' Hesaptaki miktar: ' .. result[1].bank .. '$', length = 5000})
			TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'error', text = 'Polis banka hesaplarını kontrol ediyor!'})
        end
    end)
end)

TriggerEvent('esx_phone:registerNumber', 'police', _U('alert_police'), true, true)
TriggerEvent('esx_society:registerSociety', 'police', 'Police', 'society_police', 'society_police', 'society_police', {type = 'public'})

-- RegisterServerEvent('esx_policejob:confiscatePlayerItem')
-- AddEventHandler('esx_policejob:confiscatePlayerItem', function(target, itemType, itemName, amount)
-- 	local _source = source
-- 	local sourceXPlayer = ESX.GetPlayerFromId(_source)
-- 	local targetXPlayer = ESX.GetPlayerFromId(target)

-- 	if sourceXPlayer.job.name ~= 'police' then
-- 		print(('esx_policejob: %s attempted to confiscate!'):format(xPlayer.identifier))
-- 		return
-- 	end

-- 	if itemType == 'item_standard' then
-- 		local targetItem = targetXPlayer.getInventoryItem(itemName)
-- 		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

-- 		-- does the target player have enough in their inventory?
-- 		if targetItem.count > 0 and targetItem.count <= amount then

-- 			-- can the player carry the said amount of x item?
-- 			if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
-- 				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = _U('quantity_invalid')})
-- 			else
-- 				targetXPlayer.removeInventoryItem(itemName, amount)
-- 				sourceXPlayer.addInventoryItem   (itemName, amount)
-- 				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = _U('you_confiscated', amount, sourceItem.label, targetXPlayer.name)})
-- 				TriggerClientEvent('mythic_notify:client:SendAlert', target, { type = 'inform', text = _U('got_confiscated', amount, sourceItem.label, sourceXPlayer.name)})
-- 			end
-- 		else
-- 			TriggerClientEvent('mythic_notify:client:SendAlert', target, { type = 'error', text = _U('quantity_invalid')})
-- 		end

-- 	elseif itemType == 'item_account' then
-- 		targetXPlayer.removeAccountMoney(itemName, amount)
-- 		sourceXPlayer.addAccountMoney   (itemName, amount)

-- 		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = _U('you_confiscated_account', amount, itemName, targetXPlayer.name)})
-- 		TriggerClientEvent('mythic_notify:client:SendAlert', target, { type = 'inform', text = _U('got_confiscated_account', amount, itemName, sourceXPlayer.name)})

-- 	elseif itemType == 'item_weapon' then
-- 		if amount == nil then amount = 0 end
-- 		targetXPlayer.removeWeapon(itemName, amount)
-- 		sourceXPlayer.addWeapon   (itemName, amount)

-- 		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = _U('you_confiscated_weapon', ESX.GetWeaponLabel(itemName), targetXPlayer.name, amount)})
-- 		TriggerClientEvent('mythic_notify:client:SendAlert', target, { type = 'inform', text = _U('got_confiscated_weapon', ESX.GetWeaponLabel(itemName), amount, sourceXPlayer.name)})
-- 	end
-- end)

ESX.RegisterServerCallback("esx_policejob:getPlayerOutfit", function(source, cb, num)
    local player = ESX.GetPlayerFromId(source)

    TriggerEvent("esx_datastore:getDataStore", "property", player["identifier"], function(store)
        local outfit = store.get("dressing", num)

        cb(outfit["skin"])
    end)
end)

ESX.RegisterServerCallback("esx_policejob:getPlayerDressing", function(source, cb)
    local player = ESX.GetPlayerFromId(source)
  
    TriggerEvent("esx_datastore:getDataStore", "property", player["identifier"], function(store)
        local count = store.count("dressing")

        local labels = {}
  
        for index = 1, count do
            local entry = store.get("dressing", index)

            table.insert(labels, entry["label"])
        end
  
        cb(labels)
    end)
end)

RegisterServerEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function(target)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local currentHandcuffs     = xPlayer.getInventoryItem('handcuffs').count
	if currentHandcuffs > 0 then
			TriggerClientEvent('esx_policejob:handcuff', target)
			xPlayer.removeInventoryItem("handcuffs", 1)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Kelepçen yok!'})
	end
end)

RegisterServerEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policejob:drag', target, source)
	else
		print(('esx_policejob: %s attempted to drag (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' or xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policejob:putInVehicle', target)
	else
		print(('esx_policejob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' or xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policejob:OutVehicle', target)
	else
		print(('esx_policejob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_policejob:getStockItem')
AddEventHandler('esx_policejob:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			if xPlayer.canCarryItem(itemName, count) then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = _U('have_withdrawn', count, inventoryItem.label)})
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('quantity_invalid')})
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('quantity_invalid')})
		end
	end)
end)

RegisterServerEvent('esx_policejob:putStockItems')
AddEventHandler('esx_policejob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	-- TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		-- local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			-- inventory.addItem(itemName, count)
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = _U('have_deposited')})
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = _U('quantity_invalid')})
		end
	-- end)
end)

ESX.RegisterServerCallback('esx_policejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local items = xPlayer.getInventoryItem(item)
		if items == nil then
			cb(0)
		else
			cb(items.count)
		end
	end
end)

ESX.RegisterServerCallback('esx_policejob:getOtherPlayerData', function(source, cb, target)
	if Config.EnableESXIdentity then
		local xPlayer = ESX.GetPlayerFromId(target)
		local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, sex, dateofbirth, height FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		})

		local firstname = result[1].firstname
		local lastname  = result[1].lastname
		local sex       = result[1].sex
		local dob       = result[1].dateofbirth
		local height    = result[1].height

		local data = {
			name      = GetPlayerName(target),
			job       = xPlayer.job,
			inventory = xPlayer.inventory,
			accounts  = xPlayer.accounts,
			weapons   = xPlayer.loadout,
			firstname = firstname,
			lastname  = lastname,
			sex       = sex,
			dob       = dob,
			height    = height
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		if Config.EnableLicenses then
			TriggerEvent('esx_license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end
	else
		local xPlayer = ESX.GetPlayerFromId(target)

		local data = {
			name       = GetPlayerName(target),
			job        = xPlayer.job,
			inventory  = xPlayer.inventory,
			accounts   = xPlayer.accounts,
			weapons    = xPlayer.loadout
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status then
				data.drunk = math.floor(status.percent)
			end
		end)

		TriggerEvent('esx_license:getLicenses', target, function(licenses)
			data.licenses = licenses
		end)

		cb(data)
	end
end)

ESX.RegisterServerCallback('esx_policejob:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleInfos', function(source, cb, plate)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)

		local retrivedInfo = {
			plate = plate
		}

		if result[1] then
			MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					retrivedInfo.owner = result[1].firstname .. ' ' .. result[1].lastname
				else
					retrivedInfo.owner = result[1].name
				end

				cb(retrivedInfo)
			end)
		else
			cb(retrivedInfo)
		end
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleFromPlate', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] ~= nil then

			MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					cb(result2[1].firstname .. ' ' .. result2[1].lastname, true)
				else
					cb(result2[1].name, true)
				end

			end)
		else
			cb(_U('unknown'), false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getArmoryWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('esx_policejob:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 0
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('esx_policejob:buyWeapon', function(source, cb, weaponName, type, componentNum)
	local xPlayer = ESX.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = Config.AuthorizedWeapons[xPlayer.job.grade_name]

	for k,v in ipairs(authorizedWeapons) do
		if v.weapon == weaponName then
			selectedWeapon = v
			break
		end
	end

	if not selectedWeapon then
		print(('esx_policejob: %s attempted to buy an invalid weapon.'):format(xPlayer.identifier))
		cb(false)
	else
		-- Weapon
		if type == 1 then
			if xPlayer.getMoney() >= selectedWeapon.price then
				xPlayer.removeMoney(selectedWeapon.price)
				xPlayer.addWeapon(weaponName, 100)

				cb(true)
			else
				cb(false)
			end

		-- Weapon Component
		elseif type == 2 then
			local price = selectedWeapon.components[componentNum]
			local weaponNum, weapon = ESX.GetWeapon(weaponName)

			local component = weapon.components[componentNum]

			if component then
				if xPlayer.getMoney() >= price then
					xPlayer.removeMoney(price)
					xPlayer.addWeaponComponent(weaponName, component.name)

					cb(true)
				else
					cb(false)
				end
			else
				print(('esx_policejob: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
				cb(false)
			end
		end
	end
end)


ESX.RegisterServerCallback('esx_policejob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('esx_policejob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)

			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
				['@owner'] = xPlayer.identifier,
				['@vehicle'] = json.encode(vehicleProps),
				['@plate'] = vehicleProps.plate,
				['@type'] = type,
				['@job'] = xPlayer.job.name,
				['@stored'] = true
			}, function (rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_policejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				print(('esx_policejob: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end

end)

function getPriceFromHash(hashKey, jobGrade, type)
	if type == 'helicopter' then
		local vehicles = Config.AuthorizedHelicopters[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	elseif type == 'car' then
		local vehicles = Config.AuthorizedVehicles[jobGrade]
		local shared = Config.AuthorizedVehicles['Shared']

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end

		for k,v in ipairs(shared) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	end

	return 0
end

ESX.RegisterServerCallback('esx_policejob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

-- AddEventHandler('playerDropped', function()
-- 	-- Save the source in case we lose it (which happens a lot)
-- 	local _source 		= source
-- 	local xPlayer 		= ESX.GetPlayerFromId(_source)

-- 	-- Did the player ever join?
-- 	if _source ~= nil then
		

-- 		-- Is it worth telling all clients to refresh?
-- 		Citizen.Wait(5000)
-- 		TriggerClientEvent('esx_policejob:updateBlip', -1)
-- 	end
-- end)

-- RegisterServerEvent('esx_policejob:spawned')
-- AddEventHandler('esx_policejob:spawned', function()
-- 	local _source 			= source

-- 		TriggerClientEvent('esx_policejob:updateBlip', -1)
-- end)

-- RegisterServerEvent('esx_policejob:forceBlip')
-- AddEventHandler('esx_policejob:forceBlip', function()
-- 	local _source = source

-- 	TriggerClientEvent('esx_policejob:updateBlip', -1)
-- end)

-- AddEventHandler('onResourceStart', function(resource)
-- 	if resource == GetCurrentResourceName() then
-- 		Citizen.Wait(5000)
-- 		TriggerClientEvent('esx_policejob:updateBlip', -1)
-- 	end
-- end)

-- AddEventHandler('onResourceStop', function(resource)
-- 	if resource == GetCurrentResourceName() then
-- 		TriggerEvent('esx_phone:removeNumber', 'police')
-- 		TriggerClientEvent('esx_policejob:removeBlip', -1)
-- 	end
-- end)

RegisterServerEvent('esx_policejob:message')
AddEventHandler('esx_policejob:message', function(target, msg)
	-- TriggerClientEvent('esx:showNotification', target, msg)
	TriggerClientEvent('mythic_notify:client:SendAlert', target, { type = 'error', text = msg})
end)

RegisterServerEvent('esx_policejob:requestarrest')
AddEventHandler('esx_policejob:requestarrest', function(targetid, playerheading, playerCoords,  playerlocation)
	_source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local currentHandcuffs     = xPlayer.getInventoryItem('handcuffs').count
	if currentHandcuffs > 0 then
			TriggerClientEvent('esx_policejob:getarrested', targetid, playerheading, playerCoords, playerlocation)
			TriggerClientEvent('esx_policejob:doarrested', _source)
			xPlayer.removeInventoryItem("handcuffs", 1)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Kelepçen yok!'})
	end
end)

RegisterServerEvent('esx_policejob:requestrelease')
AddEventHandler('esx_policejob:requestrelease', function(targetid, playerheading, playerCoords,  playerlocation)
	_source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local currentHandcuffkey     = xPlayer.getInventoryItem('handcuffkey').count
	if currentHandcuffkey > 0 then
			TriggerClientEvent('esx_policejob:getuncuffed', targetid, playerheading, playerCoords, playerlocation, _source)
			-- TriggerClientEvent('esx_policejob:douncuffing', _source)
			-- xPlayer.addInventoryItem('handcuffs', 1)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Kelepçe anahtarın yok!'})
	end
end)

RegisterServerEvent('esx_policejob:givehandcuff')
AddEventHandler('esx_policejob:givehandcuff', function(cozenkisi)
	local xPlayer = ESX.GetPlayerFromId(cozenkisi)
	-- local currentHandcuff     = xPlayer.getInventoryItem('handcuffs').count
	TriggerClientEvent('esx_policejob:douncuffing', cozenkisi)
	if xPlayer.canCarryItem('handcuffs', 1) then
			xPlayer.addInventoryItem('handcuffs', 1)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Üzerinde kelepçe taşıyacak kadar yerin yok!'})
	end
end)

RegisterServerEvent('esx_policejob:nothandcuffed')
AddEventHandler('esx_policejob:nothandcuffed', function(cozenkisi)
	local xPlayer = ESX.GetPlayerFromId(cozenkisi)
	TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'Kişi kelepçeli değil!'})
end)

-- AddEventHandler('esx:onAddInventoryItem', function(source, item, count)
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)
	
-- 		if item.name == 'gps' and item.count > 0 then
-- 			TriggerClientEvent('esx_policejob:updateBlip', source)
-- 		end
-- end)

-- AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
--     local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)
	
-- 		if item.name == 'gps' and item.count < 1 then
-- 			TriggerClientEvent('esx_policejob:removeBlip', source)
-- 		end
-- end)
