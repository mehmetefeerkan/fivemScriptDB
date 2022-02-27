ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('sup-duty:onduty')
AddEventHandler('sup-duty:onduty', function(job)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == 'offpolice' then
        xPlayer.setJob('police')
    elseif xPlayer.job.name == 'offambulance' then
        xPlayer.setJob('ambulance')
    end
end)

RegisterServerEvent('sup-duty:offduty')
AddEventHandler('sup-duty:offduty', function(job)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == 'police' then
        xPlayer.setJob('offpolice')
    elseif xPlayer.job.name == 'ambulance' then
        xPlayer.setJob('offambulance')
    end
end)