ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Make the kit usable!
ESX.RegisterUsableItem('lockpickarac', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if Config.AllowMecano then
		TriggerClientEvent('esx_lockpickarac:onUse', _source)
	else
		if xPlayer.job.name ~= 'mecano' then
			TriggerClientEvent('esx_lockpickarac:onUse', _source)
		end
	end
end)

RegisterNetEvent('esx_lockpickarac:removeKit')
AddEventHandler('esx_lockpickarac:removeKit', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if not Config.InfiniteLocks then
		xPlayer.removeInventoryItem('lockpickarac', 1)
		TriggerClientEvent('esx_status:add', source, 'stress', 150000)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Hırsızlık yaptığın için stres yapıyorsun.', length = 4000, style = { ['background-color'] = '#e03232', ['color'] = '#ffffff' } })
		TriggerClientEvent('esx:showNotification', _source, _U('used_kit'))
	end
end)

RegisterServerEvent('esx_lockpickarac:Notify')
AddEventHandler('esx_lockpickarac:Notify', function()
    TriggerClientEvent("esx_lockpickarac:Enable", source)
end)


RegisterServerEvent('esx_lockpickarac:InProgress')
AddEventHandler('esx_lockpickarac:InProgress', function(street1, street2, sex)
    TriggerClientEvent("esx_lockpickarac:outlawLockNotify", -1, "~r~Someone is lockpickaracing a vehicle")
end)


RegisterServerEvent('esx_lockpickarac:InProgressS1')
AddEventHandler('esx_lockpickarac:InProgressS1', function(street1, sex)
    TriggerClientEvent("esx_lockpickarac:outlawLockNotify", -1, "~r~Someone is lockpickaracing a vehicle")
end)

RegisterServerEvent('esx_lockpickarac:InProgressPos')
AddEventHandler('esx_lockpickarac:InProgressPos', function(tx, ty, tz)
    TriggerClientEvent('esx_lockpickarac:location', -1, tx, ty, tz)
end)

local vehicles = {}

function getVehData(plate, callback)
    MySQL.Async.fetchAll("SELECT * FROM `owned_vehicles`", {},
    function(result)
        local foundIdentifier = nil
        for i=1, #result, 1 do
            local vehicleData = json.decode(result[i].vehicle)
            if vehicleData.plate == plate then
                foundIdentifier = result[i].owner
                break
            end
        end
        if foundIdentifier ~= nil then
            MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier", {['@identifier'] = foundIdentifier},
            function(result)
                local ownerName = result[1].firstname .. " " .. result[1].lastname

                local info = {
                    plate = plate,
                    owner = ownerName
                }
                callback(info)
            end
          )
        else -- if identifier is nil then...
          local info = {
            plate = plate
          }
          callback(info)
        end
    end)
  end

RegisterNetEvent("esx_lockpickarac:setVehicleDoorsForEveryone")
AddEventHandler("esx_lockpickarac:setVehicleDoorsForEveryone", function(veh, doors, plate)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local veh_model = veh[1]
    local veh_doors = veh[2]
    local veh_plate = veh[3]

    if not vehicles[veh_plate] then
        getVehData(veh_plate, function(veh_data)
            if veh_data.plate ~= plate then
                local players = GetPlayers()
                for _,player in pairs(players) do
                    TriggerClientEvent("esx_lockpickarac:setVehicleDoors", player, table.unpack(veh, doors))
                end
            end
        end)
        vehicles[veh_plate] = true
    end
end)
