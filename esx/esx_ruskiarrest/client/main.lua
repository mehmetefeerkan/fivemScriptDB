--Skrypt By Ruski, Contact Information @Ruski#0001 on Discord, Made For PlanetaRP 

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
local PracaPolice 				= 'police'	-- Job needed to arrest

local Aresztuje					= false		-- Zostaw na False innaczej bedzie aresztowac na start Skryptu
local Aresztowany				= false		-- Zostaw na False innaczej bedziesz Arresztowany na start Skryptu
 
local SekcjaAnimacji			= 'mp_arrest_paired'	-- Sekcja Katalogu Animcji
local AnimAresztuje 			= 'cop_p2_back_left'	-- Animacja Aresztujacego
local AnimAresztowany			= 'crook_p2_back_left'	-- Animacja Aresztowanego
local OstatnioAresztowany		= 0						-- Mozna sie domyslec ;)
local playerPed = PlayerPedId()

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

RegisterNetEvent('esx_ruski_areszt:aresztowany')
AddEventHandler('esx_ruski_areszt:aresztowany', function(target)
	Aresztowany = true

	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	RequestAnimDict(SekcjaAnimacji)

	while not HasAnimDictLoaded(SekcjaAnimacji) do
		Citizen.Wait(10)
	end

	AttachEntityToEntity(PlayerPedId(), targetPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
	TaskPlayAnim(playerPed, SekcjaAnimacji, AnimAresztowany, 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(950)
	DetachEntity(PlayerPedId(), true, false)

	Aresztowany = false
end)

RegisterNetEvent('esx_ruski_areszt:aresztuj')
AddEventHandler('esx_ruski_areszt:aresztuj', function()
	local playerPed = PlayerPedId()

	RequestAnimDict(SekcjaAnimacji)

	while not HasAnimDictLoaded(SekcjaAnimacji) do
		Citizen.Wait(10)
	end

	TaskPlayAnim(playerPed, SekcjaAnimacji, AnimAresztuje, 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(3000)

	Aresztuje = false

end)

-- Glówna Funkcja Animacji
Citizen.CreateThread(function()
	while true do
		Wait(0)

		if IsControlPressed(0, Keys['LEFTSHIFT']) and IsControlPressed(0, Keys['U']) and not Aresztuje and GetGameTimer() - OstatnioAresztowany > 10 * 1000 and PlayerData.job.name == PracaPolice then	-- Mozesz tutaj zmienic przyciski
			Citizen.Wait(10)
			local closestPlayer, distance = ESX.Game.GetClosestPlayer()

			if distance ~= -1 and distance <= Config.ArrestDistance and not Aresztuje and not Aresztowany and not IsPedInAnyVehicle(PlayerPedId()) and not IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) then
				Aresztuje = true
				OstatnioAresztowany = GetGameTimer()

				ESX.ShowNotification("~b~Aresztujesz Obywatela~r~ " .. GetPlayerServerId(closestPlayer) .. "")						-- Drukuje Notyfikacje
				TriggerServerEvent('esx_ruski_areszt:startAreszt', GetPlayerServerId(closestPlayer))									-- Rozpoczyna Funkcje na Animacje (Cala Funkcja jest Powyzej^^^)

				Citizen.Wait(2100)																									-- Czeka 2.1 Sekund
				TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'cuffseffect', 0.7)									-- Daje Effekt zakuwania (Wgrywasz Plik .ogg do InteractSound'a i ustawiasz nazwe "cuffseffect.ogg")

				Citizen.Wait(3100)																									-- Czeka 3.1 Sekund
				ESX.ShowNotification("~b~Zaresztowano Obywatela ~r~ " .. GetPlayerServerId(closestPlayer) .. "")					-- Drukuje Notyfikacje
				TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))									-- Zakuwa Poprzez Prace esx_policejob, Mozna zmienic Funkcje na jaka kolwiek inna.	
			end
		end
	end
end)