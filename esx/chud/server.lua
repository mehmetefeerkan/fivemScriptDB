ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
ESX.RegisterServerCallback("dd_carkey:fetchCarKey", function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local vehicles = {}
    if xPlayer then
        MySQL.Async.fetchAll('SELECT * FROM users_cars WHERE plate=@plate AND owner=@identifier',{ ['@plate'] = plate, ['@identifier'] = xPlayer.getIdentifier()}, function(data)
            local KeyFound = false
            if data[1] ~= nil then
                    if xPlayer.identifier == data[1].owner then
                            KeyFound = true
                    end
            end
            if KeyFound then
                    cb(true)
            else
                    cb(false)
            end
        end)
    end
end)