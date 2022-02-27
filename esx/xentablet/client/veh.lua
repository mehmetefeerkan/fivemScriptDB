--====================================================================================
-- #XenKnighT
--====================================================================================



RegisterNetEvent("xentablet:veh_getBuy")
AddEventHandler("xentablet:veh_getBuy", function(vehbuyy)
  SendNUIMessage({event = 'veh_Buy', vehbuyy = vehbuyy})
end)

RegisterNUICallback('veh_getBuy', function(data, cb)
  TriggerServerEvent('xentablet:veh_getBuy', data.name, data.model, data.price, data.category, data.imglink)
end)







