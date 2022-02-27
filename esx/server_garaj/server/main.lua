ESX = nil

local cachedData = {}

TriggerEvent("esx:getSharedObject", function(library) 
    ESX = library 
end)


ESX.RegisterServerCallback("betrayed_garage:obtenerVehiculos", function(source, callback, garage)
    local player = ESX.GetPlayerFromId(source)

    if player then
        local sqlQuery = [[
            SELECT
                plate, vehicle
            FROM
                owned_vehicles
            WHERE
                owner = @cid
        ]]

        if garage then
            sqlQuery = [[
                SELECT
                    plate, vehicle
                FROM
                    owned_vehicles
                WHERE
                    owner = @cid
            ]]
        end

        MySQL.Async.fetchAll(sqlQuery, {
            ["@cid"] = player["identifier"],
            ["@garage"] = garage
        }, function(responses)
            --[[ for c,v in pairs(responses) do
                print(v.plate)
            end ]]
            getPlayerVehiclesOut(player.identifier ,function(data)
                enviar = {responses,data}
                callback(enviar)
            end)
        end)
    else
        callback(false)
    end
end)

function getPlayerVehiclesOut(identifier,cb)
    local vehicles = {}
    local data = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier",{['@identifier'] = identifier})
    cb(data)
end

ESX.RegisterServerCallback("betrayed_garage:validateVehicle", function(source, callback, vehicleProps, garage)
    local player = ESX.GetPlayerFromId(source)

    if player then
        local sqlQuery = [[
            SELECT
                owner
            FROM
                owned_vehicles
            WHERE
                plate = @plate
        ]]

        MySQL.Async.fetchAll(sqlQuery, {
            ["@plate"] = vehicleProps["plate"]
        }, function(responses)
            if responses[1] then
                callback(true)
            else
                callback(false)
            end
        end)
    else
        callback(false)
    end
end)

ESX.RegisterServerCallback('betrayed_garage:checkMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local deudas = 0
    local result = MySQL.Sync.fetchAll('SELECT * FROM billing WHERE identifier = @identifier',{['@identifier'] = xPlayer.identifier})
    for i=1, #result, 1 do
        amount = result[i].amount
        deudas = deudas + amount
    end
    if deudas >= 2000 then
        cb("deudas")
        return
    end
    if xPlayer.get('money') >= 200 then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('betrayed_garage:pay')
AddEventHandler('betrayed_garage:pay', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeMoney(200)
end)

RegisterServerEvent('betrayed_garage:modifystate')
AddEventHandler('betrayed_garage:modifystate', function(vehicleProps, state, garage)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local plate = vehicleProps.plate

    if garage == nil then
        MySQL.Sync.execute("UPDATE owned_vehicles SET garage=@garage WHERE plate=@plate",{['@garage'] = "OUT" , ['@plate'] = plate})
        MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle=@vehicle WHERE plate=@plate",{['@vehicle'] = json.encode(vehicleProps) , ['@plate'] = plate})
        MySQL.Sync.execute("UPDATE owned_vehicles SET state=@state WHERE plate=@plate",{['@state'] = state , ['@plate'] = plate})
    else 

        MySQL.Sync.execute("UPDATE owned_vehicles SET garage=@garage WHERE plate=@plate",{['@garage'] = garage , ['@plate'] = plate})
        MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle=@vehicle WHERE plate=@plate",{['@vehicle'] = json.encode(vehicleProps) , ['@plate'] = plate})
        MySQL.Sync.execute("UPDATE owned_vehicles SET state=@state WHERE plate=@plate",{['@state'] = state , ['@plate'] = plate})

    end
end)

RegisterServerEvent('betrayed_garage:modifyHouse')
AddEventHandler('betrayed_garage:modifyHouse', function(vehicleProps)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local plate = vehicleProps.plate
    --print(json.encode(plate))

    --MySQL.Sync.execute("UPDATE owned_vehicles SET garage=@garage WHERE plate=@plate",{['@garage'] = garage , ['@plate'] = plate})
    MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle=@vehicle WHERE plate=@plate",{['@vehicle'] = json.encode(vehicleProps) , ['@plate'] = plate})


end)

RegisterServerEvent("betrayed_garage:sacarometer")
AddEventHandler("betrayed_garage:sacarometer", function(vehicle,state,src1)
    local src = source
    if src1 then
        src = src1
    end
    local xPlayer = ESX.GetPlayerFromId(src)
    while xPlayer == nil do Citizen.Wait(1); end
    local plate = all_trim(vehicle)
    local state = state
    MySQL.Sync.execute("UPDATE owned_vehicles SET state =@state WHERE plate=@plate",{['@state'] = state , ['@plate'] = plate})
end)

function all_trim(s)
    return s:match( "^%s*(.-)%s*$" )
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
  end

 RegisterNetEvent("garages:CheckGarageForVeh")
AddEventHandler("garages:CheckGarageForVeh", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.identifier
    
    --print(identifier)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier', { ['@identifier'] = identifier }, function(vehicles)
        TriggerClientEvent('phone:Garage', src, vehicles)
    end)
end)