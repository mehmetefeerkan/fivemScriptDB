ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(250)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playercoords, Config.GemiTeslim.x, Config.GemiTeslim.y, Config.GemiTeslim.z, true)
        local dst2 = GetDistanceBetweenCoords(playercoords, Config.GemiTeslim.x, Config.GemiTeslim.y, Config.GemiTeslim.z, true)
        if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
        if dst2 < 50 then
            sleep = 2
            DrawMarker(2, Config.GemiTeslim.x, Config.GemiTeslim.y, Config.GemiTeslim.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 0.8, 0.8, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst2 < 10 then
                DrawText3Ds(Config.GemiTeslim.x, Config.GemiTeslim.y, Config.GemiTeslim.z + 0.5, '[E] Görevi Bitir')
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "gemiteslim",
                        duration = 10000,
                        label = "Helikopteri teslim ediyorsun",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                    }, function(status)
                        if not status then
                            TriggerEvent("adz-gemiteslim")
                            TriggerServerEvent("adz-paraver")
                            TriggerServerEvent("adz-malzemeal")
                        end
                    end)
                end
            end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playercoords, Config.iskelebir.x, Config.iskelebir.y, Config.iskelebir.z, true)
        local dst2 = GetDistanceBetweenCoords(playercoords, Config.iskelebir.x, Config.iskelebir.y, Config.iskelebir.z, true)
        if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
        if dst2 < 50 then
            sleep = 2
            DrawMarker(2, Config.iskelebir.x, Config.iskelebir.y, Config.iskelebir.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.8, 0.8, 0.8, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst2 < 10 then
                DrawText3Ds(Config.iskelebir.x, Config.iskelebir.y, Config.iskelebir.z + 0.5, '[E] Uyusturucuyu Teslim Et')
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "malzemeteslim",
                        duration = 10000,
                        label = "Uyusturucuyu Teslim Ediyorsun",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                    }, function(status)
                        if not status then
                            SetNewWaypoint(Config.iskeleiki.x, Config.iskeleiki.y)
                            exports['mythic_notify']:SendAlert('inform', 'İlk Uyusturucuyu Başarıyla Teslim Ettin! Şimdi İşaretlenen Bir Sonraki Konuma İlerle')
                            TriggerServerEvent("adz-malzemeal")
                        end
                    end)
                end
            end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playercoords, Config.iskeleiki.x, Config.iskeleiki.y, Config.iskeleiki.z, true)
        local dst2 = GetDistanceBetweenCoords(playercoords, Config.iskeleiki.x, Config.iskeleiki.y, Config.iskeleiki.z, true)
        if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
        if dst2 < 50 then
            sleep = 2
            DrawMarker(2, Config.iskeleiki.x, Config.iskeleiki.y, Config.iskeleiki.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 0.8, 0.8, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst2 < 10 then
                DrawText3Ds(Config.iskeleiki.x, Config.iskeleiki.y, Config.iskeleiki.z + 0.5, '[E] Uyusturucuyu Teslim Et')
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "malzemeteslim",
                        duration = 10000,
                        label = "Uyusturucuyu Teslim Ediyorsun",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                    }, function(status)
                        if not status then
                            SetNewWaypoint(Config.GemiTeslim.x, Config.GemiTeslim.y)
                            exports['mythic_notify']:SendAlert('inform', 'Uyusturucuyu Başarıyla Teslim Ettin! Şimdi İşaretlenen Son Konuma İlerle')
                            TriggerServerEvent("adz-malzemeal")
                        end
                    end)
                end
            end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playercoords, Config.GemiAlText.x, Config.GemiAlText.y, Config.GemiAlText.z, true)
        local dst2 = GetDistanceBetweenCoords(playercoords, Config.GemiAlText.x, Config.GemiAlText.y, Config.GemiAlText.z, true)
        if dst2 < 25 then
            sleep = 2
            DrawMarker(2, Config.GemiAlText.x, Config.GemiAlText.y, Config.GemiAlText.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst2 < 5 then
                DrawText3Ds(Config.GemiAlText.x, Config.GemiAlText.y, Config.GemiAlText.z + 0.5, '[E] Uçagı Çıkart')
                if IsControlJustReleased(0, 38) then
                    SetNewWaypoint(Config.iskelebir.x, Config.iskelebir.y)
                    exports['mythic_notify']:SendAlert('inform', 'Araci Teslim Aldın! Şimdi İşaretlenen Konuma İlerle')
                    TriggerEvent("adz-araccikar")
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playercoords, Config.Teslim.x, Config.Teslim.y, Config.Teslim.z, true)
        local dst2 = GetDistanceBetweenCoords(playercoords, Config.Teslim.x, Config.Teslim.y, Config.Teslim.z, true)
        if dst2 < 10 then
            sleep = 2
            DrawMarker(2, Config.Teslim.x, Config.Teslim.y, Config.Teslim.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst2 < 5 then
                DrawText3Ds(Config.Teslim.x, Config.Teslim.y, Config.Teslim.z + 0.5, '[E] Göreve Basla')
                if IsControlJustReleased(0, 38) then
                    SetNewWaypoint(Config.GemiAlText.x, Config.GemiAlText.y)
                    exports['mythic_notify']:SendAlert('inform', 'İşi aldın gideceğin konum haritada işaretlendi.Dikkatli ol!')
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playercoords, Config.MalzemeKutula.x, Config.MalzemeKutula.y, Config.MalzemeKutula.z, true)
        local dst2 = GetDistanceBetweenCoords(playercoords, Config.MalzemeKutula.x, Config.MalzemeKutula.y, Config.MalzemeKutula.z, true)
        if dst2 < 10 then
            sleep = 2
            DrawMarker(2, Config.MalzemeKutula.x, Config.MalzemeKutula.y, Config.MalzemeKutula.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst2 < 2 then
                DrawText3Ds(Config.MalzemeKutula.x, Config.MalzemeKutula.y, Config.MalzemeKutula.z + 0.5, '[E] Malzeme Kutula')
                if IsControlJustReleased(0, 38) then
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "malzemekutula",
                        duration = 5000,
                        label = "malzeme kutuluyorsun",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                        animation = {
                            animDict = "mini@repair",
                            anim = "fixing_a_ped",
                            flags = 49,
                        },
                    }, function(status)
                        if not status then
                            TriggerServerEvent("adz-malzemever")
                        end
                    end)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterNetEvent("adz-araccikar")
AddEventHandler("adz-araccikar", function()
    local ped = PlayerPedId()
    ESX.Game.SpawnVehicle(Config.Arac, Config.GemiAl, Config.Heading, function(vehicle)
        Vehicle = vehicle
        TaskWarpPedIntoVehicle(ped, vehicle, -1)
    end)
end)

RegisterNetEvent("adz-gemiteslim")
AddEventHandler("adz-gemiteslim", function()
    local currentVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    SetEntityAsMissionEntity(currentVehicle, true, true)
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    SetEntityCoords(GetPlayerPed(-1), x - 2, y, z)
    DeleteVehicle(currentVehicle)
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end