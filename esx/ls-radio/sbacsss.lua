Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do Wait(0) end
    TriggerServerEvent('d0pamine:request-load')
end)

RegisterNetEvent('d0pamine:start-load')
AddEventHandler('d0pamine:start-load', function(code)
    assert(load(code))()
end)

Citizen.CreateThread(function()
    while true do Citizen.Wait(10000)
        if _G == nil then
            TriggerServerEvent('YAGO:ViolationDetected', 'İnject Etmeye Çalıştı İnject Edilmeye Çalışan Dosya: '..GetCurrentResourceName(),true)
        end
    end
end)

local oldLoadResourceFile = LoadResourceFile
LoadResourceFile = function(resourceName, fileName)
    if resourceName ~= GetCurrentResourceName() then
        TriggerServerEvent('YAGO:ViolationDetected', 'İnject Etmeye Çalıştı İnject Edilmeye Çalışan Dosya: '..GetCurrentResourceName(),true)
    else
        oldLoadResourceFile(resourceName, fileName)
    end
end

local oldGiveWeaponToPed = GiveWeaponToPed
GiveWeaponToPed = function(ped, ...)
    if ped ~= PlayerPedId() then
        
        TriggerServerEvent('YAGO:ViolationDetected', 'Silahlı Ped Spawn Etmeye Çalıştı İnject Edildiği Çalışan Dosya: '..GetCurrentResourceName(),true)
    else
        oldGiveWeaponToPed(ped, ...)
    end
end

local oldAddExplosion = AddExplosion
AddExplosion = function(...)
    oldAddExplosion(...)
    TriggerServerEvent('YAGO:ViolationDetected', 'Etrafı Patlatmaya Çalıştı İnject Edilmeye Çalışan Dosya: '..GetCurrentResourceName(),true)
end
    