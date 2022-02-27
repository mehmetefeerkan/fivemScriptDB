ESX = nil


Weapons = {  -- Blacklistte bulunan silahları buraya giriyoruz.Silah kodlarına buradan ulaşabilirsiniz. / https://wiki.rage.mp/index.php?title=Weapons

    "WEAPON_COMBATPISTOL",
    "WEAPON_SMG",
    "WEAPON_CARBINERIFLE",
    "WEAPON_PUMPSHOTGUN",
    "WEAPON_STUNGUN",
    "WEAPON_ASSAULTSMG",

}

Jobs = { -- Whitelistte bulnacak meslekleri buraya yazıyoruz.

    "police",
    "sheriff",
    "fbi",

}

--[[

BU SCRIPT Kaves#0359 TARAFINDAN YAZILMIŞTIR.
THIS SCRIPT WAS WRITTEN BY Kaves#0359

]]--

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
    PlayerData = ESX.GetPlayerData()
    
    isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
    isPlayerWhitelisted = refreshPlayerWhitelisted()
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local player = PlayerPedId()
        if not isPlayerWhitelisted then
            for k,v in pairs(Weapons) do
                local player = PlayerPedId()
                local weapon = GetHashKey(v)
                if HasPedGotWeapon(player, weapon, false) == 1 then
                    RemoveWeaponFromPed(player, weapon)
                end
            end
        end
    end
end)


function refreshPlayerWhitelisted()
	if not ESX.PlayerData then
		return false
	end

	if not ESX.PlayerData.job then
		return false
	end

	for k,v in ipairs(Jobs) do
		if v == ESX.PlayerData.job.name then
			return true
		end
	end

	return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DisableControlAction(1, 140, true)
        if IsPlayerFreeAiming(PlayerId()) then
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
    local ped = PlayerPedId()
    if IsPedArmed(ped, 6) then
    DisableControlAction(1, 140, true)
    DisableControlAction(1, 141, true)
    DisableControlAction(1, 142, true)
    end
    end
    end)

    Citizen.CreateThread(function()
        while true do
          Citizen.Wait(1)
          RemoveAllPickupsOfType(0xDF711959)
          RemoveAllPickupsOfType(0xF9AFB48F)
          RemoveAllPickupsOfType(0xA9355DCD)
        end
      end)