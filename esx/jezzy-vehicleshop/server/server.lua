ESX = nil 
local vehicletable = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


Citizen.CreateThread(function()
	local char = Config.PlateLetters
	char = char + Config.PlateNumbers
	if Config.PlateUseSpace then char = char + 1 end

	if char > 8 then
		print(('[^3WARNING^7] Plate character count reached, %s/8 characters!'):format(char))
	end

    Citizen.Wait(1000)
    exports.ghmattimysql:execute('SELECT * FROM `vehicles`', {}, function(result)
        vehicletable = result
    end)
end)

RegisterServerEvent('vehicleshop.requestInfo')
AddEventHandler('vehicleshop.requestInfo', function()
    local ply = ESX.GetPlayerFromId(source)
    TriggerClientEvent('vehicleshop.vehiclesInfos', ply.PlayerData.source, vehicletable)
    TriggerClientEvent('vehicleshop.receiveInfo', ply.PlayerData.source, ply.PlayerData.money.bank, ply.PlayerData.charinfo.firstname)
end)

RegisterServerEvent('vehicleshop.CheckMoneyForVeh')
AddEventHandler('vehicleshop.CheckMoneyForVeh', function(modelcar, sale, name, vehicleProps)
    local user = ESX.GetPlayerFromId(source)
    if user.Functions.RemoveMoney('cash', sale) then 
        exports['ghmattimysql']:execute('SELECT stock FROM vehicles WHERE model = @model', {
            ['@model'] = modelcar
        }, function(result)
            if result[1].stock ~= nil then
                if result[1].stock >= 1 then
                    local kalan = result[1].stock - 1
                    -- exports['ghmattimysql']:execute('UPDATE vehicles SET stock = @stock WHERE model = @model', {
                    --     ['@model'] = modelcar
                    --     ['@stock'] = kalan
                    -- })

                    exports.ghmattimysql:execute('INSERT INTO owned_vehicles (owner, plate, vehicle, stored) VALUES (@owner, @plate, @vehicle, @stored)', {
                        ['@owner']   = user.PlayerData.citizenid,
                        ['@plate']   = vehicleProps.plate,
                        ['@vehicle'] = json.encode({model = GetHashKey(modelcar), plate = vehicleProps.plate}),
                        ['stored']   = 0
                    }, function(rowsChanged)
                        exports['ghmattimysql']:execute('UPDATE vehicles SET stock = @stock WHERE model = @model', {
                            ['@model'] = modelcar,
                            ['@stock'] = kalan
                        })

                        TriggerClientEvent('vehicleshop.basarili', user.PlayerData.source, name, vehicleProps.plate, sale)
                        TriggerClientEvent('vehicleshop.spawnVehicle', user.PlayerData.source, modelcar, vehicleProps.plate)
                    end)
                end
            else
                exports.ghmattimysql:execute('INSERT INTO owned_vehicles (owner, plate, vehicle, stored) VALUES (@owner, @plate, @vehicle, @stored)', {
                    ['@owner']   = user.PlayerData.citizenid,
                    ['@plate']   = vehicleProps.plate,
                    ['@vehicle'] = json.encode({model = GetHashKey(model), plate = vehicleProps.plate}),
                    ['stored']   = 0
                }, function(rowsChanged)

                    TriggerClientEvent('vehicleshop.basarili', user.PlayerData.source, name, vehicleProps.plate, sale)
                    TriggerClientEvent('vehicleshop.spawnVehicle', user.PlayerData.source, modelcar, vehicleProps.plate)
                end)
            end
        end)
    elseif user.Functions.RemoveMoney('bank', sale) then 
        exports['ghmattimysql']:execute('SELECT stock FROM vehicles WHERE model = @model', {
            ['@model'] = modelcar
        }, function(result)
            if result[1].stock ~= nil then
                if result[1].stock >= 1 then
                    local kalan = result[1].stock - 1
                    -- exports['ghmattimysql']:execute('UPDATE vehicles SET stock = @stock WHERE model = @model', {
                    --     ['@model'] = modelcar
                    --     ['@stock'] = kalan
                    -- })

                    exports.ghmattimysql:execute('INSERT INTO owned_vehicles (owner, plate, vehicle, stored) VALUES (@owner, @plate, @vehicle, @stored)', {
                        ['@owner']   = user.PlayerData.citizenid,
                        ['@plate']   = vehicleProps.plate,
                        ['@vehicle'] = json.encode({model = GetHashKey(modelcar), plate = vehicleProps.plate}),
                        ['stored']   = 0
                    }, function(rowsChanged)
                        exports['ghmattimysql']:execute('UPDATE vehicles SET stock = @stock WHERE model = @model', {
                            ['@model'] = modelcar,
                            ['@stock'] = kalan
                        })
                        TriggerClientEvent('vehicleshop.basarili', user.PlayerData.source, name, vehicleProps.plate, sale)
                        TriggerClientEvent('vehicleshop.spawnVehicle', user.PlayerData.source, modelcar, vehicleProps.plate)
                    end)
                end
            else
                exports.ghmattimysql:execute('INSERT INTO owned_vehicles (owner, plate, vehicle, stored) VALUES (@owner, @plate, @vehicle, @stored)', {
                    ['@owner']   = user.PlayerData.citizenid,
                    ['@plate']   = vehicleProps.plate,
                    ['@vehicle'] = json.encode({model = GetHashKey(modelcar), plate = vehicleProps.plate}),
                    ['stored']   = 0
                }, function(rowsChanged)
                    TriggerClientEvent('vehicleshop.basarili', user.PlayerData.source, name, vehicleProps.plate, sale)
                    TriggerClientEvent('vehicleshop.spawnVehicle', user.PlayerData.source, modelcar, vehicleProps.plate)
                end)
            end
        end)
    else
        TriggerClientEvent('vehicleshop.notify', user.PlayerData.source, 'notify', 'Yeteri kadar paran yok.')
    end
end)

ESX.RegisterServerCallback('vehicleshop-plaka-cek', function(source, cb, plate)
	exports.ghmattimysql:execute('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)