ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('3ddo:shareDisplay')
AddEventHandler('3ddo:shareDisplay', function(text,name, message)
    TriggerClientEvent('3ddo:triggerDisplay', -1, text, source)
end)
RegisterServerEvent('3ddo:chat')
AddEventHandler('3ddo:chat', function(text,name, message)
    TriggerClientEvent('3ddo:chatyaz', -1, text, source)
end)
 RegisterServerEvent('3ddo:chatme')
 AddEventHandler('3ddo:chatme', function(text,name, message)
     local src = source
     local suggestions = {}
     local source = tonumber(source)
     if player ~= false then
         local user = GetPlayerName(src)
         GetRPName(source, function(Firstname, Lastname)
             TriggerClientEvent('chat:addMessage', -1, {
             template = '<div class="chat-message system"><b>'.. Firstname.. ' ' .. Lastname.. ': '.. text.. '</b></div>',
             args = { user, text }
         })
     end)
     end
 end, false)

 ESX.RegisterServerCallback('jeux:sex', function(playerId, data) -- super
    local Identifier = ESX.GetPlayerFromId(playerId).identifier

    MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

        data(result[1].firstname, result[1].lastname)
    end)
end)

