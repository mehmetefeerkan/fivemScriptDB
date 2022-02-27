QBCore = nil

TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)

RegisterServerEvent('nv:selector:show', function()

    local src = source

    xPlayer = QBCore.Functions.GetPlayer(src)

    Data = {}

    Data.position = xPlayer.PlayerData.position

    Data.jail = false

    Data.job = xPlayer.PlayerData.job.name

    TriggerClientEvent('nv:selector:show', src, Data)

end)