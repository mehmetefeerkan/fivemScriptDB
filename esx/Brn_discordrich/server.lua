local ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

Citizen.CreateThread(function()
while ESX == nil do
        Citizen.Wait(200)
    end
end)

ESX.RegisterServerCallback("getplayer", function(source,cb)
    local xPlayer = ESX.GetPlayerFromId(source)    
    if xPlayer == nil then
        print('Karakter Bulunamadı.')
    else
    local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    })

    local a = result[1].firstname
    local b = result[1].lastname
    local c = ESX.GetPlayers()


    cb(a, b, c)
    end
end)