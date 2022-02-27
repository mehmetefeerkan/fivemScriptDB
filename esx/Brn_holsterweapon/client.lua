local ESX      	 = nil
local holstered  = true
local blocked	 = false
local cekili = false
local PlayerData = {}

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

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		loadAnimDict("rcmjosh4")
		loadAnimDict("reaction@intimidation@cop@unarmed")
		loadAnimDict("reaction@intimidation@1h")
		local ped = PlayerPedId()

		if cekili == true then
			print('Elinde silahin bugda kaldiysa ve çözemiyorsan BrnOrkun#3131') -- Sıkıntı olmadığından emin olunca kaldır
			--exports['mythic_notify']:DoHudText('Error', 'Silahı Çektin')
			Citizen.Wait(500)
			cekili = false
			blocked = false
		else

			if PlayerData.job ~= nil and PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff' then -- polis mesleğindeyse
				if not IsPedInAnyVehicle(ped, false) then
					if CheckWeapon(ped) then
						if holstered == true then -- silahı çekme
							blocked = true
							SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
							TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 ) -- Change 50 to 30 if you want to stand still when removing weapon
							--Citizen.Wait(Config.CooldownPolice)
							SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
							exports['mythic_notify']:DoHudText('Inform', 'Silah Elinde')
							TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
							Citizen.Wait(400)
							ClearPedTasks(ped)
							holstered = false
							cekili = true
							TriggerServerEvent('imperial:brnlog:holster', "Çekti.", "su an icin yok")
						else
							cekili = false
							blocked = false
						end
					else
						if holstered == false then -- silahı geri götüne sokma animasyonu
							cekili = true
							TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
							exports['mythic_notify']:DoHudText('Inform', 'Silah Belinde')
							Citizen.Wait(500)
							TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 ) -- Change 50 to 30 if you want to stand still when holstering weapon
							--TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 30, 2.0, 0, 0, 0 ) Use this line if you want to stand still when holstering weapon
							Citizen.Wait(60)
							ClearPedTasks(ped)
							cekili = true
							holstered = true
							TriggerServerEvent('imperial:brnlog:holster', "götüne soktu.", "su an icin yok")
						end
					end

				else
					holstered = true
				end
			else -- polis değilse
				if not IsPedInAnyVehicle(ped, false) then
					if CheckWeapon(ped) then
						if holstered == true then -- götünden silah çıkarma
							blocked = true
							SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
							TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 5.0, 1.0, -1, 50, 0, 0, 0, 0 )
							exports['mythic_notify']:DoHudText('Inform', 'Silah Elinde')
							--TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 5.0, 1.0, -1, 30, 0, 0, 0, 0 ) Use this line if you want to stand still when removing weapon
							Citizen.Wait(1250)
							SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
							Citizen.Wait(Config.cooldown)
							ClearPedTasks(ped)
							holstered = false
							cekili = true
							TriggerServerEvent('imperial:brnlog:holster', " çekti.", "su an icin yok")
						else
							cekili = false
							blocked = false
						end
					else
						if holstered == false then
							TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 3.0, -1, 50, 0, 0, 0.125, 0 ) -- Change 50 to 30 if you want to stand still when holstering weapon
							exports['mythic_notify']:DoHudText('Inform', 'Silah Belinde')
							--TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 3.0, -1, 30, 0, 0, 0.125, 0 ) Use this line if you want to stand still when holstering weapon
								Citizen.Wait(1700)
							ClearPedTasks(ped)
						holstered = true
						TriggerServerEvent('imperial:brnlog:holster', "ı götüne soktu.", "su an icin yok")
						end
					end
				else
					holstered = true
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if blocked then
			DisableControlAction(1, 25, true )
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 23, true)
			DisableControlAction(1, 37, true)
			DisablePlayerFiring(ped, true)
			DisableControlAction(1, 157, true)
			DisableControlAction(1, 158, true)
			DisableControlAction(1, 160, true)
			DisableControlAction(1, 164, true)
			DisableControlAction(1, 165, true)
		end
	end
end)

function CheckWeapon(ped)
	if IsEntityDead(ped) then
		blocked = false
			return false
		else
			for i = 1, #Config.Weapons do
				if GetHashKey(Config.Weapons[i]) == GetSelectedPedWeapon(ped) then
					return true
				end
			end
		return false
	end
end

function loadAnimDict(dict)
	while ( not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end