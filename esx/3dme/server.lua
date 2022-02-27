ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text,name, message)
    TriggerClientEvent('3dme:triggerDisplay', -1, text, source)
end)
RegisterServerEvent('3dme:chat')
AddEventHandler('3dme:chat', function(text,name, message)
    TriggerClientEvent('3dme:chatyaz', -1, text, source)
end)


 ESX.RegisterServerCallback('jeux:sex', function(playerId, data) -- super
    local Identifier = ESX.GetPlayerFromId(playerId).identifier

    MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

        data(result[1].firstname, result[1].lastname)
    end)
end)

