ESX = nil
PlayerData = {}
soygun = false
ara1 = false
ara2 = false
ara3 = false
ara4 = false
ara5 = false
ara6 = false
ara7 = false
ara8 = false
ara9 = false
soygun1 = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)



local arananyerler1 = {
    [1] = {x = 311.54, y = -279.69, z = 54.16, info = 'Motel Karşısı'},
    [2] = {x = 148.08, y = -1041.64, z = 29.37, info = 'Kamu Karşısı'},
    [3] = {x = -2961.09, y = 481.38, z = 15.7, info = 'Sahil'},
    [4] = {x = -352.82, y = -50.78, z = 49.04, info = 'Mekanik Üstü'},
    [5] = {x = 1176.53, y = 2708.31, z = 38.09, info = 'Orta Kasaba'},
    [6] = {x = -1213.29, y = -332.64, z = 37.78, info = 'Kimyacı Sağı'},
}

local arananyerler2 = {
    [1] = {x = 312.97, y = -280.23, z = 54.16, info = 'Motel Karşısı'},
    [2] = {x = 149.46, y = -1042.07, z = 29.37, info = 'Kamu Karşısı'},
    [3] = {x = -2961.09, y = 482.99, z = 15.7, info = 'Sahil'},
    [4] = {x = -351.34, y = -51.26, z = 49.04, info = 'Mekanik Üstü'},
    [5] = {x = 1174.96, y = 2708.26, z = 38.09, info = 'Orta Kasaba'},
    [6] = {x = -1211.9, y = -331.9, z = 37.78, info = 'Kimyacı Sağı'},
}

local arananyerler3 = {
    [1] = {x = 314.93, y = -280.95 , z = 54.16, info = 'Motel Karşısı'},
    [2] = {x = 151.02, y = -1042.63, z = 29.37, info = 'Kamu Karşısı'},
    [3] = {x = -2961.07, y = 484.44, z = 15.7, info = 'Sahil'},
    [4] = {x = -349.92, y = -51.8, z = 49.04, info = 'Mekanik Üstü'},
    [5] = {x = 1173.45, y = 2708.21, z = 38.09, info = 'Orta Kasaba'},
    [6] = {x = -1210.58, y = -331.27, z = 37.78, info = 'Kimyacı Sağı'},
}

local kapicoords = {
    [1] = {x = 309.56, y = -279.52, z = 54.16, info = 'Motel Karşısı'},
    [2] = {x = 145.16, y = -1041.16, z = 29.37, info = 'Kamu Karşısı'},
    [3] = {x = -2960.73, y = 478.68, z = 15.7, info = 'Sahil'},
    [4] = {x = -355.5, y = -50.52, z = 49.04, info = 'Mekanik Üstü'},
    [5] = {x = 1179.17, y = 2708.89, z = 38.09, info = 'Orta Kasaba'},
    [6] = {x = -1215.38, y = -334.43, z = 37.78, info = 'Kimyacı Sağı'},
}

local arkakasadolaplar1 = {
    [1] = {x = 314.04, y = -283.65, z = 54.14, info = 'Motel Karşısı'},
    [2] = {x = 149.69, y = -1044.91, z = 29.35, info = 'Kamu Karşısı'},
    [3] = {x = -2958.18, y = 484.15, z = 15.68, info = 'Sahil'},
    [4] = {x = -350.89, y = -54.09, z = 49.01, info = 'Mekanik Üstü'},
    [5] = {x = 1173.7, y = 2710.73, z = 38.07, info = 'Orta Kasaba'},
    [6] = {x = -1209.7, y = -333.61, z = 37.76, info = 'Kimyacı Sağı'},
}

local arkakasadolaplar2 = {
    [1] = {x = 315.01, y = -284.92, z = 54.14, info = 'Motel Karşısı'},
    [2] = {x = 150.74, y = -1046.08, z = 29.35, info = 'Kamu Karşısı'},
    [3] = {x = -2957.39, y = 485.61, z = 15.7, info = 'Sahil'},
    [4] = {x = -349.57, y = -55.89, z = 49.01, info = 'Mekanik Üstü'},
    [5] = {x = 1171.78, y = 2711.87, z = 38.07, info = 'Orta Kasaba'},
    [6] = {x = -1207.44, y = -333.78, z = 37.76, info = 'Kimyacı Sağı'},
}

local arkakasadolaplar3 = {
    [1] = {x = 314.75, y = -288.1, z = 54.14, info = 'Motel Karşısı'},
    [2] = {x = 150.04, y = -1049.7, z = 29.35, info = 'Kamu Karşısı'},
    [3] = {x = -2953.9, y = 486.08, z = 15.7, info = 'Sahil'},
    [4] = {x = -350.09, y = -59.14, z = 49.01, info = 'Mekanik Üstü'},
    [5] = {x = 1171.24, y = 2715.22, z = 38.07, info = 'Orta Kasaba'},
    [6] = {x = -1205.43, y = -336.49, z = 37.76, info = 'Kimyacı Sağı'},
}

local arkakasadolaplar4 = {
    [1] = {x = 312.6, y = -288.67, z = 54.14, info = 'Motel Karşısı'},
    [2] = {x = 148.31, y = -1050.27, z = 29.35, info = 'Kamu Karşısı'},
    [3] = {x = -2952.71, y = 484.35, z = 15.7, info = 'Sahil'},
    [4] = {x = -352.63, y = -59.03, z = 49.01, info = 'Mekanik Üstü'},
    [5] = {x = 1173.31, y = 2716.81, z = 38.07, info = 'Orta Kasaba'},
    [6] = {x = -1206.57, y = -338.89, z = 37.76, info = 'Kimyacı Sağı'},
}

local arkakasadolaplar5 = {
    [1] = {x = 311.54, y = -287.13, z = 54.14, info = 'Motel Karşısı'},
    [2] = {x = 147.16, y = -1048.71, z = 29.35, info = 'Kamu Karşısı'},
    [3] = {x = -2954.02, y = 482.52, z = 15.7, info = 'Sahil'},
    [4] = {x = -353.9, y = -57.72, z = 49.01, info = 'Mekanik Üstü'},
    [5] = {x = 1175.22, y = 2715.19, z = 38.07, info = 'Orta Kasaba'},
    [6] = {x = -1209.07, y = -338.3, z = 37.76, info = 'Kimyacı Sağı'},
}

local kasakapicoords = {
    [1] = {x = 312.28, y = -283.58, z = 54.16, info = 'Motel Karşısı'},
    [2] = {x = 147.89, y = -1045.19, z = 29.37, info = 'Kamu Karşısı'},
    [3] = {x = -2957.66, y = 482.34, z = 15.7, info = 'Sahil'},
    [4] = {x = -352.97, y = -54.32, z = 49.04, info = 'Mekanik Üstü'},
    [5] = {x = 1175.41, y = 2711.56, z = 38.09, info = 'Orta Kasaba'},
    [6] = {x = -1210.93, y = -335.18, z = 37.78, info = 'Kimyacı Sağı'},
}

local kasapanelcoords = {
    [1] = {x = 311.26, y = -284.52, z = 54.16, info = 'Motel Karşısı'},
    [2] = {x = 146.93, y = -1046.15, z = 29.37, info = 'Kamu Karşısı'},
    [3] = {x = -2956.47, y = 481.78, z = 15.7, info = 'Sahil'},
    [4] = {x = -353.86, y = -55.38, z = 49.04, info = 'Mekanik Üstü'},
    [5] = {x = 1175.95, y = 2712.95, z = 38.09, info = 'Orta Kasaba'},
    [6] = {x = -1210.72, y = -336.57, z = 37.78, info = 'Kimyacı Sağı'},
}


function DrawText3D(x,y,z,text,size)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35,0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 100)
end

RegisterNetEvent('raidervezne:cashieropendoor')
AddEventHandler('raidervezne:cashieropendoor', function()
    while true do
    Citizen.Wait(0)
    local playerPed = PlayerPedId()    
        for k,v in pairs(arananyerler1) do
            if Vdist2(GetEntityCoords(playerPed, false), v.x, v.y, v.z) < 1.5 then
                if soygun == true then
                    if ara1 == false then 
                        DrawText3D(v.x, v.y, v.z, '[H] Ara')
                        if IsControlJustPressed(0, 74) then
                            TriggerEvent('lsrp-lockpick:StartLockpickfo', function(outcome)
                                if outcome then
                                    TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
                                    exports["t0sic_loadingbar"]:StartDelayedFunction("Arıyorsun", 8300, function()
                                        ClearPedTasks(playerPed) 
                                        TriggerServerEvent('raidervezne:parakazan')
                                        TriggerEvent('raidervezne:cashieropendoor1')
                                        ara1 = true
                                    end)
                                else  
                                    -- exports['mythic_notify']:SendAlert('error', 'Kilidi açamadın, tekrar dene') 
                                    TriggerEvent('notification', 'Kilidi açamadın, tekrar dene', 2)   
                                end
                            end)
                        end
                    end 
                end
            end
        end
    end
end)


AddEventHandler('raidervezne:cashieropendoor1', function()
    while true do
    Citizen.Wait(0)
    local playerPed = PlayerPedId()
        for a,b in pairs(arananyerler2) do 
            if Vdist2(GetEntityCoords(playerPed, false), b.x, b.y, b.z) < 1.5 then
                if ara1 == true then
                    if ara2 == false then 
                        DrawText3D(b.x, b.y, b.z, '[H] Ara')
                        if IsControlJustPressed(0, 74) then
                            TriggerEvent('lsrp-lockpick:StartLockpickfo', function(outcome)
                                if outcome then
                                    TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
                                    exports["t0sic_loadingbar"]:StartDelayedFunction("Arıyorsun", 8300, function()
                                    ClearPedTasks(playerPed)
                                    TriggerServerEvent('raidervezne:parakazan')
                                    TriggerEvent('raidervezne:cashieropendoor2')
                                    ara2 = true
                                    end)
                                else  
                                    -- exports['mythic_notify']:SendAlert('error', 'Kilidi açamadın, tekrar dene') 
                                    TriggerEvent('notification', 'Kilidi açamadın, tekrar dene', 2)    
                                end
                            end)
                        end
                    end
                end
            end
        end
    end 
end)

AddEventHandler('raidervezne:cashieropendoor2', function()
    while true do
    Citizen.Wait(0)
    local playerPed = PlayerPedId()
        for c,d in pairs(arananyerler3) do 
            if Vdist2(GetEntityCoords(playerPed, false), d.x, d.y, d.z) < 1.5 then
                if ara2 == true then
                    if ara3 == false then 
                        DrawText3D(d.x, d.y, d.z, '[H] Ara')
                        if IsControlJustPressed(0, 74) then
                            TriggerEvent('lsrp-lockpick:StartLockpickfo', function(outcome)
                                if outcome then
									TriggerServerEvent('lockpick:sil')
                                    TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
                                    exports["t0sic_loadingbar"]:StartDelayedFunction("Arıyorsun", 8300, function()
                                        ClearPedTasks(playerPed)
                                        TriggerServerEvent('raidervezne:parakazan')
                                        TriggerEvent('raidervezne:cashieropendoor3')
                                        ara3 = true
                                    end)
                                else  
                                    -- exports['mythic_notify']:SendAlert('error', 'Kilidi açamadın, tekrar dene') 
                                    TriggerEvent('notification', 'Kilidi açamadın, tekrar dene', 2) 
                                end
                            end)
                        end
                    end
                end
            end
        end
    end
end)
    
AddEventHandler('raidervezne:cashieropendoor3', function()
    while true do
    Citizen.Wait(0)
    local playerPed = PlayerPedId()
        for e,f in pairs(kasapanelcoords) do 
            if Vdist2(GetEntityCoords(playerPed, false), f.x, f.y, f.z) < 1.5 then
                if ara3 == true then
                    if ara4 == false then 
                        DrawText3D(f.x, f.y, f.z, '[E] Güvenlik kartını kullan')
                        if IsControlJustPressed(0, 38) then
                            ESX.TriggerServerCallback('raider:getItemAmount', function(quantity)
                                if quantity >= 1 then
                                    TriggerEvent("dooranims")
                                    exports["t0sic_loadingbar"]:StartDelayedFunction("Kart okunuyor", 5000, function()
                                        TriggerServerEvent('raider:kasaac')
                                        TriggerServerEvent('kart:sil')
                                        TriggerEvent('raidervezne:cashieropendoor4') 
                                        ara4 = true
                                    end)
                                else  
                                    -- exports['mythic_notify']:SendAlert('error', 'Güvenlik kartın yok!') 
                                    TriggerEvent('notification', 'Güvenlik kartın yok!', 2) 
                                end
                            end, 'securitycard')
                        end
                    end
               end
            end
        end
    end
end)

AddEventHandler('raidervezne:cashieropendoor4', function()
    while true do
    Citizen.Wait(0)
    local playerPed = PlayerPedId()
        for g,h in pairs(arkakasadolaplar1) do 
            if Vdist2(GetEntityCoords(playerPed, false), h.x, h.y, h.z) < 1.5 then
                if ara4 == true then
                    if ara5 == false then 
                        DrawText3D(h.x, h.y, h.z, '[E] Ara')
                        if IsControlJustPressed(0, 38) then
                            ESX.TriggerServerCallback('raider:getItemAmount', function(quantity)
                            if quantity >= 1 then
                                DrillStartFunction()
                                TriggerEvent("Drilling:Start",function(success)
                                    if (success) then
                                        SafeDrillStopEvent()
                                        ClearPedTasks(playerPed)
                                        TriggerServerEvent('raiderkasa:parakazan')
                                        TriggerEvent('raidervezne:cashieropendoor5')
                                        ara5 = true
                                    else
                                        SafeDrillStopEvent()  
                                        -- exports['mythic_notify']:SendAlert('error', 'Kilidi açamadın, tekrar dene') 
                                        TriggerEvent('notification', 'Kilidi açamadın, tekrar dene', 2)
                                    end
                                end)
                            else
                                -- exports['mythic_notify']:SendAlert('error', 'Banka drillin yok!')
                                TriggerEvent('notification', 'Banka drillin yok!', 2) 
                            end
                        end, 'drillbank')
                        end
                    end
                end
            end
        end
    end
end)

AddEventHandler('raidervezne:cashieropendoor5', function()
    while true do
    Citizen.Wait(0)
    local playerPed = PlayerPedId()
        for j,k in pairs(arkakasadolaplar2) do 
            if Vdist2(GetEntityCoords(playerPed, false), k.x, k.y, k.z) < 1.5 then
                if ara5 == true then
                    if ara6 == false then 
                        DrawText3D(k.x, k.y, k.z, '[E] Ara')
                        if IsControlJustPressed(0, 38) then
                            ESX.TriggerServerCallback('raider:getItemAmount', function(quantity)
                            if quantity >= 1 then
                                DrillStartFunction()
                                TriggerEvent("Drilling:Start",function(success)
                                    if (success) then
                                        SafeDrillStopEvent()
                                        ClearPedTasks(playerPed)
                                        TriggerServerEvent('raiderkasa:parakazan')
                                        TriggerEvent('raidervezne:cashieropendoor6')
                                        ara6 = true
                                    else
                                        SafeDrillStopEvent()  
                                        -- exports['mythic_notify']:SendAlert('error', 'Kilidi açamadın, tekrar dene') 
                                        TriggerEvent('notification', 'Kilidi açamadın, tekrar dene', 2)
                                    end
                                end)
                            else
                                -- exports['mythic_notify']:SendAlert('error', 'Banka drillin yok!') 
                                TriggerEvent('notification', 'Banka drillin yok!', 2) 
                            end
                            end, 'drillbank')
                        end
                    end
                end
            end
        end
    end
end)

AddEventHandler('raidervezne:cashieropendoor6', function()
    while true do
    Citizen.Wait(0)
    local playerPed = PlayerPedId()
        for l,m in pairs(arkakasadolaplar3) do 
            if Vdist2(GetEntityCoords(playerPed, false), m.x, m.y, m.z) < 1.5 then
                if ara6 == true then
                    if ara7 == false then 
                        DrawText3D(m.x, m.y, m.z, '[E] Ara')
                        if IsControlJustPressed(0, 38) then
                            ESX.TriggerServerCallback('raider:getItemAmount', function(quantity)
                            if quantity >= 1 then
                                DrillStartFunction()
                                TriggerEvent("Drilling:Start",function(success)
                                    if (success) then
                                        SafeDrillStopEvent()
                                        ClearPedTasks(playerPed)
                                        TriggerServerEvent('raiderkasa:parakazan')
                                        TriggerEvent('raidervezne:cashieropendoor7')
                                        ara7 = true
                                    else
                                        SafeDrillStopEvent()  
                                        -- exports['mythic_notify']:SendAlert('error', 'Kilidi açamadın, tekrar dene') 
                                        TriggerEvent('notification', 'Kilidi açamadın, tekrar dene', 2)
                                    end
                                end)
                            else
                                -- exports['mythic_notify']:SendAlert('error', 'Banka drillin yok!') 
                                TriggerEvent('notification', 'Banka drillin yok!', 2) 
                            end
                            end, 'drillbank')
                        end
                    end
                end
            end
        end
    end
end)

AddEventHandler('raidervezne:cashieropendoor7', function()
    while true do
    Citizen.Wait(0)
    local playerPed = PlayerPedId()
        for n,o in pairs(arkakasadolaplar4) do 
            if Vdist2(GetEntityCoords(playerPed, false), o.x, o.y, o.z) < 1.5 then
                if ara7 == true then
                    if ara8 == false then 
                        DrawText3D(o.x, o.y, o.z, '[E] Ara')
                        if IsControlJustPressed(0, 38) then
                            ESX.TriggerServerCallback('raider:getItemAmount', function(quantity)
                            if quantity >= 1 then
                                DrillStartFunction()
                                TriggerEvent("Drilling:Start",function(success)
                                    if (success) then
                                        SafeDrillStopEvent()
                                        ClearPedTasks(playerPed)
                                        TriggerServerEvent('raiderkasa:parakazan')
                                        TriggerEvent('raidervezne:cashieropendoor8')
                                        ara8 = true
                                    else
                                        SafeDrillStopEvent()  
                                        -- exports['mythic_notify']:SendAlert('error', 'Kilidi açamadın, tekrar dene') 
                                        TriggerEvent('notification', 'Kilidi açamadın, tekrar dene', 2)
                                    end
                                end)
                            else
                                -- exports['mythic_notify']:SendAlert('error', 'Banka drillin yok!') 
                                TriggerEvent('notification', 'Banka drillin yok!', 2) 
                            end
                            end, 'drillbank')
                        end
                    end
                end
            end
        end
    end
end)

AddEventHandler('raidervezne:cashieropendoor8', function()
    while true do
    Citizen.Wait(0)
    local playerPed = PlayerPedId()
        for p,r in pairs(arkakasadolaplar5) do 
            if Vdist2(GetEntityCoords(playerPed, false), r.x, r.y, r.z) < 1.5 then
                if ara8 == true then
                    if ara9 == false then 
                        DrawText3D(r.x, r.y, r.z, '[E] Ara')
                        if IsControlJustPressed(0, 38) then
                            ESX.TriggerServerCallback('raider:getItemAmount', function(quantity)
                            if quantity >= 1 then
                                DrillStartFunction()
                                TriggerEvent("Drilling:Start",function(success)
                                    if (success) then
                                        SafeDrillStopEvent()
                                        ClearPedTasks(playerPed)
                                        TriggerServerEvent('raiderkasa:parakazan')
                                        TriggerServerEvent('drill:sil') 
                                        ara9 = true
                                    else
                                        SafeDrillStopEvent()  
                                        -- exports['mythic_notify']:SendAlert('error', 'Kilidi açamadın, tekrar dene') 
                                        TriggerEvent('notification', 'Kilidi açamadın, tekrar dene', 2)
                                    end
                                end)
                            else
                                -- exports['mythic_notify']:SendAlert('error', 'Banka drillin yok!') 
                                TriggerEvent('notification', 'Banka drillin yok!', 2) 
                            end
                            end, 'drillbank')
                        end
                    end
                end
            end
        end
    end
end)

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(5)
    end
end

AddEventHandler('lockpickAnimation', function()
    local playerPed = PlayerPedId()
    loadAnimDict('veh@break_in@0h@p_m_one@')
    TaskPlayAnim(playerPed, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)
    ClearPedTasks(playerPed)
end)

RegisterNetEvent( 'dooranims' )
AddEventHandler( 'dooranims', function()
    local playerPed = PlayerPedId()
    ClearPedSecondaryTask(playerPed)
    loadAnimDict( "anim@heists@keycard@" ) 
    TaskPlayAnim(playerPed, "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Citizen.Wait(50)
    ClearPedTasks(playerPed)
end)

Citizen.CreateThread(function()
    while true do 
        sleep = 2000
        local playerPed = PlayerPedId()
        for k,v in pairs(kapicoords) do
            if Vdist2(GetEntityCoords(playerPed, false), v.x, v.y, v.z) < 3.0 then
                sleep = 5
            end
            if Vdist2(GetEntityCoords(playerPed, false), v.x, v.y, v.z) < 1.5 and soygun1 == false then
                DrawText3D(v.x, v.y, v.z, '[E] ile kilidi zorla')
                if IsControlJustPressed(0, 38) then
                    if soygun1 == false then 
                        ESX.TriggerServerCallback('raider:getItemAmount', function(quantity)
                            if quantity >= 1 then
                                ESX.TriggerServerCallback('raider:policeCount', function(count)
                                    if count >= Config.PoliceCount then
                                        TriggerEvent('lsrp-lockpick:StartLockpickfo', function(outcome)
                                            if outcome then
                                                    TriggerEvent('police:veznerobbery')
                                                    loadAnimDict('veh@break_in@0h@p_m_one@')
                                                    TaskPlayAnim(playerPed, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)
                                                    FreezeEntityPosition(playerPed, true)
                                                    exports["t0sic_loadingbar"]:StartDelayedFunction("Kapıyı Açıyorsun", 5000, function()
                                                    TriggerServerEvent('raider:kapiac')
                                                    ClearPedTasks(playerPed)
                                                    FreezeEntityPosition(playerPed, false)
                                                    soygun = true
                                                    soygun1 = true
                                                    sure = 600000
                                                    -- exports['mythic_notify']:SendAlert('inform', 'Kapının kilidini açtın.')
                                                    TriggerEvent('notification', 'Kapının kilidini açtın.', 1) 
                                                    TriggerEvent('raidervezne:cashieropendoor')
                                                    end)
                                                else  
                                                    -- exports['mythic_notify']:SendAlert('error', 'Kilidi açamadın, tekrar dene')
                                                    TriggerEvent('notification', 'Kilidi açamadın, tekrar dene', 2) 
                                                end
                                        end)
                                    else 
                                        -- exports['mythic_notify']:SendAlert('error', 'Yeterince polis yok')
                                        TriggerEvent('notification', 'Yeterince polis yok', 2) 
                                    end
                                end)
                            else 
                                -- exports['mythic_notify']:SendAlert('error', 'Maymuncuğun yok!')
                                TriggerEvent('notification', 'Maymuncuğun yok!', 2) 
                            end
                        end, 'lockpick')
                    else
                        -- exports['mythic_notify']:SendAlert('error', 'Vezne kapalı!')
                        TriggerEvent('notification', 'Vezne kapalı!', 2) 
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterCommand('secure', function()
    if PlayerData.job.name == 'police' or  PlayerData.job.name == 'sheriff' then   
        exports["t0sic_loadingbar"]:StartDelayedFunction("Güvenlik sağlanıyor", 2000, function()
        soygun1 = false
    end)
    else
        -- exports['mythic_notify']:SendAlert('error', 'Bu komutu yalnızca polis/sheriff kullanabilir!')
        TriggerEvent('notification', 'Bu komutu yalnızca polis/sheriff kullanabilir!', 2)
    end
end)

RegisterNetEvent('raider:kapiac')
AddEventHandler('raider:kapiac', function()
    local playerPed = PlayerPedId()
    local coords		= GetEntityCoords(playerPed)

    for _, cashier in pairs(kapicoords) do

        local bankDoor = GetClosestObjectOfType(cashier.x, cashier.y, cashier.z, 1.0, 4163212883, 0, 0, 0)
        local distance = GetDistanceBetweenCoords(cashier.x, cashier.y, cashier.z, coords.x, coords.y, coords.z, true)
        local heading = GetEntityHeading(bankDoor)

        if distance < 0.75 then

            TriggerServerEvent('raider:kapiyiac', cashier.id)
            if heading >= 241.0 and heading <= 290.0 then
                SetEntityHeading(bankDoor, 150.0)
            elseif heading >= 120.0 and heading <= 240.0 then
                SetEntityHeading(bankDoor, 0.0)
            elseif heading >= 1.0 and heading <= 119.0 then
                SetEntityHeading(bankDoor, 350.0)
            elseif heading >= 291.0 and heading <= 360.0 then
                SetEntityHeading(bankDoor, 200.0)
            end
        end
    end
end)

RegisterNetEvent('raider:kasakapiac')
AddEventHandler('raider:kasakapiac', function()
    local playerPed		= PlayerPedId()
    local coords		= GetEntityCoords(playerPed)

    for x, cashiera in pairs(kasakapicoords) do

        local bankDoora = GetClosestObjectOfType(cashiera.x, cashiera.y, cashiera.z, 1.0, 2121050683, 0, 0, 0)
        local bankDoorb = GetClosestObjectOfType(cashiera.x, cashiera.y, cashiera.z, 1.0, -63539571, 0, 0, 0)
        local distancea = GetDistanceBetweenCoords(cashiera.x, cashiera.y, cashiera.z, coords.x, coords.y, coords.z, true)
        local heading = GetEntityHeading(bankDoora)
        local headinb = GetEntityHeading(bankDoorb)

        if distancea < 5.0 then

            TriggerServerEvent('raider:kasakapiyiac', cashiera.id)
            if heading >= 241.0 and heading <= 290.0 then
                SetEntityHeading(bankDoora, 150.0)
            elseif heading >= 120.0 and heading <= 240.0 then
                SetEntityHeading(bankDoora, 0.0)
            elseif heading >= 1.0 and heading <= 119.0 then
                SetEntityHeading(bankDoora, 350.0)
            elseif heading >= 291.0 and heading <= 360.0 then
                SetEntityHeading(bankDoora, 200.0)
            end

            if headinb >= 291.0 and headinb <= 360.0 then
                SetEntityHeading(bankDoorb, 260.0)
            end
        end
    end
end)

RegisterNetEvent('raider:sendBanking')
AddEventHandler('raider:sendBanking', function(banks)
    Config.Banks = banks
end)

function SafeDrillStopEvent()
    local playerPed = PlayerPedId()
	drillingClient = false
	ClearPedTasksImmediately(playerPed)
	StopSound(drillSound)
	ReleaseSoundId(drillSound)
	DeleteObject(attachedDrill)
    DeleteEntity(attachedDrill)
    FreezeEntityPosition(playerPed, false)
    StopParticleFxLooped(effect, 0)
    StopGameplayCamShaking(true)
	Citizen.Wait(200)				
	keyPressed2 = false
end

function DrillStartFunction()
    local playerPed = PlayerPedId()
    FreezeEntityPosition(playerPed, true)
	SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"),true)
	Citizen.Wait(100)
	local animDict = "anim@heists@fleeca_bank@drilling"
	local animLib = "drill_straight_idle"
			
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(50)
	end
			
	local drillProp = GetHashKey('hei_prop_heist_drill')
	local boneIndex = GetPedBoneIndex(playerPed, 28422)
			
	RequestModel(drillProp)
	while not HasModelLoaded(drillProp) do
		Citizen.Wait(100)
	end
			
	TaskPlayAnim(playerPed,animDict,animLib,1.0, -1.0, -1, 2, 0, 0, 0, 0)
			
	attachedDrill = CreateObject(drillProp, 1.0, 1.0, 1.0, 1, 1, 0)
	AttachEntityToEntity(attachedDrill, playerPed, boneIndex, 0.0, 0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
			
	SetEntityAsMissionEntity(attachedDrill, true, true)
			
	RequestAmbientAudioBank("DLC_HEIST_FLEECA_SOUNDSET", 0)
	RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL", 0)
	RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL_2", 0)
	drillSound = GetSoundId()
			
	Citizen.Wait(750)
					
	PlaySoundFromEntity(drillSound, "Drill", attachedDrill, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
			
	Citizen.Wait(200)
			
	local particleDictionary = "scr_fbi5a"
	local particleName = "scr_bio_grille_cutting"

	RequestNamedPtfxAsset(particleDictionary)
	while not HasNamedPtfxAssetLoaded(particleDictionary) do
	  Citizen.Wait(0)
	end

	SetPtfxAssetNextCall(particleDictionary)
	effect = StartParticleFxLoopedOnEntity(particleName, attachedDrill, 0.0, -0.6, 0.0, 0.0, 0.0, 0.0, 2.0, 0, 0, 0)
     ShakeGameplayCam("ROAD_VIBRATION_SHAKE", 1.0)
end



