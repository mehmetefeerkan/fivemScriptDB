ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'sheriff', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'sheriff', _U('alert_sheriff'), true, true)
TriggerEvent('esx_society:registerSociety', 'sheriff', 'Sheriff', 'society_sheriff', 'society_sheriff', 'society_sheriff', {type = 'public'})

RegisterServerEvent('esx_sheriffjob:confiscatePlayerItem')
AddEventHandler('esx_sheriffjob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.name ~= 'sheriff' then
		print(('esx_sheriffjob: %s tarafindan el konuldu!'):format(xPlayer.identifier))
		return
	end

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		-- does the target player have enough in their inventory?
		if targetItem.count > 0 and targetItem.count <= amount then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem   (itemName, amount)
				TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated', amount, sourceItem.label, targetXPlayer.name))
				TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated', amount, sourceItem.label, sourceXPlayer.name))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end

	elseif itemType == 'item_account' then
		targetXPlayer.removeAccountMoney(itemName, amount)
		sourceXPlayer.addAccountMoney   (itemName, amount)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_account', amount, itemName, targetXPlayer.name))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_account', amount, itemName, sourceXPlayer.name))

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		targetXPlayer.removeWeapon(itemName, amount)
		sourceXPlayer.addWeapon   (itemName, amount)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_weapon', ESX.GetWeaponLabel(itemName), targetXPlayer.name, amount))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_weapon', ESX.GetWeaponLabel(itemName), amount, sourceXPlayer.name))
	end
end)

---------------------D-E-X-A---------------------

--[[RegisterServerEvent('esx_sheriffjob:revive')
AddEventHandler('esx_sheriffjob:revive', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'sheriff' then
		TriggerClientEvent('esx_sheriffjob:revive', target)
	else
		print(('esx_sheriffjob: %s canlandirildi!'):format(xPlayer.identifier))
	end
end)--]]

RegisterServerEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(target)
TriggerClientEvent('esx_ambulancejob:revive', target)
end)

RegisterServerEvent('esx_sheriffjob:heal')
AddEventHandler('esx_sheriffjob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'sheriff' then
		TriggerClientEvent('esx_sheriffjob:heal', target, type)
	else
		print(('esx_sheriffjob: %s iyilestirildi!'):format(xPlayer.identifier))
	end
end)

---------------------D-E-X-A---------------------

RegisterServerEvent('esx_sheriffjob:handcuff')
AddEventHandler('esx_sheriffjob:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'sheriff' then
		TriggerClientEvent('esx_sheriffjob:handcuff', target)
	else
		print(('esx_sheriffjob: %s tarafindan kelepcelendin!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_sheriffjob:drag')
AddEventHandler('esx_sheriffjob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'sheriff' then
		TriggerClientEvent('esx_sheriffjob:drag', target, source)
	else
		print(('esx_sheriffjob: %s tarafindan surukleniyorsun!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_sheriffjob:putInVehicle')
AddEventHandler('esx_sheriffjob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'sheriff' then
		TriggerClientEvent('esx_sheriffjob:putInVehicle', target)
	else
		print(('esx_sheriffjob: %s tarafindan araca sokuldun!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_sheriffjob:OutVehicle')
AddEventHandler('esx_sheriffjob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'sheriff' then
		TriggerClientEvent('esx_sheriffjob:OutVehicle', target)
	else
		print(('esx_sheriffjob: %s tarafindan aractan cikartildin!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_sheriffjob:getStockItem')
AddEventHandler('esx_sheriffjob:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_sheriff', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, inventoryItem.label))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end
	end)

end)

RegisterServerEvent('esx_sheriffjob:putStockItems')
AddEventHandler('esx_sheriffjob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_sheriff', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, inventoryItem.label))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

	end)

end)

ESX.RegisterServerCallback('esx_sheriffjob:getOtherPlayerData', function(source, cb, target)

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
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		TriggerEvent('esx_license:getLicenses', target, function(licenses)
			data.licenses = licenses
		end)

		cb(data)

	end

end)

ESX.RegisterServerCallback('esx_sheriffjob:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('esx_sheriffjob:getVehicleInfos', function(source, cb, plate)


	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)

		local retrivedInfo = {
			plate = plate
		}

		if result[1] then

			MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					retrivedInfo.owner = result2[1].firstname .. ' ' .. result2[1].lastname
				else
					retrivedInfo.owner = result2[1].name
				end

				cb(retrivedInfo)
			end)
		else
			cb(retrivedInfo)
		end
	end)
end)

ESX.RegisterServerCallback('esx_sheriffjob:getVehicleFromPlate', function(source, cb, plate)
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

ESX.RegisterServerCallback('esx_sheriffjob:getArmoryWeapons', function(source, cb)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_sheriff', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)

end)

ESX.RegisterServerCallback('esx_sheriffjob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)

	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_sheriff', function(store)

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

ESX.RegisterServerCallback('esx_sheriffjob:removeArmoryWeapon', function(source, cb, weaponName)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addWeapon(weaponName) -- DEXA --[[ (weaponName, 500) --]]

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_sheriff', function(store)

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

ESX.RegisterServerCallback('esx_sheriffjob:buyWeapon', function(source, cb, weaponName, type, componentNum)
	local xPlayer = ESX.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = Config.AuthorizedWeapons[xPlayer.job.grade_name]

	for k,v in ipairs(authorizedWeapons) do
		if v.weapon == weaponName then
			selectedWeapon = v
			break
		end
	end

	if not selectedWeapon then
		print(('esx_sheriffjob: %s gecersiz bir silah almaya calistin.'):format(xPlayer.identifier))
		cb(false)
	end

	-- Weapon
	if type == 1 then
		if xPlayer.getMoney() >= selectedWeapon.price then
			xPlayer.removeMoney(selectedWeapon.price)
			xPlayer.addWeapon(weaponName, 250)

			cb(true)
		else
			cb(false)
		end

	-- Weapon Component
	elseif type == 2 then
		local price = selectedWeapon.components[weaponComponent]
		local weaponNum, weapon = ESX.GetWeapon(weaponName)

		local component = weapon.components[componentNum]

		if component then
			if xPlayer.getMoney() >= selectedWeapon.price then
				xPlayer.removeMoney(selectedWeapon.price)
				xPlayer.addWeaponComponent(weaponName, component.name)

				cb(true)
			else
				cb(false)
			end
		else
			print(('esx_sheriffjob: %s gecersiz bir gelistirme yapmaya calisiyorsun!'):format(xPlayer.identifier))
			cb(false)
		end
	end
end)


ESX.RegisterServerCallback('esx_sheriffjob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('esx_sheriffjob: %s gecersiz arac! (gecersiz model)'):format(xPlayer.identifier))
		cb(false)
	end

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
end)

ESX.RegisterServerCallback('esx_sheriffjob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
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
				print(('esx_sheriffjob: %s polis garajini kullandin.'):format(xPlayer.identifier))
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

ESX.RegisterServerCallback('esx_sheriffjob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_sheriff', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_sheriffjob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

--WİRO

AddEventHandler('playerDropped', function()
    -- Save the source in case we lose it (which happens a lot)
    local _source         = source
    local xPlayer         = ESX.GetPlayerFromId(_source)

    -- Did the player ever join?
    if _source ~= nil then
      

        -- Is it worth telling all clients to refresh?
        if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'sheriff' then
            local currentGPS    = xPlayer.getInventoryItem('gps').count
            Citizen.Wait(5000)
            if currentGPS > 0 then
                TriggerClientEvent('esx_sheriffjob:updateBlip', -1)
            end
        end
    end
end)

RegisterServerEvent('esx_sheriffjob:spawned')
AddEventHandler('esx_sheriffjob:spawned', function()
    local _source             = source
    local xPlayer             = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'sheriff' then
        local currentGPS         = xPlayer.getInventoryItem('gps').count
        Citizen.Wait(5000)
        if currentGPS > 0 then
            TriggerClientEvent('esx_sheriffjob:updateBlip', -1)
        end
    end
end)

RegisterServerEvent('esx_sheriffjob:forceBlip')
AddEventHandler('esx_sheriffjob:forceBlip', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local currentGPS     = xPlayer.getInventoryItem('gps').count

    if currentGPS > 0 then
        TriggerClientEvent('esx_sheriffjob:updateBlip', -1)
    end
end)
--BİTİŞ

RegisterServerEvent('esx_sheriffjob:spawned')
AddEventHandler('esx_sheriffjob:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'sheriff' then
		Citizen.Wait(0)
		--[[ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
			if quantity >= 1 then--]]
				TriggerClientEvent('esx_sheriffjob:updateBlip', -1)
			--[[end
		end, 'sheriffgps')--]]
	end
end)

RegisterServerEvent('esx_sheriffjob:forceBlip')
AddEventHandler('esx_sheriffjob:forceBlip', function()
		TriggerClientEvent('esx_sheriffjob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(0)
		--[[ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
			if quantity >= 1 then--]]
				TriggerClientEvent('esx_sheriffjob:updateBlip', -1)
			--[[end
		end, 'sheriffgps')--]]
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'sheriff')
	end
end)

RegisterServerEvent('esx_sheriffjob:message')
AddEventHandler('esx_sheriffjob:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)

------------------D-E-X-A---------------------
RegisterServerEvent('esx_sheriffjob:requestarrest')
AddEventHandler('esx_sheriffjob:requestarrest', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('esx_sheriffjob:getarrested', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('esx_sheriffjob:doarrested', _source)
end)

RegisterServerEvent('esx_sheriffjob:requestrelease')
AddEventHandler('esx_sheriffjob:requestrelease', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('esx_sheriffjob:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('esx_sheriffjob:douncuffing', _source)
end)
------------------D-E-X-A---------------------

--WİRO
ESX.RegisterServerCallback('esx_sheriffjob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items = xPlayer.getInventoryItem(item)
	if items == nil then
		cb(0)
	else
		cb(items.count)
	end
end)
--BİTİŞ

--WİRO
AddEventHandler('esx:onAddInventoryItem', function(source, item, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'sheriff' then
        if item.name == 'gps' and item.count > 0 then
            TriggerClientEvent('esx_sheriffjob:updateBlip', source)
        end
    end
end)

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'sheriff' then
        if item.name == 'gps' and item.count < 1 then
            TriggerClientEvent('esx_sheriffjob:removeBlip', source) -- bu event cliente sonradan ekleniyor
        end
    end
end)
--BİTİ

ESX.RegisterServerCallback('sheriffjob:isplayerdead', function(source, cb, target)
    local player = ESX.GetPlayerFromId(target)
    MySQL.Async.fetchAll('SELECT is_dead FROM users WHERE identifier = @identifier', {
        ['@identifier'] = player.identifier
    }, function(result)
        local isDead = result[1].is_dead
        cb(isDead)
    end)
end)