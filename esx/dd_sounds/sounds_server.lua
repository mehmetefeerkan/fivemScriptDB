RegisterServerEvent('dd_sound_sv:PlayOnOne')
AddEventHandler('dd_sound_sv:PlayOnOne', function(clientNetId, soundFile, soundVolume)
    TriggerClientEvent('dd_sound_cl:PlayOnOne', clientNetId, soundFile, soundVolume)
end)

RegisterServerEvent('dd_sound_sv:PlayOnSource')
AddEventHandler('dd_sound_sv:PlayOnSource', function(soundFile, soundVolume)
    TriggerClientEvent('dd_sound_cl:PlayOnOne', source, soundFile, soundVolume)
end)

RegisterServerEvent('dd_sound_sv:PlayOnAll')
AddEventHandler('dd_sound_sv:PlayOnAll', function(soundFile, soundVolume)
    TriggerClientEvent('dd_sound_cl:PlayOnAll', -1, soundFile, soundVolume)
end)

RegisterServerEvent('dd_sound_sv:PlayWithinDistance')
AddEventHandler('dd_sound_sv:PlayWithinDistance', function(maxDistance, soundFile, soundVolume)
    TriggerClientEvent('dd_sound_cl:PlayWithinDistance', -1, source, maxDistance, soundFile, soundVolume)
end)
