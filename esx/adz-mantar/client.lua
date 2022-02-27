ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)

local hasjob = false
local ciuperci = 0

function DrawText3D(x,y,z, text, scl) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

local coordonate = {
    {790.95959472656,4286.9658203125,55.545942687988},
    {785.61285400391,4288.5952148438,55.76137008667},
    {777.37567138672,4286.013671875,55.376140594482},
    {783.12194824219,4294.5239257813,58.114027404785},
    {765.93200683594,4276.0834960938,55.820201873779-1},
    {759.37152099609,4287.658203125,60.372291564941-1},
}

local sleep = 2000

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(sleep)
        perform = false
        local pos = GetEntityCoords(PlayerPedId())
        local metrii = math.floor(GetDistanceBetweenCoords(1725.1472167969,4642.4184570313,43.875480651855, GetEntityCoords(PlayerPedId())))
        if ciuperci == 6 then
            perform = true
            DrawText3D(pos.x,pos.y,pos.z, "~y~Git ve Mantarları Sat", 1.2)
        end
        if hasjob == true then
            for i,v in pairs(coordonate) do
                local metrii2 = math.floor(GetDistanceBetweenCoords(v[1],v[2],v[3], GetEntityCoords(PlayerPedId())))
                if ciuperci == 1 or ciuperci == 2 or ciuperci == 3 or ciuperci == 4 or ciuperci == 5 then
                    perform = true
                    DrawText3D(pos.x,pos.y,pos.z, "Mantar ~r~"..ciuperci.."~w~/~g~6", 1.2)
                end
                if coordonate[i] ~= nil then
                    if metrii2 <=3 then
                        perform = true
                        DrawText3D(v[1],v[2],v[3]+0.7, "Mantar toplamak için ~y~[E]~w~ bas", 1.2)
                        if IsControlJustPressed(1,51) then
                            table.remove(coordonate,i)
                            local playerPed = PlayerPedId()
                            TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, false)
                            SetTimeout(10000, function()
                            ClearPedTasks(playerPed)
                            exports['mythic_notify']:SendAlert('inform', '1 adet mantar topladın.', 2500)

                            ciuperci = ciuperci + 1
                                if ciuperci == 6 then
                                    SetNewWaypoint(1725.1472167969,4642.4184570313)
                                end
                            end)
                        end
                    end
                else
                    perform = true
                    DrawText3D(coordonate[i]+0.7, "Mantar zaten toplandı", 1.2)
                end
            end
        end
        if metrii <= 3 then
            perform = true
            DrawText3D(pos.x,pos.y,pos.z+0.6, "Mantar Çiftçisi olmak için ~y~[E]~w~ bas\n Mantar satmak için ~y~[Y]~w~ bas", 1.2)
            if IsControlJustPressed(1,51) then
                if hasjob == false then
                cosdeoua = CreateObject(GetHashKey("prop_fruit_basket"), pos.x, pos.y, pos.z,  true,  true, true)
                AttachEntityToEntity(cosdeoua, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.22, -0.3+0.25, 0.0+0.16, 160.0, 90.0, 125.0, true, true, false, true, 1, true)
                exports['mythic_notify']:SendAlert('inform', 'İşe alındın,Konum Haritanda İsaretlendi!', 2500)

                hasjob = true
                SetNewWaypoint(795.26397705078,4269.4155273438)
                for i,v in pairs(coordonate) do
                    cvprop = CreateObject(GetHashKey('prop_stoneshroom1'), v[1],v[2],v[3], false)
                end
                elseif hasjob == true then
                    exports['mythic_notify']:SendAlert('inform', 'Zaten Mantar Çiftçisi olarak işe alındın.', 2500)
                end
            elseif IsControlJustPressed(1,246) then
                if ciuperci == 6 then
                table.insert(coordonate,{790.95959472656,4286.9658203125,55.545942687988})
                table.insert(coordonate,{785.61285400391,4288.5952148438,55.76137008667})
                table.insert(coordonate,{777.37567138672,4286.013671875,55.376140594482})
                table.insert(coordonate,{783.12194824219,4294.5239257813,58.114027404785})
                table.insert(coordonate,{765.93200683594,4276.0834960938,55.820201873779-1})
                table.insert(coordonate,{759.37152099609,4287.658203125,60.372291564941-1})
                TriggerServerEvent("hell_mushroomfarmer:sell")
                ciuperci = 0
                hasjob = false
                DeleteEntity(cosdeoua)
                DeleteEntity(cosdeoua)
                else
                    exports['mythic_notify']:SendAlert('inform', 'Aptal olma.', 2500)

                end
            end
        end
        if perform then
            sleep = 7
        elseif not perform then
            sleep = 2000
        end
    end
end)