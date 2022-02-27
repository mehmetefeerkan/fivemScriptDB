ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local topluyormu = false
local isliyormu = false
local kurutuyormu = false
local paketliyormu = false

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst = GetDistanceBetweenCoords(playercoords, Config.EsrarCikis.x, Config.EsrarCikis.y, Config.EsrarCikis.z, true)
        local dst2 = GetDistanceBetweenCoords(playercoords, Config.EsrarGiris.x, Config.EsrarGiris.y, Config.EsrarGiris.z, true)
        local dst3 = GetDistanceBetweenCoords(playercoords, Config.EsrarTopla.x, Config.EsrarTopla.y, Config.EsrarTopla.z, true)
        local dst4 = GetDistanceBetweenCoords(playercoords, Config.EsrarAyiklama.x, Config.EsrarAyiklama.y, Config.EsrarAyiklama.z, true)
        local dst5 = GetDistanceBetweenCoords(playercoords, Config.EsrarKurutma.x, Config.EsrarKurutma.y, Config.EsrarKurutma.z, true)
        local dst6 = GetDistanceBetweenCoords(playercoords, Config.EsrarPaketleme.x, Config.EsrarPaketleme.y, Config.EsrarPaketleme.z, true)
        if dst < 10 then
            sleep = 7
            DrawMarker(2, Config.EsrarCikis.x, Config.EsrarCikis.y, Config.EsrarCikis.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst < 1 then
                DrawText3D(Config.EsrarCikis.x, Config.EsrarCikis.y, Config.EsrarCikis.z + 0.4, '~g~E~s~ - Gizemli Mekana Gir')
                if IsControlJustReleased(0, 38) then
                    SetEntityCoords(player, Config.EsrarGiris.x, Config.EsrarGiris.y, Config.EsrarGiris.z, false, false, false, true)
                end
            end
        end
        if dst2 < 10 then
            sleep = 7
            DrawMarker(2, Config.EsrarGiris.x, Config.EsrarGiris.y, Config.EsrarGiris.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst2 < 1 then
                DrawText3D(Config.EsrarGiris.x, Config.EsrarGiris.y, Config.EsrarGiris.z + 0.4, '~g~E~s~ - Dısarı Çık')
                if IsControlJustReleased(0, 38) then
                    SetEntityCoords(player, Config.EsrarCikis.x, Config.EsrarCikis.y, Config.EsrarCikis.z, false, false, false, true)
                end
            end
        end
        if dst3 < 10 then
            sleep = 7
            DrawMarker(2, Config.EsrarTopla.x, Config.EsrarTopla.y, Config.EsrarTopla.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst3 < 1 then
                DrawText3D(Config.EsrarTopla.x, Config.EsrarTopla.y, Config.EsrarTopla.z + 0.4, '~g~E~s~ - Esrar Yapragı Topla')
                if IsControlJustReleased(0, 38) then
                    EsrarTopla()
                end
            end
        end
        if dst4 < 10 then
            sleep = 7
            DrawMarker(2, Config.EsrarAyiklama.x, Config.EsrarAyiklama.y, Config.EsrarAyiklama.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst4 < 1 then
                DrawText3D(Config.EsrarAyiklama.x, Config.EsrarAyiklama.y, Config.EsrarAyiklama.z + 0.4, '~g~E~s~ - Esrar Yapragı Ayıkla')
                if IsControlJustReleased(0, 38) then
                    EsrarIsle()
                end
            end
        end
        if dst5 < 10 then
            sleep = 7
            DrawMarker(2, Config.EsrarKurutma.x, Config.EsrarKurutma.y, Config.EsrarKurutma.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst5 < 1 then
                DrawText3D(Config.EsrarKurutma.x, Config.EsrarKurutma.y, Config.EsrarKurutma.z + 0.4, '~g~E~s~ - Esrar Yapragı Kurut')
                if IsControlJustReleased(0, 38) then
                    EsrarIsle2()
                end
            end
        end
        if dst6 < 10 then
            sleep = 7
            DrawMarker(2, Config.EsrarPaketleme.x, Config.EsrarPaketleme.y, Config.EsrarPaketleme.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if dst6 < 1 then
                DrawText3D(Config.EsrarPaketleme.x, Config.EsrarPaketleme.y, Config.EsrarPaketleme.z + 0.4, '~g~E~s~ - Esrar Paketle')
                if IsControlJustReleased(0, 38) then
                    EsrarPaketle()
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

function EsrarTopla()
    if not topluyormu then
        topluyormu = true
        exports['mythic_progbar']:Progress({
            name = "esrarver",
            duration = 10000,
            label = 'Esrar yaprağı topluyorsun...',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_arresting",
                anim = "a_uncuff",
                flags = 49,
            },
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent('utx-weed:giveweed')
                topluyormu = false
                ESX.ShowNotification('Başarıyla esrar yaprağı topladın!')
            else
                -- Do Something If Action Was Cancelled
            end
        end)
    end
end

function EsrarIsle()
    if not isliyormu then
        ESX.TriggerServerCallback('utx-weed:malzemekontrol', function(data)
            local player = PlayerPedId()
            isliyormu = true
            local finished = exports["reload-skillbar"]:taskBar(5000,math.random(5,15))
            if finished ~= 100 then
                TriggerServerEvent('utx-weed:removeitem', 'esrar_ham', 1)
                isliyormu = false
                ClearPedTasksImmediately(player)
                ESX.ShowNotification('Esrarı ayıklayamadın!')
            else
                local finished2 = exports["reload-skillbar"]:taskBar(4750,math.random(5,15))
                if finished2 ~= 100 then
                    TriggerServerEvent('utx-weed:removeitem', 'esrar_ham', 1)
                    isliyormu = false
                    ClearPedTasksImmediately(player)
                    ESX.ShowNotification('Esrarı ayıklayamadın!')
                else
                    local finished3 = exports["reload-skillbar"]:taskBar(4500,math.random(5,15))
                    if finished3 ~= 100 then
                        TriggerServerEvent('utx-weed:removeitem', 'esrar_ham', 1)
                        isliyormu = false
                        ClearPedTasksImmediately(player)
                        ESX.ShowNotification('Esrarı ayıklayamadın!')
                    else
                        TriggerServerEvent('utx-weed:processweed')
                        isliyormu = false
                        ClearPedTasks(player)
                        ESX.ShowNotification('Esrarı başarıyla ayıkladın!')
                    end
                end
            end
        end, "esrar_ham", 1)
    end
end

function EsrarIsle2()
    if not kurutuyormu then
        ESX.TriggerServerCallback('utx-weed:malzemekontrol', function(data)
            local player = PlayerPedId()
            kurutuyormu = true
            local finished = exports["reload-skillbar"]:taskBar(4500,math.random(5,15))
            if finished ~= 100 then
                TriggerServerEvent('utx-weed:removeitem', 'esrar_islenmis', 1)
                kurutuyormu = false
                ClearPedTasksImmediately(player)
                ESX.ShowNotification('Esrarı kurutamadın!')
            else
                local finished2 = exports["reload-skillbar"]:taskBar(4250,math.random(5,15))
                if finished2 ~= 100 then
                    TriggerServerEvent('utx-weed:removeitem', 'esrar_islenmis', 1)
                    kurutuyormu = false
                    ClearPedTasksImmediately(player)
                    ESX.ShowNotification('Esrarı kurutamadın!')
                else
                    local finished3 = exports["reload-skillbar"]:taskBar(4000,math.random(5,15))
                    if finished3 ~= 100 then
                        TriggerServerEvent('utx-weed:removeitem', 'esrar_islenmis', 1)
                        kurutuyormu = false
                        ClearPedTasksImmediately(player)
                        ESX.ShowNotification('Esrarı kurutamadın!')
                    else
                        TriggerServerEvent('utx-weed:processweed2')
                        kurutuyormu = false
                        ClearPedTasks(player)
                        ESX.ShowNotification('Esrarı başarıyla kuruttun!')
                    end
                end
            end
        end, "esrar_islenmis", 1)
    end
end

function EsrarPaketle()
    if not paketliyormu then
        ESX.TriggerServerCallback('utx-weed:malzemekontrol', function(data)
            ESX.TriggerServerCallback('utx-weed:malzemekontrol', function(data)
                local player = PlayerPedId()
                paketliyormu = true
                local finished = exports["reload-skillbar"]:taskBar(4000,math.random(5,15))
                if finished ~= 100 then
                    TriggerServerEvent('utx-weed:removeitem', 'esrar_islenmis2', 1)
                    paketliyormu = false
                    ClearPedTasksImmediately(player)
                    ESX.ShowNotification('Esrarı paketleyemedin!')
                else
                    local finished2 = exports["reload-skillbar"]:taskBar(3750,math.random(5,15))
                    if finished2 ~= 100 then
                        TriggerServerEvent('utx-weed:removeitem', 'esrar_islenmis2', 1)
                        paketliyormu = false
                        ClearPedTasksImmediately(player)
                        ESX.ShowNotification('Esrarı paketleyemedin!')
                    else
                        local finished3 = exports["reload-skillbar"]:taskBar(3500,math.random(5,15))
                        if finished3 ~= 100 then
                            TriggerServerEvent('utx-weed:removeitem', 'esrar_islenmis2', 1)
                            paketliyormu = false
                            ClearPedTasksImmediately(player)
                            ESX.ShowNotification('Esrarı paketleyemedin!')
                        else
                            TriggerServerEvent('utx-weed:packweed')
                            paketliyormu = false
                            ClearPedTasks(player)
                            ESX.ShowNotification('Esrarı başarıyla paketledin!')
                        end
                    end
                end
            end, "poset", 1)
        end, "esrar_islenmis2", 1)
    end
end

if Config.EsrarBlip then
    local coords = vector3(Config.EsrarCikis.x, Config.EsrarCikis.y, Config.EsrarCikis.z)
    local blip = AddBlipForCoord(coords)

	SetBlipSprite(blip, 140)
	SetBlipScale(blip, 0.7)
	SetBlipColour(blip, 2)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Esrar Laboratuvarı')
    EndTextCommandSetBlipName(blip)
end
