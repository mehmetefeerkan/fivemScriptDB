ESX = nil
shopid = nil
robstarted = false
robx = nil
roby = nil
robz = nil
local brn = false
local soygunbasladi = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()

    spawnSafes()
end)

local safes = {
	[1] = {number = 1, x = 380.74, y = 331.94, z = 103.5, heading = 255.47},	
	[2] = {number = 4, x = -1478.97, y = -374.36, z = 39.08, heading = 228.54},
	[3] = {number = 5, x = 1395.49, y = 3612.94, z = 34.93, heading = 22.18},
	[4] = {number = 6, x = -2959.5, y = 387.78, z =13.96 , heading = 171.58},	
	[5] = {number = 8, x = -42.76, y = -1749.36, z = 29.44, heading = 320.15},
	[6] = {number = 9, x = 1160.77, y = -314.03, z = 69.18, heading = 10.81},
	[7] = {number = 10, x = -708.14, y = -904.05, z =19.17 , heading = 5.29},
	[8] = {number = 14, x = 1126.26, y = -980.84, z = 45.35, heading = 9.13},
	[9] = {number = 15, x = 30.45, y = -1339.88, z = 29.44 , heading = 269.79},
	[10] = {number = 19, x = 1168.51, y = 2718.37, z = 37.10, heading = 271.45},
	[11] = {number = 20, x = 1736.66, y = 6419.02, z = 34.96, heading = 247.6},
	-- [16] = {number = 16, x = -1383.59, y = -630.25, z = 30.12, heading = 213.19},
	-- [17] = {number = 17, x = 545.07, y = 2663.47, z = 42.1, heading = 96.45},
	-- [18] = {number = 18, x = -3249.02, y = 1006.04, z = 12.78, heading = 0.76},
	-- [11] = {number = 11, x = -1828.23, y = 799.83, z = 138.1, heading = 53.63},
	-- [12] = {number = 12, x = 1706.87, y = 4919.76, z = 42.0, heading = 237.41},
	-- [13] = {number = 13, x = 1960.75, y = 3748.67, z = 32.27, heading = 304.34},
	-- [7] = {number = 7, x = 2674.36, y = 3288.0, z = 55.22, heading = 339.44},
	-- [2] = {number = 2, x = 2550.23, y = 387.34, z = 108.65, heading = 359.25},
	-- [3] = {number = 3, x = -3047.88, y = 588.16, z = 7.94, heading = 20.34},
}

function spawnSafes()
	for i=1, #safes, 1 do
		local coords = {
			x = safes[i].x,
			y = safes[i].y,
			z = safes[i].z - 1,
		}
		local safe = CreateObject(1089807209, coords.x, coords.y, coords.z, 0, 0, 0)
		SetEntityHeading(safe, safes[i].heading)
		FreezeEntityPosition(safe, true)
	end
end

Citizen.CreateThread(function()
	while true do
		local wait = 750
		for i=1, #safes, 1 do
			local ped = GetPlayerPed(-1)
			local pedCoords = GetEntityCoords(ped)
			pedDistance = GetDistanceBetweenCoords(pedCoords, safes[i].x, safes[i].y, safes[i].z - 1, false)
			if pedDistance <= 3.0 then
				DrawText3D(safes[i].x, safes[i].y, safes[i].z, '[E] Kasayı Aç')
				if IsControlJustReleased(0, 38) then
					if GetCurrentResourceName() == 'm3_shoprobbery' then
						openSafe(safes[i].number, safes[i].x, safes[i].y, safes[i].z - 1)
					else
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Scriptin adı m3_shoprobbery olarak ayarlanmalı!'})
					end
				end
				wait = 5
			end
		end
		Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
	while true do
		local sleepThread = 3000
		if robstarted then
			sleepThread = 10
			local ped = GetPlayerPed(-1)
			local pedCoords = GetEntityCoords(ped)
			distance = GetDistanceBetweenCoords(pedCoords, robx, roby, robz, false)
			if distance >= 15 then
				EndMinigame(false)
			end
		else
			sleepThread = 3000
		end
		Citizen.Wait(sleepThread)
	end
end)

DrawText3D = function(x, y, z, text)
    local onScreen,x,y = World3dToScreen2d(x, y, z)
    local factor = #text / 370

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(x,y)
        DrawRect(x,y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 120)
    end
end

function openSafe(id, x, y, z)
	local ped = GetPlayerPed(-1)
	ESX.TriggerServerCallback("brn:isRobbingPossible", function(cooldownRob)
	if not cooldownRob then
	ESX.TriggerServerCallback('m3:shoprobbery:copCount', function(cops)
		if cops >= Config.NeededCops then -- polis sayısı
			if IsPedArmed(ped, 4) then
				ESX.TriggerServerCallback('m3:shoprobbery:getTime', function(time)
					ESX.TriggerServerCallback('m3:shoprobbery:getShops', function(shops)
						-- for i=1, #shops, 1 do
							local remainingtime = time - shops.robtime
							if time - shops.robtime <= 7200 then
								TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Bu dükkanın soyulabilmesi için ' .. math.floor((7200 - remainingtime) / 60) .. ' dakika gerekiyor!' })
							elseif time - shops.robtime >= 7200 then
								-- local data = exports['m3_base']:getOsTime()
                            	-- if data.hour > data.min or data.hour < data.max then
									local ped = PlayerPedId()
            						local playerPos = GetEntityCoords(ped)
						
									local gender = "Bilinmiyor"
                    				local model = GetEntityModel(ped)
                    				if (model == GetHashKey("mp_f_freemode_01")) then
                        				gender = "Kadın"
                    				end
                    				if (model == GetHashKey("mp_m_freemode_01")) then
                        				gender = "Erkek"
                    				end
									if soygunbasladi == false then

									if brn == false then
										TriggerServerEvent(
                        				"Brn_dispach:addCall",
                        				"10-40",
                        				"Market Soygunu",
                        				{{icon = "fa-venus-mars", info = gender}},
                        				{playerPos[1], playerPos[2], playerPos[3]},
                        				"police",
                        				5000,
                        				52,
                        				1
                    				)
									TriggerServerEvent(
                        				"Brn_dispach:addCall",
                        				"10-40",
                        				"Market Soygunu",
                        				{{icon = "fa-venus-mars", info = gender}},
                        				{playerPos[1], playerPos[2], playerPos[3]},
                        				"sheriff",
                       					5000,
                       					52,
                        				1
                    				)
									print('polis ve sherifflere bildirim gönderip brn\'yi true yaptım')
									end

									brn = true
									exports['mythic_progbar']:Progress({
										name = "startrob",
										duration = Config.StartSearchTime,
										label = 'Kasa kilidi kurcalanıyor...',
										useWhileDead = false,
										canCancel = false,
										controlDisables = {
											disableMovement = true,
											disableCarMovement = true,
											disableMouse = false,
											disableCombat = true,
										},
									}, function(cancelled)
										if not cancelled then
											robstarted = true
											robx = x
											roby = y
											robz = z
											SafeRewards = math.random(Config.SafeRewardMin, Config.SafeRewardMax)
											StartMinigame(SafeRewards)
											shopid = id
											brn = false
											soygunbasladi = true
											print ('soygun bitti brn false oldu')
										end
									end)
								else
									print('bu terslikte bir iş var')
								end
								-- else
								-- 	exports['mythic_notify']:SendAlert('error', 'Şu anda bunu yapamazsın!', 5000)
								-- end
							end
						-- end
					end, id)
				end)
			else
				TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Silahınız yok!'})
			end
		else
			TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Sehirde yeterli polis yok!'})
		end
	end)
	else 
		print('ne yapacağımı bilmiyorum :d')
	end
	end)
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2500)
		if robstarted then
			TriggerServerEvent('m3:shoprobbery:blipRobCop', robx, roby, robz)
			TriggerServerEvent('brn:CooldownRobbery')
		end
    end
end)

local bliptimer = 5 
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		if robstarted then
			bliptimer = bliptimer - 1
			if bliptimer == 0 then
				shopid = nil
				robstarted = false
				robx = nil
				roby = nil
				robz = nil
				bliptimer = 5
			end
		end
    end
end)

RegisterNetEvent('m3:shoprobbery:blipRobCopC')
AddEventHandler('m3:shoprobbery:blipRobCopC', function(x, y, z)
	local transT = 250
	local Blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(Blip,  162)
	SetBlipColour(Blip,  46)
	SetBlipAlpha(Blip,  transT)
	SetBlipScale(Blip, 1.5)
	SetBlipAsShortRange(Blip,  false)
	while transT ~= 0 do
		Wait(4)
		transT = transT - 1
		SetBlipAlpha(Blip,  transT)
		if transT == 0 then
			SetBlipSprite(Blip,  2)
			return
		end
	end
end)

function lockFinished(rewards)
	TriggerServerEvent('m3:shoprobbery:robbedUpdate', shopid)
	TriggerServerEvent('m3:shoprobbery:giveMoney', rewards)
end

-- jam minigame
function StartMinigame(rewards)

	local txd = CreateRuntimeTxd("JSCTextureDict")
	for i = 1, 2 do 
		CreateRuntimeTextureFromImage(txd, tostring(i), "LockPart" .. i .. ".PNG") 
	end

	MinigameOpen = true
	SoundID 	  = GetSoundId() 
	Timer 		  = GetGameTimer()

	if not RequestAmbientAudioBank("SAFE_CRACK", false) then 
		RequestAmbientAudioBank("SAFE_CRACK", false)
	end
	if not HasStreamedTextureDictLoaded("JSCTextureDict", false) then 
		RequestStreamedTextureDict("JSCTextureDict", false)
	end

	Citizen.CreateThread(function() 
		Update(rewards) 
	end)	
end

function Update(rewards)
	Citizen.CreateThread(function() 
		HandleMinigame(rewards) 
	end)
	while MinigameOpen do
		InputCheck()  
		if IsEntityDead(GetPlayerPed(PlayerId())) then 
			EndMinigame(false, false) 
		end
		Citizen.Wait(0)
	end
end

function InputCheck()

	local leftKeyPressed 	= IsControlPressed(0, 174) or 0 -- left arrow
	local rightKeyPressed 	= IsControlPressed(0, 175) or 0 -- right arrow
	if IsControlPressed(0, 113) then
		 EndMinigame(false) 
	end
	if IsControlPressed(0, 48) then -- z
		rotSpeed = 0.1 
		modifier = 33
	elseif IsControlPressed(0, 21) then --left shift
		rotSpeed = 1.0
		modifier = 50 
	else
		rotSpeed = 0.4 
		modifier = 90 
	end

    local lockRotation = math.max(modifier / rotSpeed, 0.1)

    if leftKeyPressed ~= 0 or rightKeyPressed ~= 0 then
    	LockRotation = LockRotation - (rotSpeed * tonumber(leftKeyPressed))
    	LockRotation = LockRotation + (rotSpeed * tonumber(rightKeyPressed))
    	if (GetGameTimer() - Timer) > lockRotation then 
    		PlaySoundFrontend(0, "tumbler_turn", "SAFE_CRACK_SOUNDSET", false)
    		Timer = GetGameTimer() 
    	end
    end
end

function HandleMinigame(rewards)

	local lockRot 		 = math.random(385.00, 705.00)	

	local lockNumbers 	 = {}
	local correctGuesses = {}

	lockNumbers[1] = 1
	lockNumbers[2] = math.random(				  45.0, 				359.0)
	lockNumbers[3] = math.random(lockNumbers[2] - 719.0, lockNumbers[2] - 405.0)
	lockNumbers[4] = math.random(lockNumbers[3] + 45.0, lockNumbers[3] + 359.0)

	-----------------------
	-- REDO LOCK NUMBERS --
	-----------------------
	-- Make numbers persist if chosen.
	-- Add number count for difficulty.
	-- Multiples of 2 are positive, 45 - 359;
	-- Multiples of 3 are negative, 719 - 405;
	-- Everything else is negative, 45 - 359;

	---------------------------------------------
	-- Still havn't done, you're welcome to ^^ --
	---------------------------------------------

	-- print("Here ya go, bloody cheater.")
	for i = 1,4 do
		print(math.floor((lockNumbers[i] % 360) / 3.60))
	end

	TriggerEvent('mythic_notify:client:SendLongAlert', { type = 'inform', text = 'Not defterinde kasanın şifrelerini buldun. (Bir tur sola) ' .. (math.floor((lockNumbers[1] % 360) / 3.60)) .. '. (Sağa) ' .. (math.floor((lockNumbers[2] % 360) / 3.60)) .. '. (Bir tur sola) ' .. (math.floor((lockNumbers[3] % 360) / 3.60)) .. '. (Sağa) ' .. (math.floor((lockNumbers[4] % 360) / 3.60)) .. '.', length = 85000})
	Citizen.Wait(10)
	TriggerEvent('mythic_notify:client:SendLongAlert', { type = 'inform', text = '"LeftShift" tuşu ile hızlandırabilir, "Z" tuşu ile yavaşlatabilirsiniz. "G" tuşu ile kapatabilirsiniz.', length = 54990})
	--------------------------------------
	-- Comment this out for a challenge --
	--------------------------------------

    local correctCount	= 1
    local hasRandomized	= false

    LockRotation = 0.0 + lockRot
								
	while MinigameOpen do	
		DrawSprite("JSCTextureDict", "1",  0.8,  0.5,  0.15,  0.26, -LockRotation, 255, 255, 255, 255)
		DrawSprite("JSCTextureDict", "2",  0.8,  0.5, 0.176, 0.306, -0.0, 255, 255, 255, 255)	

		hasRandomized = true

		local lockVal = math.floor(LockRotation)

		if correctCount > 1 and correctCount < 5 and lockVal + (Config.LockTolerance * 3.60) < lockNumbers[correctCount - 1] and lockNumbers[correctCount - 1] < lockNumbers[correctCount] then 
			EndMinigame(false)
			MinigameOpen = false
		elseif correctCount > 1 and correctCount < 5 and lockVal - (Config.LockTolerance * 3.60) > lockNumbers[correctCount - 1] and lockNumbers[correctCount - 1] > lockNumbers[correctCount] then 
			EndMinigame(false)
			MinigameOpen = false
		elseif correctCount > 4 then
			EndMinigame(true, rewards)
		end

		for k,v in pairs(lockNumbers) do
			  if not hasRandomized then 
				LockRotation = lockRot
			end
			if lockVal == v and correctCount == k then
				local canAdd = true
				for key,val in pairs(correctGuesses) do
					if val == lockVal and key == correctCount then
						canAdd = false
					end
				end

				if canAdd then 				
					PlaySoundFrontend(-1, "tumbler_pin_fall", "SAFE_CRACK_SOUNDSET", true)
					correctGuesses[correctCount] = lockVal
					correctCount = correctCount + 1; 
				end   				  			
			end
		end
		Citizen.Wait(0)
	end
end


function EndMinigame(won, rewards)
	MinigameOpen = false
	if won then
		PlaySoundFrontend(SoundID, "tumbler_pin_fall_final", "SAFE_CRACK_SOUNDSET", true)

		Citizen.Wait(100)

		PlaySoundFrontend(SoundID, "safe_door_open", "SAFE_CRACK_SOUNDSET", true)
		lockFinished(rewards)--
		TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Kasa açıldı!'})
		soygunbasladi = false	
	else	
		PlaySoundFrontend(SoundID, "tumbler_reset", "SAFE_CRACK_SOUNDSET", true)
		TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Kasayı açamadın!'})
		shopid = nil
		robstarted = false
		robx = nil
		roby = nil
		robz = nil
		bliptimer = 5
		soygunbasladi = false
	end
end
