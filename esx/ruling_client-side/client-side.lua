RegisterCommand("sebil", function()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
 
    local closestTank = GetClosestObjectOfType(pedCoords, 5.0, -742198632, false)
    if DoesEntityExist(closestTank) then
        local tankCoords = GetEntityCoords(closestTank)
        local distanceCheck = #(pedCoords - tankCoords)
        if distanceCheck <= 1.5 then
            TaskTurnPedToFaceEntity(ped, closestTank, 3600)
            TaskStartScenarioInPlace(ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
            exports['mythic_progbar']:Progress({
                name = "su_doldur",
                duration = 3800,
                label = 'Su Dolduruluyor',
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
            }, function(cancelled)
                if not cancelled then
                    ClearPedTasks(ped)
                    TriggerEvent('esx_status:add', 'thirst', 70000)
                else
                    ClearPedTasks(ped)
                end
            end)
        else
            exports["mythic_notify"]:SendAlert("error", "Yakınlarda Sebil Yok!", 4000)
        end
    end
end)

CreateThread(function()   
    StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE"); 
    SetAudioFlag("PoliceScannerDisabled",true);
end)

--------------------------------

RegisterCommand("animfix", function(source, args, rawCommand)
    local ped = PlayerPedId()
    local isDead = false

    if not IsEntityInAir(ped) then
        if not IsPedRagdoll(ped) then
            if not IsPedInAnyVehicle(ped) then
                ClearPedTasksImmediately(ped)
                ClearPedSecondaryTask(ped)
                SetPedCanPlayGestureAnims(ped, true)
            else
                exports['mythic_notify']:SendAlert('error', 'Bu komutu sadece araç dışında olduğunda kullanabilirsin.', 6500)
            end
        else
            exports['mythic_notify']:SendAlert('error', 'Bu komutu sadece ayaktayken kullanabilirsin.', 6500)
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Bu komutu sadece yerdeyken kullanabilirsin.', 6500)
    end

end, false)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/animfix', 'Eğer animasyonunuz bugda kalırsa ve /e c çalışmıyorsa bu komut kesinlikle animasyonu iptal edecektir.')
end)

Citizen.CreateThread(function()
    SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0) -- Level 0
    SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
    SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
    SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
    SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0) -- Level 4

    while true do
        Citizen.Wait(1)
        if IsPedInAnyVehicle(PlayerPedId(), true) then
            SetRadarZoom(1100)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
  RemoveAllPickupsOfType(0x6E4E65C2)
  RemoveAllPickupsOfType(0x741C684A)
  RemoveAllPickupsOfType(0x68605A36)
  RemoveAllPickupsOfType(0x6C5B941A)
  RemoveAllPickupsOfType(0xD3A39366)
  RemoveAllPickupsOfType(0x550447A9)
  RemoveAllPickupsOfType(0xF99E15D0)
  RemoveAllPickupsOfType(0xA421A532)
  RemoveAllPickupsOfType(0xF33C83B0)
  RemoveAllPickupsOfType(0xDF711959)
  RemoveAllPickupsOfType(0xB2B5325E)
  RemoveAllPickupsOfType(0x85CAA9B1)
  RemoveAllPickupsOfType(0xB2930A14)
  RemoveAllPickupsOfType(0xFE2A352C)
  RemoveAllPickupsOfType(0x693583AD)
  RemoveAllPickupsOfType(0x1D9588D3)
  RemoveAllPickupsOfType(0x3A4C2AD2)
  RemoveAllPickupsOfType(0x4BFB42D1)
  RemoveAllPickupsOfType(0x4D36C349)
  RemoveAllPickupsOfType(0x2F36B434)
  RemoveAllPickupsOfType(0x8F707C18)
  RemoveAllPickupsOfType(0xA9355DCD)
  RemoveAllPickupsOfType(0x96B412A3)
  RemoveAllPickupsOfType(0x9299C95B)
  RemoveAllPickupsOfType(0x5E0683A1)
  RemoveAllPickupsOfType(0x2DD30479)
  RemoveAllPickupsOfType(0x1CD604C7)
  RemoveAllPickupsOfType(0x7C119D58)
  RemoveAllPickupsOfType(0xF9AFB48F)
  RemoveAllPickupsOfType(0x8967B4F3)
  RemoveAllPickupsOfType(0x3B662889)
  RemoveAllPickupsOfType(0x2E764125)
  RemoveAllPickupsOfType(0xFE18F3AF)
  RemoveAllPickupsOfType(0xFD16169E)
  RemoveAllPickupsOfType(0xCB13D282)
  RemoveAllPickupsOfType(0xC69DE3FF)
  RemoveAllPickupsOfType(0x278D8734)
  RemoveAllPickupsOfType(0x5EA16D74)
  RemoveAllPickupsOfType(0x295691A9)
  RemoveAllPickupsOfType(0x81EE601E)
  RemoveAllPickupsOfType(0x88EAACA7)
  RemoveAllPickupsOfType(0x872DC888)
  RemoveAllPickupsOfType(0x094AA1CF)
  RemoveAllPickupsOfType(0x2C014CA6)
  RemoveAllPickupsOfType(0xE33D8630)
  RemoveAllPickupsOfType(0x80AB931C)
  RemoveAllPickupsOfType(0x6E717A95)
  RemoveAllPickupsOfType(0x4B5259BE)
  RemoveAllPickupsOfType(0xCE6FDD6B)
  RemoveAllPickupsOfType(0x5DE0AD3E)
  RemoveAllPickupsOfType(0x1E9A99F8)
  RemoveAllPickupsOfType(0x20893292)
  RemoveAllPickupsOfType(0x14568F28)
  RemoveAllPickupsOfType(0x711D02A4)
  RemoveAllPickupsOfType(0xDE78F17E)
  RemoveAllPickupsOfType(0xD0AACEF7)
  RemoveAllPickupsOfType(0xCC8B3905)
  RemoveAllPickupsOfType(0xA54AE7B7)
  RemoveAllPickupsOfType(0xA717F898)
  RemoveAllPickupsOfType(0x84D676D4)
  RemoveAllPickupsOfType(0x65A7D8E9)
  RemoveAllPickupsOfType(0x2C804FE3)
  RemoveAllPickupsOfType(0x098D79EF)
  RemoveAllPickupsOfType(0x4316CC09)
  RemoveAllPickupsOfType(0xB86AEE5B)
  RemoveAllPickupsOfType(0xCC7CCD1B)
  RemoveAllPickupsOfType(0x2E071B5A)
  RemoveAllPickupsOfType(0xA5B8CAA9)
  RemoveAllPickupsOfType(0x65948212)
  RemoveAllPickupsOfType(0xE7CF07CC)
  RemoveAllPickupsOfType(0x1CD2CF66)
  RemoveAllPickupsOfType(0x6773257D)
  RemoveAllPickupsOfType(0x20796A82)
  RemoveAllPickupsOfType(0x116FC4E6)
  RemoveAllPickupsOfType(0xE4BD2FC6)
  RemoveAllPickupsOfType(0xDE58E0B3)
  RemoveAllPickupsOfType(0x77F3F2DD)
  RemoveAllPickupsOfType(0xC02CF125)
  RemoveAllPickupsOfType(0x881AB0A8)
  RemoveAllPickupsOfType(0x84837FD7)
  RemoveAllPickupsOfType(0xF25A01B9)
  RemoveAllPickupsOfType(0x815D66E8)
  RemoveAllPickupsOfType(0xFA51ABF5)
  RemoveAllPickupsOfType(0xC5B72713)
  RemoveAllPickupsOfType(0x5307A4EC)
  RemoveAllPickupsOfType(0x9CF13918)
  RemoveAllPickupsOfType(0x0968339D)
  RemoveAllPickupsOfType(0xBFEE6C3B)
  RemoveAllPickupsOfType(0xEBF89D5F)
  RemoveAllPickupsOfType(0x22B15640)
  RemoveAllPickupsOfType(0x763F7121)
  RemoveAllPickupsOfType(0xF92F486C)
  RemoveAllPickupsOfType(0x602941D0)
  RemoveAllPickupsOfType(0x31EA45C9)
  RemoveAllPickupsOfType(0xBED46EC5)
  RemoveAllPickupsOfType(0x079284A9)
  RemoveAllPickupsOfType(0xE175C698)
  RemoveAllPickupsOfType(0x624F7213)
  RemoveAllPickupsOfType(0xC01EB678)
  RemoveAllPickupsOfType(0x5C517D97)
  RemoveAllPickupsOfType(0xBD4DE242)
  RemoveAllPickupsOfType(0xE013E01C)
  RemoveAllPickupsOfType(0x789576E2)
  RemoveAllPickupsOfType(0xFD9CAEDE)
  RemoveAllPickupsOfType(0x8ADDEC75)
    end
end)

local recoils = {


	-- pistols
	[416676503] = 0.60,

	--smg
	[-957766203] = 0.50,

	-- rifles
	[0xBFEFFF6D] = 0,

}


local myRecoilFactor = 0.0
RegisterNetEvent("recoil:updateposition")
AddEventHandler("recoil:updateposition", function(sendFactor)

    myRecoilFactor = sendFactor / 5 + 0.0

end)


function quickmafs(dir)
	local x = 0.0
	local y = 0.0
	local dir = dir
	if dir >= 0.0 and dir <= 90.0 then
		local factor = (dir/9.2) / 10
		x = -1.0 + factor
		y = 0.0 - factor
	end

	if dir > 90.0 and dir <= 180.0 then
		dirp = dir - 90.0
		local factor = (dirp/9.2) / 10
		x = 0.0 + factor
		y = -1.0 + factor
	end

	if dir > 180.0 and dir <= 270.0 then
		dirp = dir - 180.0
		local factor = (dirp/9.2) / 10
		x = 1.0 - factor
		y = 0.0 + factor
	end

	if dir > 270.0 and dir <= 360.0 then
		dirp = dir - 270.0
		local factor = (dirp/9.2) / 10	
		x = 0.0 - factor
		y = 1.0 - factor
	end
	return x,y
end

Citizen.CreateThread( function()

	
	while true do 

		 if IsPedArmed(PlayerPedId(), 6) then
		 	Citizen.Wait(1)
		 else
		 	Citizen.Wait(1500)
		 end  

	    if IsPedShooting(PlayerPedId()) then
	    	local ply = PlayerPedId()
	    	local GamePlayCam = GetFollowPedCamViewMode()
	    	local Vehicled = IsPedInAnyVehicle(ply, false)
	    	local MovementSpeed = math.ceil(GetEntitySpeed(ply))

	    	if MovementSpeed > 69 then
	    		MovementSpeed = 69
	    	end

	        local _,wep = GetCurrentPedWeapon(ply)

	        local group = GetWeapontypeGroup(wep)

	        local p = GetGameplayCamRelativePitch()

	        local cameraDistance = #(GetGameplayCamCoord() - GetEntityCoords(ply))

	        local recoil = math.random(100,140+MovementSpeed)/100
	        local rifle = false


          	if group == 970310034 then
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
	        	recoil = recoil * 0.8
	        end

	        if GamePlayCam == 4 then

	        	recoil = recoil * 0.7
		        if rifle then
		        	recoil = recoil * 0.1
		        end

	        end

	        if rifle then
	        	recoil = recoil * 0.7
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

	       	
	      -- 	print(GetGameplayCamRelativePitch())

	    end
	end

end)

-- Crosshair Kapatma Kodlari Client Tarafli

-- Citizen.CreateThread(function()
-- 	local isSniper = false
-- 	while true do
-- 		Citizen.Wait(0)

--     	local ped = PlayerPedId()
-- 		local currentWeaponHash = GetSelectedPedWeapon(ped)

-- 		if currentWeaponHash == 100416529 then
-- 			isSniper = true
-- 		elseif currentWeaponHash == 205991906 then
-- 			isSniper = true
-- 		elseif currentWeaponHash == -952879014 then
-- 			isSniper = true
-- 		elseif currentWeaponHash == GetHashKey('WEAPON_HEAVYSNIPER_MK2') then
-- 			isSniper = true
-- 		else
-- 			isSniper = false
-- 		end

-- 		if not isSniper then
-- 			HideHudComponentThisFrame(14)
-- 		end
-- 	end
-- end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed( -1 )
        local weapon = GetSelectedPedWeapon(ped)
    
        if IsPedArmed(ped, 6) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
    
    
        if weapon == GetHashKey("WEAPON_FIREEXTINGUISHER") then   
            if IsPedShooting(ped) then
                SetPedInfiniteAmmo(ped, true, GetHashKey("WEAPON_FIREEXTINGUISHER"))
            end
        end
    end
end)