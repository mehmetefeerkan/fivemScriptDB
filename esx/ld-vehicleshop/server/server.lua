ESX              = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('vehicleshop.requestInfo')
AddEventHandler('vehicleshop.requestInfo', function()
    local src = source
    local rows    

    local xPlayer = ESX.GetPlayerFromId(src)
    --local identifier = GetPlayerIdentifiers(src)[1]

    local result = exports.ghmattimysql:executeSync("SELECT * FROM users WHERE identifier = @identifier", {
        ['@identifier'] = xPlayer.getIdentifier()
    })

    local firstname = 'adez'

    local resultVehicles = exports.ghmattimysql:executeSync('SELECT * FROM vehicles')

    TriggerClientEvent('vehicleshop.receiveInfo', src, xPlayer.getAccount('bank').money, firstname)    

    TriggerClientEvent("vehicleshop.vehiclesInfos", src , resultVehicles)

    TriggerClientEvent("vehicleshop.notify", src, 'error', _U('rotate_keys'))
end)



ESX.RegisterServerCallback('vehicleshop.isPlateTaken', function (source, cb, plate)
	exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)

RegisterServerEvent('vehicleshop.CheckMoneyForVeh')
AddEventHandler('vehicleshop.CheckMoneyForVeh', function(veh, price, name, vehicleProps)
	local source = source

	local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer == nil then
        return
    end

    exports.ghmattimysql:execute('SELECT * FROM vehicles WHERE model = @model LIMIT 1', {
		['@model'] = veh
    }, function (result)
        if #result > 0 then
            local veiculo = result[1]
            local vehicleModel = veh
            local vehiclePrice = price
            local stockQtd = result[1].stock       
            if stockQtd > 0 then           
                if xPlayer.getAccount('bank').money >= tonumber(vehiclePrice) then
                    xPlayer.removeAccountMoney('bank', tonumber(vehiclePrice))
                    stockQtd = stockQtd - 1	                    
                    local vehiclePropsjson = json.encode(vehicleProps)
                    
                    local stateVehicle = 0 

                    if Config.SpawnVehicle then
                        stateVehicle = 0
                    else
                        stateVehicle = 1
                    end
                    
                    exports.ghmattimysql:execute('INSERT INTO owned_vehicles (owner, plate, vehicle, job) VALUES (@owner, @plate, @vehicle, @job)',
                    {
                        ['@owner']   = xPlayer.identifier,
                        ['@plate']   = vehicleProps.plate,
                        ['@vehicle'] = vehiclePropsjson,
                        ['@job'] = 'sivil',                       
                    },
                    
                    function (rowsChanged)                     
                        exports.ghmattimysql:executeSync('UPDATE vehicles SET stock = @stock WHERE model = @model',
                        {
                            ['@stock'] = stockQtd,
                            ['@model'] = vehicleModel
                        })

                        TriggerClientEvent("vehicleshop.sussessbuy", source, name, vehicleProps.plate, vehiclePrice)
                        TriggerClientEvent('vehicleshop.receiveInfo', source, xPlayer.getAccount('bank').money)    
                        TriggerClientEvent('vehicleshop.spawnVehicle', source, vehicleModel, vehicleProps.plate)
                            info = {
                                    plaka = vehicleProps.plate,
                                    model = vehicleModel
                                }
                                xPlayer.addInventoryItem("carkey", 4, false, info)                       
                    end)
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Paranız Yetersiz', length = 2500})

                end
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Bu araca sahip değilsiniz.', length = 2500})
            end  
        end
	end)
end)

RegisterNetEvent('esx_vehicleshop:setJobVehicleState')
AddEventHandler('esx_vehicleshop:setJobVehicleState', function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	exports.ghmattimysql:execute('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate AND job = @job', {
		['@stored'] = state,
		['@plate'] = plate,
		['@job'] = xPlayer.job.name
	}, function(rowsChanged)
		if rowsChanged == 0 then
			print(('[esx_vehicleshop] [^3WARNING^7] %s exploited the garage!'):format(xPlayer.identifier))
		end
	end)
end)


ESX.RegisterServerCallback('esx_vehicleshop:retrieveJobVehicles', function(source, cb, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type AND job = @job', {
		['@owner'] = xPlayer.identifier,
		['@type'] = type,
		['@job'] = xPlayer.job.name
	}, function(result)
		cb(result)
	end)
end)