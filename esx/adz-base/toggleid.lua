local hidden = {}
local showPlayerBlips = false
local ignorePlayerNameDistance = false
local playerNamesDist = 15
local playerSource = 0
local displayIDHeight = 1.0
local red = 255
local green = 255
local blue = 255

function DrawText3D(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        --SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
		World3dToScreen2d(x,y,z, 0) 
        DrawText(_x,_y)
    end
end

function DrawText3DNick(x,y,z, text)  -- Super
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, 0.35*scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        --SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
		World3dToScreen2d(x,y,z, 0) 
        DrawText(_x,_y)
    end
end

function DrawText3DTalking(x,y,z, text) -- some useful function, use it if you want!
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 5)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
		World3dToScreen2d(x,y,z, 0) 
        DrawText(_x,_y)
    end
end

function GetPedVehicleSeat(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    local invehicle = IsPedInAnyVehicle(ped, false)
    if invehicle then 
        for i=-2,GetVehicleMaxNumberOfPassengers(vehicle) do
            if(GetPedInVehicleSeat(vehicle, i) == ped) then return i end
        end
    end
    return -2
end


RegisterNetEvent("hud:HidePlayer")
AddEventHandler("hud:HidePlayer", function(player, toggle)
    if type(player) == "table" then
        for k,v in pairs(player) do
            local id = GetPlayerFromServerId(k)
            hidden[id] = k
        end
        return
    end
    local id = GetPlayerFromServerId(player)
    if toggle == true then hidden[id] = player
    else
        for k,v in pairs(hidden) do
            if v == player then hidden[k] = nil end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlPressed(1, 19) then
            for i=0,99 do
                N_0x31698aa80e0223f8(i)
            end
            for id = 0, 128 do
                if  NetworkIsPlayerActive( id ) --[[and GetPlayerPed( id ) ~= GetPlayerPed( -1 )) --]] then
                ped = GetPlayerPed( id )
               
 
                x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
                x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
				
					local isDucking = IsPedDucking(GetPlayerPed( id ))
                    local sikis = HasEntityClearLosToEntity( GetPlayerPed( -1 ), GetPlayerPed( id ), 17 )
                    local koltuknumara = GetPedVehicleSeat( GetPlayerPed( id ) )
                    local isReadyToShoot = IsPedWeaponReadyToShoot(GetPlayerPed( id ))
                    local isStealth = GetPedStealthMovement(GetPlayerPed( id ))
                    local isDriveBy = IsPedDoingDriveby(GetPlayerPed( id ))
                    local isInCover = IsPedInCover(GetPlayerPed( id ),true)
                    if isStealth == nil then
                        isStealth = 0
                    end

                    if isDucking or isStealth == 1 or isDriveBy or isInCover then
                        sikis = false
                    end

                    if hidden[id] then sikis = false end
                    
                    if koltuknumara ~= -2 then
                        koltuknumara = koltuknumara + 0.25
                    end
                    koltuknumara = tonumber(koltuknumara)

                if(ignorePlayerNameDistance) then
					if( NetworkIsPlayerTalking(id) ) then
                            
                            if sikis then
                                if koltuknumara == -2 then
                                    DrawText3DTalking(x2, y2, z2+1.0, " ".. GetPlayerServerId(id) .. " ")
                                    DrawText3DNick(x2, y2, z2+1.1, " ".. GetPlayerName(id) .. " ") -- Super
                                else
                                    DrawText3DTalking(x2, (y2+koltuknumara), z2+1.0, " ".. GetPlayerServerId(id) .. " ")
                                    DrawText3DNick(x2, (y2+koltuknumara), z2+1.1, " ".. GetPlayerName(id) .. " ")
                                end
                            end
                        else
                            if sikis then
                                if koltuknumara == -2 then
                                    DrawText3D(x2, y2, z2+1.0, " ".. GetPlayerServerId(id) .. " ")
                                    DrawText3DNick(x2, y2, z2+1.1, " ".. GetPlayerName(id) .. " ") -- Super
                                else
                                    DrawText3D(x2, (y2+koltuknumara), z2+1.0, " ".. GetPlayerServerId(id) .. " ")
                                    DrawText3DNick(x2, (y2+koltuknumara), z2+1.1, " ".. GetPlayerName(id) .. " ")
                                end
                            end
                        end
                end

                if ((distance < playerNamesDist)) then
                    if not (ignorePlayerNameDistance) then
						if( NetworkIsPlayerTalking(id) ) then
                            
                            if sikis then
                                if koltuknumara == -2 then
                                    DrawText3DTalking(x2, y2, z2+1.0, " ".. GetPlayerServerId(id) .. " ")
                                    DrawText3DNick(x2, y2, z2+1.1, " ".. GetPlayerName(id) .. " ") -- Super
                                else
                                    DrawText3DTalking(x2, (y2+koltuknumara), z2+1.0, " ".. GetPlayerServerId(id) .. " ")
                                    DrawText3DNick(x2, y2, z2+1.1, " ".. GetPlayerName(id) .. " ") -- Super
                                end
                            end
                        else
                            if sikis then
                                if koltuknumara == -2 then
                                    DrawText3D(x2, y2, z2+1.0, " ".. GetPlayerServerId(id) .. " ")
                                    DrawText3DNick(x2, y2, z2+1.1, " ".. GetPlayerName(id) .. " ") -- Super
                                else
                                    DrawText3D(x2, (y2+koltuknumara), z2+1.0, " ".. GetPlayerServerId(id) .. " ")
                                    DrawText3DNick(x2, y2, z2+1.1, " ".. GetPlayerName(id) .. " ") -- Super
                                end
                            end
                        end
                    end
                end  
            end
        end
        elseif not IsControlPressed(1, 19) then
            DrawText3D(0, 0, 0, "")
        end
    end
end)

local crouched = false

Citizen.CreateThread( function()
    while true do 
        Citizen.Wait( 1 )

        local ped = GetPlayerPed( -1 )

        if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
            DisableControlAction( 0, 36, true ) -- INPUT_DUCK  

            if ( not IsPauseMenuActive() ) then 
                if ( IsDisabledControlJustPressed( 0, 36 ) ) then 
                    RequestAnimSet( "move_ped_crouched" )

                    while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
                        Citizen.Wait( 100 )
                    end 

                    if ( crouched == true ) then 
                        ResetPedMovementClipset( ped, 0 )
                        crouched = false 
                    elseif ( crouched == false ) then
                        SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
                        crouched = true 
                    end 
                end
            end 
        end 
    end
end )
