-- 2018 Henric 'Kekke' Johansson

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX               				= nil

local PlayerData                = {}
local PoliceJob 				= 'police'

local isTackling				= false
local isGettingTackled			= false


local tackleLib					= 'missmic2ig_11'
local tackleAnim 				= 'mic_2_ig_11_intro_goon'
local tackleVictimAnim			= 'mic_2_ig_11_intro_p_one'

local lastTackleTime			= 0
local isRagdoll					= false



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isRagdoll then
			SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
		end
	end
end)

RegisterNetEvent('esx_kekke_tackle:getTackled') -- karşı oyuncu
AddEventHandler('esx_kekke_tackle:getTackled', function(target)
	isGettingTackled = true
	isRagdoll = true
	Citizen.Wait(4000)
	isRagdoll = false
	isGettingTackled = false
end)

RegisterNetEvent('esx_kekke_tackle:playTackle') -- yapan
AddEventHandler('esx_kekke_tackle:playTackle', function()
	local playerPed = PlayerPedId()
	RequestAnimDict("swimming@first_person@diving")
	while not HasAnimDictLoaded("swimming@first_person@diving") do
		Citizen.Wait(1)
	end

	if IsEntityPlayingAnim(playerPed, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 3) then
		ClearPedSecondaryTask(playerPed)
	else
		TaskPlayAnim(playerPed, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 8.0, -8, -1, 49, 0, 0, 0, 0)
			seccount = 3
			while seccount > 0 do
				Citizen.Wait(100)
				seccount = seccount - 1
			end
			ClearPedSecondaryTask(playerPed)
			SetPedToRagdoll(PlayerPedId(), 150, 150, 0, 0, 0, 0) 
		end	
	isRagdoll = true

	Citizen.Wait(500)

	isRagdoll = false
	isTackling = false
end)



-- Main thread
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlPressed(0, Keys['LEFTSHIFT']) and IsControlPressed(0, Keys['G']) and not isTackling and GetGameTimer() - lastTackleTime > 5 * 1000 and (PlayerData.job.name == 'police' or PlayerData.job.name == 'sheriff') then
			Citizen.Wait(10)
			local closestPlayer, distance = ESX.Game.GetClosestPlayer()
			if distance ~= -1 and distance <= Config.TackleDistance and not isTackling and not isGettingTackled and not IsPedInAnyVehicle(PlayerPedId()) and not IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) then
				-- if IsPedJumping(PlayerPedId()) then
					isTackling = true
					lastTackleTime = GetGameTimer()
					TriggerServerEvent('esx_kekke_tackle:tryTackle', GetPlayerServerId(closestPlayer))
				-- end
			end
		end
	end
end)