ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('ali:getEms', function(source, cb, store)
    local ems = 0
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'ambulance' then
            ems = ems + 1
        end
    end
    
    if ems <= Config.maxDoctor then
        cb(true)
    else
        cb('no_ems')
    end

end)


RegisterServerEvent('ali-npcdoctor:money')
AddEventHandler('ali-npcdoctor:money', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeMoney(Config.doctorPrice)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '$'.. Config.doctorPrice ..' karşılığında yerli doktora tedavi oldun'})

end)

ESX.RegisterServerCallback('ali-npcdoctor:parakontrol', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(xPlayer.getMoney() >= Config.doctorPrice)
end)