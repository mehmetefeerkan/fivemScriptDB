ESX = nil
local Data = {}
Config = {}
Config['Debug'] = false -- if this is enabled, synced animations will just spawn an npc that will do the animation with you

Config['pNotify'] = true -- use pNotify for notifications?

Config['SelectableButtons'] = { -- find controls here https://docs.fivem.net/docs/game-references/controls/
    {'~INPUT_MULTIPLAYER_INFO~', 20},
    {'~INPUT_VEH_NEXT_RADIO~', 81},
    {'~INPUT_VEH_PREV_RADIO~', 82},
    {'~INPUT_VEH_NEXT_RADIO_TRACK~', 83}, 
    {'~INPUT_VEH_PREV_RADIO_TRACK~', 84}
}
--[[
Config['OpenMenu'] = 170 -- button to open menu, set to false to disable hardcoded button opening (e.g if you want to add it to your own menu) 
Config['CancelAnimation'] = 105
-- TriggerEvent('8x_erp:openMenu') < event to open the menu

Config['PoleDance'] = { -- allows you to pole dance at the strip club, you can of course add more locations if you want.
    ['Enabled'] = true,
    ['Locations'] = {
        {['Position'] = vector3(112.60, -1286.76, 28.56), ['Number'] = '3'},
        {['Position'] = vector3(104.18, -1293.94, 29.26), ['Number'] = '1'},
        {['Position'] = vector3(102.24, -1290.54, 29.26), ['Number'] = '2'}
    }
}
]]--
Strings = {
    ['Choose_Favorite'] = 'What button do you want to use for %s?',
    ['Select_Favorite'] = 'Add a quick bind animation',
    ['Manage_Favorites'] = 'Manage quick bind animations',
    ['Close'] = 'Kapat',
    ['Updated_Favorites'] = 'Updated quick bind animations.',
    ['Remove?'] = 'Remove "%s" as a quick bind animation?',
    ['Yes'] = 'Evet',
    ['No'] = 'Hayır',
    ['Animations'] = 'Animasyonlar',
    ['Synced'] = 'ERP Animasyonlar',
    ['Sync_Request'] = 'ERP Teklifi: %s %s?',
    ['Pole_Dance'] = '[~r~E~w~] Direk Dansı',
    ['Noone_Close'] = 'Yakında kimse yok!',
    ['Not_In_Car'] = 'Araçta değilsin!'
}

Config['Synced'] = {
        {
            ['Label'] = 'Ayakta Sakso Çek',
            ['RequesterLabel'] = 'sana sakso çekmek istiyor',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'pimpsex_hooker', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.0,
                    ['yP'] = 0.65,
                    ['zP'] = 0.0,
    
                    ['xR'] = 120.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'pimpsex_punter', ['Flags'] = 1,
            },
        },
        {
            ['Label'] = 'Ayakta Seviş',
            ['RequesterLabel'] = 'sevişmek istiyor',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'shagloop_hooker', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.05,
                    ['yP'] = 0.4,
                    ['zP'] = 0.0,
    
                    ['xR'] = 120.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'shagloop_pimp', ['Flags'] = 1,
            },
        },
        {
            ['Label'] = 'Arkadan Sik', 
            ['RequesterLabel'] = 'seni arkadan sikmek istiyor',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'rcmpaparazzo_2', ['Anim'] = 'shag_loop_a', ['Flags'] = 1,
            }, 
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'rcmpaparazzo_2', ['Anim'] = 'shag_loop_poppy', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.015,
                    ['yP'] = 0.35,
                    ['zP'] = 0.0,
    
                    ['xR'] = 0.9,
                    ['yR'] = 0.3,
                    ['zR'] = 0.0,
                },
            },
        },
        {
            ['Label'] = "Sik (sürücü kullanmalı)", 
            ['RequesterLabel'] = 'seni arabada sikmek istiyor',
            ['Car'] = true,
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'oddjobs@assassinate@vice@sex', ['Anim'] = 'frontseat_carsex_loop_m', ['Flags'] = 1,
            }, 
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'oddjobs@assassinate@vice@sex', ['Anim'] = 'frontseat_carsex_loop_f', ['Flags'] = 1,
            },
        },
        {
            ['Label'] = "Seviş (sürücü kullanmalı)", 
            ['RequesterLabel'] = 'kişi sevişmek istiyor',
            ['Car'] = true,
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'random@drunk_driver_2', ['Anim'] = 'cardrunksex_loop_f', ['Flags'] = 1,
            }, 
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'random@drunk_driver_2', ['Anim'] = 'cardrunksex_loop_m', ['Flags'] = 1,
            },
        },
        {
            ['Label'] = "Sakso İste (sürücü kullanmalı)", 
            ['RequesterLabel'] = 'sakso istiyor',
            ['Car'] = true,
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'oddjobs@towing', ['Anim'] = 'm_blow_job_loop', ['Flags'] = 1,
            }, 
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'oddjobs@towing', ['Anim'] = 'f_blow_job_loop', ['Flags'] = 1,
            },
        },
    
}

Citizen['CreateThread'](function()
    while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Wait(0) end
    while ESX.GetPlayerData()['job'] == nil do Wait(0) end

    ESX['TriggerServerCallback']('8x_erp:get_favorites', function(favorite)
        Data['Favorites'] = json['decode'](favorite)
    end)

    while not Data['Favorites'] do Wait(0) end

    while true do

        if not IsPedDeadOrDying(PlayerPedId()) then
--[[
            if Config['OpenMenu'] then
                if IsControlJustReleased(0, Config['OpenMenu']) then
                    TriggerEvent('8x_erp:openMenu')
                end
            end
            
            if Config['CancelAnimation'] then
                if IsControlJustReleased(0, Config['CancelAnimation']) then
                    ClearPedTasks(PlayerPedId())
                end
            end

            if Config['PoleDance']['Enabled'] then
                for k, v in pairs(Config['PoleDance']['Locations']) do
                    if #(GetEntityCoords(PlayerPedId()) - v['Position']) <= 1.0 then
                        DrawText3D(v['Position'], Strings['Pole_Dance'], 0.35)
                        if IsControlJustReleased(0, 51) then
                            LoadDict('mini@strip_club@pole_dance@pole_dance' .. v['Number'])
                            local scene = NetworkCreateSynchronisedScene(v['Position'], vector3(0.0, 0.0, 0.0), 2, false, false, 1065353216, 0, 1.3)
                            NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, 'mini@strip_club@pole_dance@pole_dance' .. v['Number'], 'pd_dance_0' .. v['Number'], 1.5, -4.0, 1, 1, 1148846080, 0)
                            NetworkStartSynchronisedScene(scene)
                        end
                    end
                end
            end

            for k, v in pairs(Data['Favorites']) do
                if IsControlJustReleased(0, tonumber(k)) then
                    if v['Type'] == 'scenario' then
                        TaskStartScenarioInPlace(PlayerPedId(), v['Anim'], 0, false)
                    elseif v['Type'] == 'walking_style' then
                        SetWalkingStyle(v['Style'])
                    elseif v['Type'] == 'animation' then
                        PlayAnim(v['Dict'], v['Anim'], v['Flags'])
                    end
                end
            end
]]--
        end
        Wait(0)
    end
end)

RegisterNetEvent('8x_erp:openMenu')
AddEventHandler('8x_erp:openMenu', function()
    local elements = {}

    --table.insert(elements, {label = Strings['Animations'], value = 'animations'})
    table.insert(elements, {label = Strings['Synced'], value = 'synced'})
    --table.insert(elements, {label = Strings['Select_Favorite'], value = 'favorite'})
    local len = 0
    for k, v in pairs(Data['Favorites']) do -- # doesn't work to get the length of the table (since we use ['string'] = {data} instead of [number] = {data})
        len = len + 1
    end
    if len > 0 then
        table.insert(elements, {label = Strings['Manage_Favorites'], value = 'manage'})
    end

	ESX['UI']['Menu']['Open']('default', GetCurrentResourceName(), 'animations',
	{
		title = Strings['Animations'],
		align = 'bottom-right',
		elements = elements
    }, function(data, menu)
        if data['current']['value'] == 'synced' then

            local elements2 = {}
            for k, v in pairs(Config['Synced']) do
                table.insert(elements2, {['label'] = v['Label'], ['id'] = k})
            end
            
			ESX['UI']['Menu']['Open']('default', GetCurrentResourceName(), 'play_synced',
            {
                title = data['current']['label'],
                align = 'bottom-right',
                elements = elements2
            }, function(data2, menu2)
                current = data2['current']
                local allowed = false
                if Config['Synced'][current['id']]['Car'] then
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        allowed = true
                    else
                        ESX['ShowNotification'](Strings['Not_In_Car'])
                    end
                else
                    allowed = true
                end
                if allowed then
                    if not Config['Debug'] then
                        local allowed = false
                        local distance, closest = 999.0, nil -- some stupid error comparing nil with number....
        
                        for k, v in pairs(GetActivePlayers()) do
                            src = GetPlayerServerId(v)
                            if src ~= GetPlayerServerId(PlayerId()) then
                                plr = GetPlayerFromServerId(src)
                                dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(GetPlayerPed(plr)))
                                if not closest then
                                    closest = src
                                    distance = dist
                                else
                                    if dist < distance then
                                        distance = dist
                                        closest = src
                                    end
                                end
                            end
                        end

                        if distance <= 2.0 then
                            TriggerServerEvent('8x_erp:requestSynced', closest, current['id'])
                        else
                            ESX['ShowNotification'](Strings['Noone_Close'])
                        end

                    else

                        local id = current['id']

                        local target = ClonePed(PlayerPedId(), GetEntityHeading(PlayerPedId()), 1, 1)
                        CreateThread(function()

                            local anim = Config['Synced'][id]['Accepter']

                            if Config['Synced'][id]['Car'] then
                                TaskWarpPedIntoVehicle(target, GetVehiclePedIsUsing(PlayerPedId()), 0)
                            end

                            if anim['Attach'] then
                                local attach = anim['Attach']
                                AttachEntityToEntity(target, PlayerPedId(), attach['Bone'], attach['xP'], attach['yP'], attach['zP'], attach['xR'], attach['yR'], attach['zR'], 0, 0, 0, 0, 2, 1)
                            end

                            Wait(750)

                            if anim['Type'] == 'animation' then
                                LoadDict(anim['Dict'])
                                TaskPlayAnim(target, anim['Dict'], anim['Anim'], 8.0, -8.0, -1, anim['Flags'] or 0, 0, false, false, false)
                            end

                            anim = Config['Synced'][id]['Requester']

                            while not IsEntityPlayingAnim(PlayerPedId(), anim['Dict'], anim['Anim'], 3) do
                                Wait(0)
                                SetEntityNoCollisionEntity(target, PlayerPedId(), true)
                            end
                            DetachEntity(target)
                            while IsEntityPlayingAnim(PlayerPedId(), anim['Dict'], anim['Anim'], 3) do
                                Wait(0)
                                SetEntityNoCollisionEntity(target, PlayerPedId(), true)
                            end

                            ClearPedTasks(target)
                            DeleteEntity(target)

                        end)
                        CreateThread(function()
                            local anim = Config['Synced'][id]['Requester']
                            if anim['Attach'] then
                                local attach = anim['Attach']
                                AttachEntityToEntity(PlayerPedId(), target, attach['Bone'], attach['xP'], attach['yP'], attach['zP'], attach['xR'], attach['yR'], attach['zR'], 0, 0, 0, 0, 2, 1)
                            end

                            Wait(750)

                            if anim['Type'] == 'animation' then
                                PlayAnim(anim['Dict'], anim['Anim'], anim['Flags'])
                            end

                            anim = Config['Synced'][id]['Accepter']

                            while not IsEntityPlayingAnim(target, anim['Dict'], anim['Anim'], 3) do
                                Wait(0)
                                SetEntityNoCollisionEntity(PlayerPedId(), target, true)
                            end
                            DetachEntity(PlayerPedId())
                            while IsEntityPlayingAnim(target, anim['Dict'], anim['Anim'], 3) do
                                Wait(0)
                                SetEntityNoCollisionEntity(PlayerPedId(), target, true)
                            end

                            ClearPedTasks(PlayerPedId())
                        end)

                    end
                end


            end, function(data2, menu2)
                menu2['close']()
            end)

        elseif data['current']['value'] == 'manage' then

            local elements2 = {}
            for k, v in pairs(Data['Favorites']) do
                table.insert(elements2, {['label'] = v['Label'], ['id'] = k})
            end
            
			ESX['UI']['Menu']['Open']('default', GetCurrentResourceName(), 'play_animation',
            {
                title = data['current']['label'],
                align = 'bottom-right',
                elements = elements2
            }, function(data2, menu2)
                current = data2['current']

                ESX['UI']['Menu']['Open']('default', GetCurrentResourceName(), 'choose_favorite',
                {
                    title = (Strings['Remove?']):format(Data['Favorites'][current['id']]['Label']),
                    align = 'bottom-right',
                    elements = {
                        {['label'] = Strings['Yes'], ['value'] = 'y'},
                        {['label'] = Strings['No'], ['value'] = 'n'}
                    }
                }, function(data3, menu3)
                    ESX['UI']['Menu']['CloseAll']()
                    local current = data3['current']
                    
                    if current['value'] == 'y' then
                        local fav = Data['Favorites']
                        Data['Favorites'] = {}
                        for k, v in pairs(fav) do
                            if k ~= data2['current']['id'] then
                                Data['Favorites'][k] = v
                            end
                        end
                        --TriggerServerEvent('8x_erp:update_favorites', json['encode'](Data['Favorites']))
                    end
                end, function(data3, menu3)
                    menu3['close']()
                end)

            end, function(data2, menu2)
                menu2['close']()
            end)

        elseif data['current']['value'] == 'favorite' then

            local elements2 = {}
            for k, v in pairs(Config['Animations']) do
                table.insert(elements2, {['label'] = v['Label'], ['id'] = k})
            end
            
			ESX['UI']['Menu']['Open']('default', GetCurrentResourceName(), 'play_animation',
            {
                title = data['current']['label'],
                align = 'bottom-right',
                elements = elements2
            }, function(data2, menu2)
                current = data2['current']

                local elements3 = {}
                for k, v in pairs(Config['Animations'][current['id']]['Data']) do
                    table.insert(elements3, {['label'] = v['Label'], ['id'] = v['id'], ['data'] = v})
                end
                
                ESX['UI']['Menu']['Open']('default', GetCurrentResourceName(), 'choose_favorite',
                {
                    title = data['current']['value'],
                    align = 'bottom-right',
                    elements = elements3
                }, function(data3, menu3)
                    ESX['UI']['Menu']['CloseAll']()
                    local current = data3['current']['data']
                    CreateThread(function()
                        local string = (Strings['Choose_Favorite'] .. '\n'):format(data3['current']['label'])
                        local button = 'error'
                        
                        for k, v in pairs(Config['SelectableButtons']) do
                            if not Data['Favorites'][v[2]] then
                                string = string .. v[1] .. '\n'
                            end
                        end
                        
                        string = string .. '\n' .. '~INPUT_FRONTEND_RRIGHT~ ' .. Strings['Close']

                        local chosen = false
                        while not chosen do 
                            Wait(0)
                            HelpText(string)

                            for k, v in pairs(Config['SelectableButtons']) do
                                if IsDisabledControlJustReleased(0, v[2]) then
                                    button = v[2]
                                    chosen = true
                                end
                                DisableControlAction(0, v[2])
                            end

                            if IsControlJustReleased(0, 194) then
                                button = false
                                chosen = true
                            end

                        end
--[[
                        if button then
                            Data['Favorites'][tostring(button)] = current
                            TriggerServerEvent('8x_erp:update_favorites', json['encode'](Data['Favorites']))
                        end
                        ]]--
                    end)
                end, function(data3, menu3)
                    menu3['close']()
                end)

            end, function(data2, menu2)
                menu2['close']()
            end)

        elseif data['current']['value'] == 'animations' then

            local elements2 = {}
            
            for k, v in pairs(Config['Animations']) do
                table.insert(elements2, {['label'] = v['Label'], ['value'] = k})
            end

			ESX['UI']['Menu']['Open']('default', GetCurrentResourceName(), 'view_animations',
            {
                title = data['current']['label'],
                align = 'bottom-right',
                elements = elements2
            }, function(data2, menu2)

                local elements3 = {}
                for k, v in pairs(Config['Animations'][data2['current']['value']]['Data']) do
                    table.insert(elements3, {label = v['Label'], data = v})
                end

                ESX['UI']['Menu']['Open']('default', GetCurrentResourceName(), 'play_animation',
                {
                    title = data2['current']['label'],
                    align = 'bottom-right',
                    elements = elements3
                }, function(data3, menu3)
                    local current = data3['current']['data']

                    if current['Type'] == 'scenario' then
                        TaskStartScenarioInPlace(PlayerPedId(), current['Anim'], 0, false)
                    elseif current['Type'] == 'walking_style' then
                        SetWalkingStyle(current['Style'])
                    elseif current['Type'] == 'animation' then
                        PlayAnim(current['Dict'], current['Anim'], current['Flags'])
                    end
                end, function(data3, menu3)
                    menu3['close']()
                end)
                
            end, function(data2, menu2)
                menu2['close']()
            end)

		end
	end, function(data, menu)
		menu['close']()
	end)
end)

RegisterNetEvent('8x_erp:syncRequest')
AddEventHandler('8x_erp:syncRequest', function(requester, id, name)
    local accepted = false
    local timer = GetGameTimer() + 5000
    while timer >= GetGameTimer() do 
        Wait(0)

        HelpText((Strings['Sync_Request']):format(Config['Synced'][id]['RequesterLabel'], name) .. ('\n~INPUT_FRONTEND_ACCEPT~ %s \n~INPUT_FRONTEND_RRIGHT~ %s'):format(Strings['Yes'], Strings['No']))

        if IsControlJustReleased(0, 194) then
            break
        elseif IsControlJustReleased(0, 201) then
            accepted = true
            break
        end

    end

    if accepted then
        TriggerServerEvent('8x_erp:syncAccepted', requester, id)
    end
end)

RegisterNetEvent('8x_erp:playSynced')
AddEventHandler('8x_erp:playSynced', function(serverid, id, type)
    local anim = Config['Synced'][id][type]

    local target = GetPlayerPed(GetPlayerFromServerId(serverid))
    if anim['Attach'] then
        local attach = anim['Attach']
        AttachEntityToEntity(PlayerPedId(), target, attach['Bone'], attach['xP'], attach['yP'], attach['zP'], attach['xR'], attach['yR'], attach['zR'], 0, 0, 0, 0, 2, 1)
    end

    Wait(750)

    if anim['Type'] == 'animation' then
        PlayAnim(anim['Dict'], anim['Anim'], anim['Flags'])
    end

    if type == 'Requester' then
        anim = Config['Synced'][id]['Accepter']
    else
        anim = Config['Synced'][id]['Requester']
    end
    while not IsEntityPlayingAnim(target, anim['Dict'], anim['Anim'], 3) do
        Wait(0)
        SetEntityNoCollisionEntity(PlayerPedId(), target, true)
    end
    DetachEntity(PlayerPedId())
    while IsEntityPlayingAnim(target, anim['Dict'], anim['Anim'], 3) do
        Wait(0)
        SetEntityNoCollisionEntity(PlayerPedId(), target, true)
    end

    ClearPedTasks(PlayerPedId())
end)

SetWalkingStyle = function(Style)
    LoadDict(Style)
    SetPedMovementClipset(PlayerPedId(), Style, true)
end

PlayAnim = function(Dict, Anim, Flag)
    LoadDict(Dict)
    TaskPlayAnim(PlayerPedId(), Dict, Anim, 8.0, -8.0, -1, Flag or 0, 0, false, false, false)
end

LoadDict = function(Dict)
    while not HasAnimDictLoaded(Dict) do 
        Wait(0)
        RequestAnimDict(Dict)
    end
end

HelpText = function(msg)
    AddTextEntry(GetCurrentResourceName(), msg)
    DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
end

DrawText3D = function(coords, text, scale)
	local onScreen,_x,_y=World3dToScreen2d(coords.x, coords.y, coords.z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 41, 41, 125)
end

RegisterCommand("erp", function()
    TriggerEvent('8x_erp:openMenu')
end)