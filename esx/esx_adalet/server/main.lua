ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'silahci', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'silahci', _U('alert_police'), true, true)
TriggerEvent('esx_society:registerSociety', 'silahci', 'silahci', 'society_police', 'society_police', 'society_police', {type = 'public'})



RegisterServerEvent('esx_qalle_brottsregister:add')
AddEventHandler('esx_qalle_brottsregister:add', function(id, reason)
  local identifier = ESX.GetPlayerFromId(id).identifier
  local date = os.date("%Y-%m-%d")
  MySQL.Async.fetchAll(
    'SELECT firstname, lastname FROM users WHERE identifier = @identifier',{['@identifier'] = identifier},
    function(result)
    if result[1] ~= nil then
      MySQL.Async.execute('INSERT INTO qalle_brottsregister (identifier, firstname, lastname, dateofcrime, crime) VALUES (@identifier, @firstname, @lastname, @dateofcrime, @crime)',
        {
          ['@identifier']   = identifier,
          ['@firstname']    = result[1].firstname,
          ['@lastname']     = result[1].lastname,
          ['@dateofcrime']  = date,
          ['@crime']        = reason,
        }
      )
    end
  end)
end)

RegisterServerEvent('esx_silahcijob:drag')
AddEventHandler('esx_silahcijob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'silahci' then
		TriggerClientEvent('esx_silahcijob:drag', target, source)
	else
		print(('esx_silahcijob: %s attempted to drag (not cop)!'):format(xPlayer.identifier))
	end
end)

function getIdentity(source)
  local identifier = GetPlayerIdentifiers(source)[1]
  local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
  if result[1] ~= nil then
    local identity = result[1]

    return {
      identifier = identity['identifier'],
      firstname = identity['firstname'],
      lastname = identity['lastname'],
      dateofbirth = identity['dateofbirth'],
      sex = identity['sex'],
      height = identity['height']
    }
  else
    return nil
  end
end

--gets brottsregister
ESX.RegisterServerCallback('esx_qalle_brottsregister:grab', function(source, cb, target)
  local identifier = ESX.GetPlayerFromId(target).identifier
  local name = getIdentity(target)
  MySQL.Async.fetchAll("SELECT identifier, firstname, lastname, dateofcrime, crime FROM `qalle_brottsregister` WHERE `identifier` = @identifier",
  {
    ['@identifier'] = identifier
  },
  function(result)
    if identifier ~= nil then
        local crime = {}

      for i=1, #result, 1 do
        table.insert(crime, {
          crime = result[i].crime,
          name = result[i].firstname .. ' - ' .. result[i].lastname,
          date = result[i].dateofcrime,
        })
      end
      cb(crime)
    end
  end)
end)

RegisterServerEvent('esx_qalle_brottsregister:remove')
AddEventHandler('esx_qalle_brottsregister:remove', function(id, crime)
  local identifier = ESX.GetPlayerFromId(id).identifier
  MySQL.Async.fetchAll(
    'SELECT firstname FROM users WHERE identifier = @identifier',{['@identifier'] = identifier},
    function(result)
    if (result[1] ~= nil) then
      MySQL.Async.execute('DELETE FROM qalle_brottsregister WHERE identifier = @identifier AND crime = @crime',
      {
        ['@identifier']    = identifier,
        ['@crime']     = crime
      }
    )
    end
  end)
end)

RegisterServerEvent('esx_silahcijob:putInVehicle')
AddEventHandler('esx_silahcijob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'silahci' then
		TriggerClientEvent('esx_silahcijob:putInVehicle', target)
	else
		print(('esx_silahcijob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_silahcijob:OutVehicle')
AddEventHandler('esx_silahcijob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'silahci' then
		TriggerClientEvent('esx_silahcijob:OutVehicle', target)
	else
		print(('esx_silahcijob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_silahcijob:getStockItem')
AddEventHandler('esx_silahcijob:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
		
			-- can the player carry the said amount of x item?
			if sourceItem.weight ~= -1 and (sourceItem.count + count) > sourceItem.weight then
				TriggerClientEvent("pNotify:SendNotification", _source, {text = _U('quantity_invalid'),type = "warning",queue = "duty", theme = "metroui", timeout = 2500,layout = "topRight" })

			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)

--[[
		MySQL.Async.execute('INSERT INTO bz_policelog (Alan, Type, Miktar, Eylem)VALUES (@Alan, @Type, @Miktar, @Eylem) ', 
			{['@Alan']   = xPlayer.name,
			['@Type']   = itemName,
			['@Miktar']    = count,
			['@Eylem']    = 'Polis Kasasından Aldı' })
--]]


				TriggerClientEvent("pNotify:SendNotification", _source, {text = _U('have_withdrawn', count, inventoryItem.label),type = "warning",queue = "duty", theme = "metroui", timeout = 2500,layout = "topRight" })

			end
		else
			TriggerClientEvent("pNotify:SendNotification", _source, {text = _U('quantity_invalid'),type = "warning",queue = "duty", theme = "metroui", timeout = 2500,layout = "topRight" })

		end
	end)

end)

RegisterServerEvent('esx_silahcijob:putStockItems')
AddEventHandler('esx_silahcijob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)

--[[
		MySQL.Async.execute('INSERT INTO bz_policelog (Alan, Type, Miktar, Eylem)VALUES (@Alan, @Type, @Miktar, @Eylem) ', 
			{['@Alan']   = xPlayer.name,
			['@Type']   = itemName,
			['@Miktar']    = count,
			['@Eylem']    = 'Polis Kasasına Koydu' })
--]]

			TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {text = _U('have_deposited', count, inventoryItem.label),type = "warning",queue = "duty", theme = "metroui", timeout = 2500,layout = "topRight" })

		else
			TriggerClientEvent("pNotify:SendNotification", xPlayer.source, {text = _U('quantity_invalid'),type = "warning",queue = "duty", theme = "metroui", timeout = 2500,layout = "topRight" })

		end

	end)

end)

ESX.RegisterServerCallback('esx_silahcijob:getOtherPlayerData', function(source, cb, target)

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

ESX.RegisterServerCallback('esx_silahcijob:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('esx_silahcijob:getVehicleInfos', function(source, cb, plate)

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

ESX.RegisterServerCallback('esx_silahcijob:getVehicleFromPlate', function(source, cb, plate)
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

ESX.RegisterServerCallback('esx_silahcijob:getArmoryWeapons', function(source, cb)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)

end)

ESX.RegisterServerCallback('esx_silahcijob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)

	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

--[[
		MySQL.Async.execute('INSERT INTO bz_policelog (Alan, Type, Miktar, Eylem)VALUES (@Alan, @Type, @Miktar, @Eylem) ', 
			{['@Alan']   = xPlayer.name,
			['@Type']   = itemName,
			['@Miktar']    = count,
			['@Eylem']    = 'Polis Kasasına Koydu' })
--]]

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

ESX.RegisterServerCallback('esx_silahcijob:removeArmoryWeapon', function(source, cb, weaponName)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addWeapon(weaponName, 100)

--[[
		MySQL.Async.execute('INSERT INTO bz_policelog (Alan, Type, Miktar, Eylem)VALUES (@Alan, @Type, @Miktar, @Eylem) ', 
			{['@Alan']   = xPlayer.name,
			['@Type']   = itemName,
			['@Miktar']    = count,
			['@Eylem']    = 'Polis Kasasından Aldı' })
--]]

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

ESX.RegisterServerCallback('esx_silahcijob:buyWeapon', function(source, cb, weaponName, type, componentNum)
	local xPlayer = ESX.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = Config.AuthorizedWeapons[xPlayer.job.grade_name]

	for k,v in ipairs(authorizedWeapons) do
		if v.weapon == weaponName then
			selectedWeapon = v
			break
		end
	end

	if not selectedWeapon then
		print(('esx_silahcijob: %s attempted to buy an invalid weapon.'):format(xPlayer.identifier))
		cb(false)
	end

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
			print(('esx_silahcijob: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
			cb(false)
		end
	end
end)


ESX.RegisterServerCallback('esx_silahcijob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('esx_silahcijob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
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

ESX.RegisterServerCallback('esx_silahcijob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
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
				print(('esx_silahcijob: %s has exploited the garage!'):format(xPlayer.identifier))
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

ESX.RegisterServerCallback('esx_silahcijob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_silahcijob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

AddEventHandler('playerDropped', function()
    -- Save the source in case we lose it (which happens a lot)
    local _source         = source
    local xPlayer         = ESX.GetPlayerFromId(_source)

    -- Did the player ever join?
    if _source ~= nil then
      

        -- Is it worth telling all clients to refresh?
        if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'silahci' then
            local currentGPS    = xPlayer.getInventoryItem('gps').count
            Citizen.Wait(5000)
            if currentGPS > 0 then 
                TriggerClientEvent('esx_silahcijob:updateBlip', -1)
            end
        end
    end
end)

RegisterServerEvent('esx_silahcijob:spawned')
AddEventHandler('esx_silahcijob:spawned', function()
    local _source             = source
    local xPlayer             = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'silahci' then
        local currentGPS = xPlayer.getInventoryItem('gps').count
        Citizen.Wait(5000)
        if currentGPS > 0 then
            TriggerClientEvent('esx_silahcijob:updateBlip', -1)
        end
    end
end)

RegisterServerEvent('esx_silahcijob:forceBlip')
AddEventHandler('esx_silahcijob:forceBlip', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local currentGPS     = xPlayer.getInventoryItem('gps').count

    if currentGPS > 0 then
        TriggerClientEvent('esx_silahcijob:updateBlip', -1)
    end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'silahci')
	end
end)

RegisterServerEvent('esx_silahcijob:message')
AddEventHandler('esx_silahcijob:message', function(target, msg)
	print("^2esx_silahcijob:message | Mesaj atıyor.^2 ^5" .. GetPlayerName(source) .. "^6 [" .. source .. "] ^3Tarafından tetiklendi.^3")
	TriggerClientEvent('esx:showNotification', target, msg)
	TriggerClientEvent("pNotify:SendNotification",target, msg, {type = "warning",queue = "duty", theme = "metroui", timeout = 2500,layout = "topRight" })

end)

RegisterServerEvent('esx_silahcijob:requestarrest')
AddEventHandler('esx_silahcijob:requestarrest', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('esx_silahcijob:getarrested', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('esx_silahcijob:doarrested', _source)
end)

RegisterServerEvent('esx_silahcijob:requestrelease')
AddEventHandler('esx_silahcijob:requestrelease', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
    TriggerClientEvent('esx_silahcijob:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('esx_silahcijob:douncuffing', _source)
end)

ESX.RegisterServerCallback('esx_silahcijob:getItemAmount', function(source, cb, item)
        local xPlayer = ESX.GetPlayerFromId(source)
        local items = xPlayer.getInventoryItem(item)
        if items == nil then
            cb(0)
        else
            cb(items.count)
        end
end)

AddEventHandler('esx:onAddInventoryItem', function(source, item, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'silahci' then
        if item.name == 'gps' and item.count > 0 then
            TriggerClientEvent('esx_silahcijob:updateBlip', source)
        end
    end
end)

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'silahci' then
        if item.name == 'gps' and item.count < 1 then
            TriggerClientEvent('esx_silahcijob:removeBlip', source) -- bu event cliente sonradan ekleniyor
        end
    end
end)