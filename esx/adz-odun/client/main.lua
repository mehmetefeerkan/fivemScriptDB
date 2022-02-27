ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(6)
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

function playAnim(animDict, animName, duration, flag)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, -8.0, -8, duration, flag, 0, 0, 0, 0)
end

Citizen.CreateThread(function()
    while true do
        local ply = PlayerPedId()
        local pCoords = GetEntityCoords(ply)
        local hCoords = araf.heating
        local wCoords = araf.wroughting
        local dstH = #(pCoords - hCoords)
        local dstF = #(pCoords - wCoords)
        local sleep = araf.sleep

        if dstH <= 5.0 or dstF <= 5.0 then
            sleep = 10
        end

        if dstH <= 2.5 then
            if araf.isMarkerOn then
                DrawMarker(20, hCoords.x, hCoords.y, hCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, araf.markerSize.x, araf.markerSize.y, araf.markerSize.z,
                araf.markerColour.r, araf.markerColour.g, araf.markerColour.b, araf.markerColour.a, false, true, 2, false, nil, nil)
            end

            DrawText3D(hCoords.x, hCoords.y, hCoords.z, _U('press_to_heat'))
        end

        if dstF <= 2.5 then
            if araf.isMarkerOn then
                DrawMarker(20, wCoords.x, wCoords.y, wCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, araf.markerSize.x, araf.markerSize.y, araf.markerSize.z,
                araf.markerColour.r, araf.markerColour.g, araf.markerColour.b, araf.markerColour.a, false, true, 2, false, nil, nil)
            end

            DrawText3D(wCoords.x, wCoords.y, wCoords.z, _U('press_to_wrought'))
        end

        for k, v in pairs(araf.mining) do
            local dstM = #(pCoords - vector3(v.x, v.y, v.z))

            if dstM <= 10.0 then
                sleep = 10
            end

            if dstM <= 2.5 then
                DrawText3D(v.x, v.y, v.z, _U('press_to_mine'))
            end

            if araf.isMarkerOn and dstM < 5.0 then
                DrawMarker(20, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, araf.markerSize.x, araf.markerSize.y, araf.markerSize.z, araf.markerColour.r,
                araf.markerColour.g, araf.markerColour.b, araf.markerColour.a, false, true, 2, false, nil, nil)
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        local ply = PlayerPedId()
        local pCoords = GetEntityCoords(ply)
        local hCoords = araf.heating
        local wCoords = araf.wroughting
        local dstH = #(pCoords - hCoords)
        local dstF = #(pCoords - wCoords)
        local sleep = araf.sleep

        if dstH <= 5.0 or dstF <= 5.0 then
            sleep = 10
        end

        if dstH <= 2.5 and IsControlJustReleased(0, 38) then
            ESX.TriggerServerCallback('adz-odun:getItemCount', function(cb)
                if cb >= araf.requiredItemCount then
                    playAnim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", -1, 16)
                    if araf.useSkillBar then
                        local finished = exports["reload-skillbar"]:taskBar(2500, math.random(5,20))
                        if finished ~= 100 then
                            exports['mythic_notify']:DoHudText('inform', _U('heating_failed'), { ['background-color'] = '#ce0808', ['color'] = '#f2f2f2' })
                            TriggerServerEvent('adz-odun:deleteItem', araf.iron, 2)
                            ClearPedTasks(ply)
                        else
                            TriggerServerEvent('adz-odun:giveHeatedItem')
                            ClearPedTasks(ply)
                        end
                    elseif araf.useProgbar then
                        exports["t0sic_loadingbar"]:StartDelayedFunction(_U('heating_in_progress'), 5000, function()
                            TriggerServerEvent('adz-odun:giveHeatedItem')
                            ClearPedTasks(ply)
                        end)
                    end
                else
                    exports['mythic_notify']:DoHudText('inform', _U('no_item', _U('ironLabel')), { ['background-color'] = '#ce0808', ['color'] = '#f2f2f2' })
                end
            end, araf.iron)
        end

        if dstF <= 2.5 and IsControlJustReleased(0, 38) then
            ESX.TriggerServerCallback('adz-odun:getItemCount', function(cb)
                if cb >= araf.requiredItemCount then
                    playAnim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", -1, 16)
                    if araf.useSkillBar then
                        local finished = exports["reload-skillbar"]:taskBar(2500, math.random(37,45))
                        if finished ~= 100 then
                            exports['mythic_notify']:DoHudText('inform', _U('wroughting_failed'), { ['background-color'] = '#ce0808', ['color'] = '#f2f2f2' })
                            TriggerServerEvent('adz-odun:deleteItem', araf.heatedIron, 2)
                            ClearPedTasks(ply)
                        else
                            TriggerServerEvent('adz-odun:giveWroughtedItem')
                            ClearPedTasks(ply)
                        end
                    elseif araf.useProgbar then
                        exports["t0sic_loadingbar"]:StartDelayedFunction(_U('wroughting_in_progress'), 5000, function()
                            TriggerServerEvent('adz-odun:giveWroughtedItem')
                            ClearPedTasks(ply)
                        end)
                    end
                else
                    exports['mythic_notify']:DoHudText('inform', _U('no_item', _U('heatedIronLabel')), { ['background-color'] = '#ce0808', ['color'] = '#f2f2f2' })
                end
            end, araf.heatedIron)
        end

        for k, v in pairs(araf.mining) do
            local mCoords = v
            local dstM = #(pCoords - mCoords)

            if dstM <= 5.0 then
                sleep = 10
            end

            if dstM <= 2.5 and IsControlJustReleased(0, 38) then
                FreezeEntityPosition(PlayerPedId(), true)
                pickaxe = CreateObject(GetHashKey("prop_tool_hammer"), 0, 0, 0, true, true, true) 
                AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
                playAnim('amb@world_human_hammering@male@base', 'base', -1, 49)
                if araf.useSkillBar then
                    local finished = exports["reload-skillbar"]:taskBar(2500, math.random(2,9))
                    if finished ~= 100 then
                        exports['mythic_notify']:DoHudText('inform', _U('mining_failed'), { ['background-color'] = '#ce0808', ['color'] = '#f2f2f2' })
                        ClearPedTasks(ply)
                        DetachEntity(pickaxe, 1, true)
                        DeleteEntity(pickaxe)
                        DeleteObject(pickaxe)
                        FreezeEntityPosition(PlayerPedId(), false)
                    else
                        TriggerServerEvent('adz-odun:giveMiningItem')
                        ClearPedTasks(ply)
                        DetachEntity(pickaxe, 1, true)
                        DeleteEntity(pickaxe)
                        DeleteObject(pickaxe)
                        FreezeEntityPosition(PlayerPedId(), false)
                    end
                elseif araf.useProgbar then
                    exports["t0sic_loadingbar"]:StartDelayedFunction(_U('mining_in_progress'), 5000, function()
                        TriggerServerEvent('adz-odun:giveMiningItem')
                        ClearPedTasks(ply)
                        DetachEntity(pickaxe, 1, true)
                        DeleteEntity(pickaxe)
                        DeleteObject(pickaxe)
                        FreezeEntityPosition(PlayerPedId(), false)
                    end)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)
--[[
Citizen.CreateThread(function()
    for k, v in pairs(araf.blips) do
        local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
        SetBlipSprite(blip, 566)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.75)
        SetBlipColour(blip, 55)
        SetBlipAsShortRange(blip, false)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.title)
        EndTextCommandSetBlipName(blip)
    end
end)
--]]