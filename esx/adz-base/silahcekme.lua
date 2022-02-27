Config 				  = {}
Config.CooldownPolice = 1000
Config.cooldown		  = 1700

-- ANİMASYONU OLAN SILAHLAR 
Config.Weapons = {
	"WEAPON_KNIFE",
	"WEAPON_PISTOL",
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_FLAREGUN",
	"WEAPON_STUNGUN",
	"WEAPON_REVOLVER",
}


local weapons = {
	'WEAPON_KNIFE',
	'WEAPON_NIGHTSTICK',
	'WEAPON_BREAD',
	'WEAPON_FLASHLIGHT',
	'WEAPON_HAMMER',
	'WEAPON_BAT',
	'WEAPON_GOLFCLUB',
	'WEAPON_CROWBAR',
	'WEAPON_BOTTLE',
	'WEAPON_DAGGER',
	'WEAPON_HATCHET',
	'WEAPON_MACHETE',
	'WEAPON_SWITCHBLADE',
	'WEAPON_BATTLEAXE',
	'WEAPON_POOLCUE',
	'WEAPON_WRENCH',
	'WEAPON_PISTOL',
	'WEAPON_PISTOL_MK2',
	'WEAPON_COMBATPISTOL',
	'WEAPON_APPISTOL',
	'WEAPON_PISTOL50',
	'WEAPON_REVOLVER',
	'WEAPON_SNSPISTOL',
	'WEAPON_HEAVYPISTOL',
	'WEAPON_VINTAGEPISTOL',
	'WEAPON_MICROSMG',
	'WEAPON_SMG',
	'WEAPON_ASSAULTSMG',
	'WEAPON_MINISMG',
	'WEAPON_MACHINEPISTOL',
	'WEAPON_COMBATPDW',
	'WEAPON_PUMPSHOTGUN',
	'WEAPON_SAWNOFFSHOTGUN',
	'WEAPON_ASSAULTSHOTGUN',
	'WEAPON_BULLPUPSHOTGUN',
	'WEAPON_HEAVYSHOTGUN',
	'WEAPON_ASSAULTRIFLE',
	'WEAPON_CARBINERIFLE',
	'WEAPON_ADVANCEDRIFLE',
	'WEAPON_SPECIALCARBINE',
	'WEAPON_BULLPUPRIFLE',
	'WEAPON_COMPACTRIFLE',
	'WEAPON_MG',
	'WEAPON_COMBATMG',
	'WEAPON_GUSENBERG',
	'WEAPON_SNIPERRIFLE',
	'WEAPON_HEAVYSNIPER',
	'WEAPON_MARKSMANRIFLE',
	'WEAPON_GRENADELAUNCHER',
	'WEAPON_RPG',
	'WEAPON_STINGER',
	'WEAPON_MINIGUN',
	'WEAPON_GRENADE',
	'WEAPON_STICKYBOMB',
	'WEAPON_SMOKEGRENADE',
	'WEAPON_BZGAS',
	'WEAPON_MOLOTOV',
	'WEAPON_DIGISCANNER',
	'WEAPON_FIREWORK',
	'WEAPON_MUSKET',
	'WEAPON_STUNGUN',
	'WEAPON_HOMINGLAUNCHER',
	'WEAPON_PROXMINE',
	'WEAPON_FLAREGUN',
	'WEAPON_MARKSMANPISTOL',
	'WEAPON_RAILGUN',
	'WEAPON_DBSHOTGUN',
	'WEAPON_AUTOSHOTGUN',
	'WEAPON_COMPACTLAUNCHER',
	'WEAPON_PIPEBOMB',
	'WEAPON_DOUBLEACTION',
}

-- Wheapons that require the Police holster animation
local holsterableWeapons = {
	--'WEAPON_STUNGUN',
	'WEAPON_PISTOL',
	'WEAPON_PISTOL_MK2',
	'WEAPON_COMBATPISTOL',
	'WEAPON_APPISTOL',
	'WEAPON_PISTOL50',
	'WEAPON_REVOLVER',
	'WEAPON_SNSPISTOL',
	'WEAPON_HEAVYPISTOL',
	'WEAPON_VINTAGEPISTOL'
}

local holstered = true
local canFire = true
local currWeapon = GetHashKey('WEAPON_UNARMED')
local currentHoldster = nil

local ESX      	 = nil
local PlayerData = {}
------------------------

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(200)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(200)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
	AddEventHandler('esx:setJob', function(job)
  		PlayerData.job = job
	end)

 Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if DoesEntityExist(ped) and not IsEntityDead(ped) then
			if currWeapon ~= GetSelectedPedWeapon(PlayerPedId()) then
				pos = GetEntityCoords(PlayerPedId(), true)
				rot = GetEntityHeading(PlayerPedId())

				local newWeap = GetSelectedPedWeapon(PlayerPedId())
				SetCurrentPedWeapon(PlayerPedId(), currWeapon, true)
				loadAnimDict("reaction@intimidation@1h")
				loadAnimDict("reaction@intimidation@cop@unarmed")
				loadAnimDict("rcmjosh4")
				loadAnimDict("weapons@pistol@")
				if CheckWeapon(newWeap) then
					if holstered then
						if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
							--TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
							canFire = false
							currentHoldster = GetPedDrawableVariation(PlayerPedId(), 7)
							TaskPlayAnimAdvanced(PlayerPedId(), "rcmjosh4", "josh_leadout_cop2", GetEntityCoords(PlayerPedId(), true), 0, 0, rot, 3.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(300)
							SetCurrentPedWeapon(PlayerPedId(), newWeap, true)

							if IsWeaponHolsterable(newWeap) then
								if currentHoldster == 8 then
									SetPedComponentVariation(PlayerPedId(), 7, 2, 0, 2)
								elseif currentHoldster == 1 then
									SetPedComponentVariation(PlayerPedId(), 7, 3, 0, 2)
								elseif currentHoldster == 6 then
									SetPedComponentVariation(PlayerPedId(), 7, 5, 0, 2)
								end
							end
							currWeapon = newWeap
							Citizen.Wait(300)
							ClearPedTasks(PlayerPedId())
							holstered = false
							canFire = true
						else
							canFire = false
							TaskPlayAnimAdvanced(PlayerPedId(), "reaction@intimidation@1h", "intro", GetEntityCoords(PlayerPedId(), true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(1000)
							SetCurrentPedWeapon(PlayerPedId(), newWeap, true)
							currWeapon = newWeap
							Citizen.Wait(1400)
							ClearPedTasks(PlayerPedId())
							holstered = false
							canFire = true
						end
					elseif newWeap ~= currWeapon and CheckWeapon(currWeapon) then
						if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
							canFire = false

							TaskPlayAnimAdvanced(PlayerPedId(), "reaction@intimidation@cop@unarmed", "intro", GetEntityCoords(PlayerPedId(), true), 0, 0, rot, 3.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(500)

							if IsWeaponHolsterable(currWeapon) then
								SetPedComponentVariation(PlayerPedId(), 7, currentHoldster, 0, 2)
							end

							SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
							currentHoldster = GetPedDrawableVariation(PlayerPedId(), 7)

							TaskPlayAnimAdvanced(PlayerPedId(), "rcmjosh4", "josh_leadout_cop2", GetEntityCoords(PlayerPedId(), true), 0, 0, rot, 3.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(300)
							SetCurrentPedWeapon(PlayerPedId(), newWeap, true)

							if IsWeaponHolsterable(newWeap) then
								if currentHoldster == 8 then
									SetPedComponentVariation(PlayerPedId(), 7, 2, 0, 2)
								elseif currentHoldster == 1 then
									SetPedComponentVariation(PlayerPedId(), 7, 3, 0, 2)
								elseif currentHoldster == 6 then
									SetPedComponentVariation(PlayerPedId(), 7, 5, 0, 2)
								end
							end

							Citizen.Wait(500)
							currWeapon = newWeap
							ClearPedTasks(PlayerPedId())
							holstered = false
							canFire = true
						else
							canFire = false
							TaskPlayAnimAdvanced(PlayerPedId(), "reaction@intimidation@1h", "outro", GetEntityCoords(PlayerPedId(), true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(1600)
							SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
							TaskPlayAnimAdvanced(PlayerPedId(), "reaction@intimidation@1h", "intro", GetEntityCoords(PlayerPedId(), true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(1000)
							SetCurrentPedWeapon(PlayerPedId(), newWeap, true)
							currWeapon = newWeap
							Citizen.Wait(1400)
							ClearPedTasks(PlayerPedId())
							holstered = false
							canFire = true
						end
					else
						if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
							SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
							currentHoldster = GetPedDrawableVariation(PlayerPedId(), 7)
							TaskPlayAnimAdvanced(PlayerPedId(), "rcmjosh4", "josh_leadout_cop2", GetEntityCoords(PlayerPedId(), true), 0, 0, rot, 3.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(300)
							SetCurrentPedWeapon(PlayerPedId(), newWeap, true)

							if IsWeaponHolsterable(newWeap) then
								if currentHoldster == 8 then
									SetPedComponentVariation(PlayerPedId(), 7, 2, 0, 2)
								elseif currentHoldster == 1 then
									SetPedComponentVariation(PlayerPedId(), 7, 3, 0, 2)
								elseif currentHoldster == 6 then
									SetPedComponentVariation(PlayerPedId(), 7, 5, 0, 2)
								end
							end

							currWeapon = newWeap
							Citizen.Wait(300)
							ClearPedTasks(PlayerPedId())
							holstered = false
							canFire = true
						else
							SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
							TaskPlayAnimAdvanced(PlayerPedId(), "reaction@intimidation@1h", "intro", GetEntityCoords(PlayerPedId(), true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(1000)
							SetCurrentPedWeapon(PlayerPedId(), newWeap, true)
							currWeapon = newWeap
							Citizen.Wait(1400)
							ClearPedTasks(PlayerPedId())
							holstered = false
							canFire = true
						end
					end
				else
					if not holstered and CheckWeapon(currWeapon) then
						if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
							canFire = false
							TaskPlayAnimAdvanced(PlayerPedId(), "reaction@intimidation@cop@unarmed", "intro", GetEntityCoords(PlayerPedId(), true), 0, 0, rot, 3.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(500)
							
							if IsWeaponHolsterable(currWeapon) then
								SetPedComponentVariation(PlayerPedId(), 7, currentHoldster, 0, 2)
							end

							SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
							ClearPedTasks(PlayerPedId())
							SetCurrentPedWeapon(PlayerPedId(), newWeap, true)
							holstered = true
							canFire = true
							currWeapon = newWeap
						else
							canFire = false
							TaskPlayAnimAdvanced(PlayerPedId(), "reaction@intimidation@1h", "outro", GetEntityCoords(PlayerPedId(), true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
							Citizen.Wait(1400)
							SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
							ClearPedTasks(PlayerPedId())
							SetCurrentPedWeapon(PlayerPedId(), newWeap, true)
							holstered = true
							canFire = true
							currWeapon = newWeap
						end
					else
						SetCurrentPedWeapon(PlayerPedId(), newWeap, true)
						holstered = false
						canFire = true
						currWeapon = newWeap
					end
				end
			end
		else
			Citizen.Wait(250)
		end

		Citizen.Wait(5)
	end
end)


Citizen.CreateThread(function()
	while true do
		if not canFire then
			DisableControlAction(0, 25, true)
			DisablePlayerFiring(PlayerPedId(), true)
		else
			Citizen.Wait(250)
		end

		Citizen.Wait(3)
	end
end)

function CheckWeapon(newWeap)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == newWeap then
			return true
		end
	end
	return false
end

function IsWeaponHolsterable(weap)
	for i = 1, #holsterableWeapons do
		if GetHashKey(holsterableWeapons[i]) == weap then
			return true
		end
	end
	return false
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end
