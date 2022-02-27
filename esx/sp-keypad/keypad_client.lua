local location = 0

function openGui()
    SetNuiFocus(true,true)
    SendNUIMessage({open = true})
end

function CloseGui()
    SetNuiFocus(false,false)
    SendNUIMessage({close = true})
end

RegisterNUICallback('close', function(data, cb)
  CloseGui()
  cb('ok')
end)

RegisterNUICallback('complete', function(data, cb)
  TriggerEvent("loaf_housing:eve-isinlan", location, data.pin)
  print('sikiş')
  CloseGui()
  cb('ok')
end)

RegisterNetEvent('trap:attempt')
AddEventHandler('trap:attempt', function(num)
    location = num
    openGui()
end)

