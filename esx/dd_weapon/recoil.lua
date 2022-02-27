local recoils = {
	[416676503] = 0.34,
	[-957766203] = 0.22,
	[970310034] = 0.17,  
}
RegisterNetEvent('recoil:active')
AddEventHandler('recoil:active', function()
    local ply = PlayerPedId()
    SetPedSuffersCriticalHits(ply, false)

    if IsPedArmed(ply, 6) then
        DisableControlAction(1, 140, true)
        DisableControlAction(1, 141, true)
        DisableControlAction(1, 142, true)
    elseif IsPedArmed(ply, 1) then
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_FLASHLIGHT"), 0.1)   
    else
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.35)
    end
    
    if IsPedShooting(ply) then      
        local _,wep = GetCurrentPedWeapon(ply)
        local _,cAmmo = GetAmmoInClip(ply, wep)
        
    --	if hasar[wep] and hasar[wep] ~= 0 then
          --  yenihasar = ((hasar[wep]/100)*25)/10
           -- print(yenihasar)
        --	N_0x4757f00bc6323cfe(wep, yenihasar)
        --end
        
        local GamePlayCam = GetFollowPedCamViewMode()
        local Vehicled = IsPedInAnyVehicle(ply, false)
        local MovementSpeed = math.ceil(GetEntitySpeed(ply))

        if MovementSpeed > 69 then
            MovementSpeed = 69
        end
        Citizen.Wait(50)
        local _,wep = GetCurrentPedWeapon(ply)
        if wep ~= 126349499 then
            local group = GetWeapontypeGroup(wep)
            local p = GetGameplayCamRelativePitch()
            local cameraDistance = #(GetGameplayCamCoord() - GetEntityCoords(ply))

            -- local recoil = math.random(100,140+MovementSpeed)/100
            local recoil = math.random(130,140+(math.ceil(MovementSpeed*1.5)))/100
            local rifle = false

            -- if group == 970310034 then
            if group == 970310034 or group == 1159398588 or group == 3337201093 or group == 416676503 or group == 860033945 or group == 2685387236 or group == 3566412244 or group == 4257178988 or group == 3082541095 or group == 690389602 or group == 2725924767 or group == 1548507267 or group == 1595662460 or group == 3539449195 or group == 3493187224 or group == 431593103 then
                rifle = true
            end

            if cameraDistance < 5.3 then
                cameraDistance = 1.5
            else
                if cameraDistance < 8.0 then
                    cameraDistance = 4.0
                else
                    cameraDistance = 7.0
                end
            end

            if Vehicled then
                recoil = recoil + (recoil * cameraDistance)
            else
                recoil = recoil * 0.1
            end

            if GamePlayCam == 4 then
                recoil = recoil * 0.1
                if rifle then
                    recoil = recoil * 0.1
                end
            end

            if rifle then
                recoil = recoil * 0.1
            end

            local rightleft = math.random(4)
            local h = GetGameplayCamRelativeHeading()
            local hf = math.random(10,40+MovementSpeed)/100

            if Vehicled then
                hf = hf * 2.0
            end

            if rightleft == 1 then
                SetGameplayCamRelativeHeading(h+hf)
            elseif rightleft == 2 then
                SetGameplayCamRelativeHeading(h-hf)
            end 
        
            local set = p+recoil

            SetGameplayCamRelativePitch(set,0.8)   
        end 
    end
end)
