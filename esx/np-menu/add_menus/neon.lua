local isOn	=	false


RegisterCommand("neonai", function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= nil and veh ~= 0 and veh ~= 1 then
		--left
        if isOn then
            SetVehicleNeonLightEnabled(veh, 0, false)
            SetVehicleNeonLightEnabled(veh, 1, false)
            SetVehicleNeonLightEnabled(veh, 2, false)
            SetVehicleNeonLightEnabled(veh, 3, false)
			
            isOn = false
            exports['mythic_notify']:SendAlert('error', 'Neonlar kapandı!', 6000)
        else
            SetVehicleNeonLightEnabled(veh, 0, true)
            SetVehicleNeonLightEnabled(veh, 1, true)
            SetVehicleNeonLightEnabled(veh, 2, true)
            SetVehicleNeonLightEnabled(veh, 3, true)
			
            isOn = true
            exports['mythic_notify']:SendAlert('inform', 'Neonlar açıldı!', 6000)
        end
    end
end, false)

RegisterCommand("neonaikaire", function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= nil and veh ~= 0 and veh ~= 1 then
		--left
        if IsVehicleNeonLightEnabled(veh, 0) then
            SetVehicleNeonLightEnabled(veh, 0, false)
            exports['mythic_notify']:SendAlert('error', 'Sol neon kapandı!', 6000)
        else
            SetVehicleNeonLightEnabled(veh, 0, true)
			
            isOn = true
            exports['mythic_notify']:SendAlert('inform', 'Sol neon açıldı!', 6000)
        end
    end
end, false)

RegisterCommand("neonaidesine", function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= nil and veh ~= 0 and veh ~= 1 then
		--right
        if IsVehicleNeonLightEnabled(veh, 1) then
            SetVehicleNeonLightEnabled(veh, 1, false)
            exports['mythic_notify']:SendAlert('error', 'Sağ neon kapandı!', 6000)
        else
            SetVehicleNeonLightEnabled(veh, 1, true)
			
            isOn = true
            exports['mythic_notify']:SendAlert('inform', 'Sağ neon açıldı!', 6000)
        end
    end
end, false)

RegisterCommand("neonaipriekis", function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= nil and veh ~= 0 and veh ~= 1 then
		--front
        if IsVehicleNeonLightEnabled(veh, 2) then
            SetVehicleNeonLightEnabled(veh, 2, false)
            exports['mythic_notify']:SendAlert('error', 'Ön neon kapandı!', 6000)
        else
            SetVehicleNeonLightEnabled(veh, 2, true)
			
            isOn = true
            exports['mythic_notify']:SendAlert('inform', 'Ön neon açıldı!', 6000)
        end
    end
end, false)

RegisterCommand("neonaigalas", function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh ~= nil and veh ~= 0 and veh ~= 1 then
		--back
        if IsVehicleNeonLightEnabled(veh, 3) then
            SetVehicleNeonLightEnabled(veh, 3, false)
            exports['mythic_notify']:SendAlert('error', 'Arka neon kapandı!', 6000)
        else
            SetVehicleNeonLightEnabled(veh, 3, true)
			
            isOn = true
            exports['mythic_notify']:SendAlert('inform', 'Arka neon açıldı!', 6000)
        end
    end
end, false)

Citizen.CreateThread(function()
	TriggerEvent('chat:addSuggestion', "/neonai", "turn neons on/off or try /neonaipriekis etc")
end)