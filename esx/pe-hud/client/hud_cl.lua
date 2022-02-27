ESX = nil
local showMap, showBars, showArmor, showOxygen, isOpen, movieHud, isPaused
local beepHealth, beepShield, beepHunger, beepThirst, beepStamina, beepOxygen
local healthActive, shieldActive, hungerActive, thirstActive, staminaActive, oxygenActive, microphoneActive, timeActive, movieActive, idActive
local healthSwitch, shieldSwitch, hungerSwitch, thirstSwitch, staminaSwitch, oxygenSwitch, microphoneSwitch, timeSwitch, movieSwitch, idSwitch
local whisper, normal, scream = 33, 66, 100 
local microphone = normal -- Change this for default

-- Main Thread
CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
		Wait(250)
	end
end)

CreateThread(function()
	while true do
		Wait(420)
        local health = nil
		local oxygen = 10 * GetPlayerUnderwaterTimeRemaining(PlayerId())
		local stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId())
		local armor, id = GetPedArmour(PlayerPedId()), GetPlayerServerId(PlayerId())
		local minutes, hours =  GetClockMinutes(), GetClockHours()
		local players = #GetActivePlayers() * 100 / Config.MaxPlayers
		if IsEntityDead(PlayerPedId()) then
			health = 0
		else
			health = GetEntityHealth(PlayerPedId()) - 100
		end
		if (oxygen <= 0) then
			oxygen = 0
		end
		if (minutes <= 9) then
			minutes = "0" .. minutes
		end
		if (hours <= 9) then
			hours = "0" .. hours
		end
		if Config.ShowArmour then
			if (armor <= 0) and not isPaused and not shieldSwitch and not movieHud then
					SendNUIMessage({action = 'armorHide'})
					shieldActive = true
					showArmor = true
			elseif (armor >= 1) and shieldActive and not shieldSwitch and not isPaused and not movieHud then
				SendNUIMessage({action = 'armorT'})
				shieldActive = false
				showArmor = false
			end
		end
		if Config.ShowOxygen then
			if IsEntityInWater(PlayerPedId()) and not isPaused and oxygenSwitch and not movieHud then
					SendNUIMessage({action = 'oxygenT'})
					oxygenActive = true
					showOxygen = true
			elseif not IsEntityInWater(PlayerPedId()) and oxygenActive and oxygenSwitch and not isPaused and not movieHud then
				SendNUIMessage({action = 'oxygenHide'})
				oxygenActive = false
				showOxygen = false
			end
		end
		if Config.BeepHud then
			if (health <= 35) and not (health == 0) and not beepHealth then
				SendNUIMessage({action = 'healthStart'})
				beepHealth = true
			else
				SendNUIMessage({action = 'healthStop'})
				beepHealth = false
			end
			if (armor <= 35) and not (armor == 0) and not beepShield then
				SendNUIMessage({action = 'armorStart'})
				beepShield = true
			else
				SendNUIMessage({action = 'armorStop'})
				beepShield = false
			end
			if (stamina <= 35) and not beepStamina then
				SendNUIMessage({action = 'staminaStart'})
				beepStamina = true
			else
				SendNUIMessage({action = 'staminaStop'})
				beepStamina = false
			end
			if (oxygen <= 35) and not (oxygen == 0) and not beepOxygen then
				SendNUIMessage({action = 'oxygenStart'})
				beepOxygen = true
			else
				SendNUIMessage({action = 'oxygenStop'})
				beepOxygen = false
			end
		end
		if IsPauseMenuActive() and not isPaused and not isOpen then
			if not healthActive then
				healthActive = true
				SendNUIMessage({action = 'healthHide'})
			end
			if not shieldActive then
				shieldActive = true
				SendNUIMessage({action = 'armorHide'})
			end
			if not hungerActive then
				hungerActive = true
				SendNUIMessage({action = 'hungerHide'})
			end
			if not thirstActive then
				thirstActive = true
				SendNUIMessage({action = 'thirstHide'})
			end
			if not staminaActive then
				staminaActive = true
				SendNUIMessage({action = 'staminaHide'})
			end
			if oxygenActive then
				oxygenActive = false
				SendNUIMessage({action = 'oxygenHide'})
			end
			if microphoneActive then
				microphoneActive = false
				SendNUIMessage({action = 'microphoneHide'})
			end
			if timeActive then
				timeActive = false
				SendNUIMessage({action = 'timeHide'})
			end
			if idActive then
				idActive = false
				SendNUIMessage({action = 'idHide'})
			end
			if movieActive then
				movieActive = false
				SendNUIMessage({action = 'movieHide'})
			end
			isPaused = true
		elseif not IsPauseMenuActive() and isPaused and not movieHud then
			if healthActive and not healthSwitch then
				healthActive = false
				SendNUIMessage({action = 'healthT'})
			end
			if shieldActive and not shieldSwitch and not showArmor then
				shieldActive = false
				SendNUIMessage({action = 'armorT'})
			end
			if hungerActive and not hungerSwitch then
				hungerActive = false
				SendNUIMessage({action = 'hungerT'})
			end
			if thirstActive and not thirstSwitch then
				thirstActive = false
				SendNUIMessage({action = 'thirstT'})
			end
			if staminaActive and not staminaSwitch then
				staminaActive = false
				SendNUIMessage({action = 'staminaT'})
			end
			if not oxygenActive and oxygenSwitch and showOxygen then
				oxygenActive = true
				SendNUIMessage({action = 'oxygenT'})
			end
			if not microphoneActive and microphoneSwitch then
				microphoneActive = true
				SendNUIMessage({action = 'microphoneT'})
			end
			if not timeActive and timeSwitch then
				timeActive = true
				SendNUIMessage({action = 'timeT'})
			end
			if not movieActive and movieSwitch then
				movieActive = true
				SendNUIMessage({action = 'movieT'})
			end
			if not idActive and idSwitch then
				idActive = true
				SendNUIMessage({action = 'idT'})
			end
			isPaused = false
		elseif not IsPauseMenuActive() and movieHud and isPaused then
			if not healthActive then
				healthActive = true
				SendNUIMessage({action = 'healthHide'})
			end
			if not shieldActive then
				shieldActive = true
				SendNUIMessage({action = 'armorHide'})
			end
			if not hungerActive then
				hungerActive = true
				SendNUIMessage({action = 'hungerHide'})
			end
			if not thirstActive then
				thirstActive = true
				SendNUIMessage({action = 'thirstHide'})
			end
			if not staminaActive then
				staminaActive = true
				SendNUIMessage({action = 'staminaHide'})
			end
			if oxygenActive then
				oxygenActive = false
				SendNUIMessage({action = 'oxygenHide'})
			end
			if microphoneActive then
				microphoneActive = false
				SendNUIMessage({action = 'microphoneHide'})
			end
			if timeActive then
				timeActive = false
				SendNUIMessage({action = 'timeHide'})
			end
			if idActive then
				idActive = false
				SendNUIMessage({action = 'idHide'})
			end
			movieActive = true
			SendNUIMessage({action = 'movieT'})
			isPaused = false
		end
		SendNUIMessage({
			action = "hud",
			health = health,
			armor = armor,
			hunger = hunger,
			thirst = thirst,
			stamina = stamina,
			oxygen = oxygen,
			id = id,
			players = players,
			time = hours .. " : " .. minutes
		})
	end
end)

CreateThread(function()
    while isOpen do
        Wait(100)
        DisableControlAction(0, 322, true)
    end
end)

-- NUI + Events
RegisterNUICallback('close', function(event)
	SendNUIMessage({ action = 'hide' })
	SetNuiFocus(false, false)
	isOpen = false
end)

RegisterNUICallback('change', function(data)
    TriggerEvent('PE:change', data.action)
end)

RegisterNetEvent('PE:change')
AddEventHandler('PE:change', function(action)
    if action == "health" then
		if not healthActive then
			healthActive = true
			healthSwitch = true
			SendNUIMessage({action = 'healthHide'})
		else
			healthActive = false
			healthSwitch = false
			SendNUIMessage({action = 'healthT'})
		end
    elseif action == "armor" then
		if not shieldActive then
			shieldActive = true
			shieldSwitch = true
			SendNUIMessage({action = 'armorHide'})
		else
			shieldActive = false
			shieldSwitch = false
			SendNUIMessage({action = 'armorT'})
		end
	elseif action == "hunger" then
		if not hungerActive then
			hungerActive = true
			hungerSwitch = true
			SendNUIMessage({action = 'hungerHide'})
		else
			hungerActive = false
			hungerSwitch = false
			SendNUIMessage({action = 'hungerT'})
		end
	elseif action == "thirst" then
		if not thirstActive then
			thirstActive = true
			thirstSwitch = true
			SendNUIMessage({action = 'thirstHide'})
		else
			thirstActive = false
			thirstSwitch = false
			SendNUIMessage({action = 'thirstT'})
		end
    elseif action == "stamina" then
		if not staminaActive then
			staminaActive = true
			staminaSwitch = true
			SendNUIMessage({action = 'staminaHide'})
		else
			staminaActive = false
			staminaSwitch = false
			SendNUIMessage({action = 'staminaT'})
		end
	elseif action == "oxygen" then
		if not oxygenActive then
			oxygenActive = true
			oxygenSwitch = true
			SendNUIMessage({action = 'oxygenT'})
		else
			oxygenActive = false
			oxygenSwitch = false
			SendNUIMessage({action = 'oxygenHide'})
		end
	elseif action == "id" then
		if not idActive then
			idActive = true
			idSwitch = true
			SendNUIMessage({action = 'idT'})
		else
			idActive = false
			idSwitch = false
			SendNUIMessage({action = 'idHide'})
		end
	elseif action == "map" then
		if not showMap then
			showMap = true
			DisplayRadar(true)
		else
			showMap = false
			DisplayRadar(false)
		end
	elseif action == "movie" then
		if not movieActive then
			movieActive = true
			movieSwitch = true
			movieHud = true
			if not healthActive then
				healthActive = true
				SendNUIMessage({action = 'healthHide'})
			end
			if not shieldActive then
				shieldActive = true
				SendNUIMessage({action = 'armorHide'})
			end
			if not hungerActive then
				hungerActive = true
				SendNUIMessage({action = 'hungerHide'})
			end
			if not thirstActive then
				thirstActive = true
				SendNUIMessage({action = 'thirstHide'})
			end
			if not staminaActive then
				staminaActive = true
				SendNUIMessage({action = 'staminaHide'})
			end
			if oxygenActive then
				oxygenActive = false
				SendNUIMessage({action = 'oxygenHide'})
			end
			if microphoneActive then
				microphoneActive = false
				SendNUIMessage({action = 'microphoneHide'})
			end
			if timeActive then
				timeActive = false
				SendNUIMessage({action = 'timeHide'})
			end
			if idActive then
				idActive = false
				SendNUIMessage({action = 'idHide'})
			end
			SendNUIMessage({action = 'movieT'})
		else
			movieActive = false
			movieSwitch = false
			movieHud = false
			if healthActive and not healthSwitch then
				healthActive = false
				SendNUIMessage({action = 'healthT'})
			end
			if shieldActive and not shieldSwitch and not showArmor then
				shieldActive = false
				SendNUIMessage({action = 'armorT'})
			end
			if hungerActive and not hungerSwitch then
				hungerActive = false
				SendNUIMessage({action = 'hungerT'})
			end
			if thirstActive and not thirstSwitch and not showArmor then
				thirstActive = false
				SendNUIMessage({action = 'thirstT'})
			end
			if staminaActive and not staminaSwitch then
				staminaActive = false
				SendNUIMessage({action = 'staminaT'})
			end
			if not oxygenActive and oxygenSwitch and showOxygen then
				oxygenActive = true
				SendNUIMessage({action = 'oxygenT'})
			end
			if not microphoneActive and microphoneSwitch then
				microphoneActive = true
				SendNUIMessage({action = 'microphoneT'})
			end
			if not timeActive and timeSwitch then
				timeActive = true
				SendNUIMessage({action = 'timeT'})
			end
			if not movieActive and movieSwitch then
				movieActive = true
				SendNUIMessage({action = 'movieT'})
			end
			if not idActive and idSwitch then
				idActive = true
				SendNUIMessage({action = 'idT'})
			end
			SendNUIMessage({action = 'movieHide'})
		end
	elseif action == "time" then
		if not timeActive then
			timeActive = true
			timeSwitch = true
			SendNUIMessage({action = 'timeT'})
		else
			timeActive = false
			timeSwitch = false
			SendNUIMessage({action = 'timeHide'})
		end
	elseif action == "microphone" then
		if not microphoneActive then
			microphoneActive = true
			microphoneSwitch = true
			SendNUIMessage({action = 'microphoneT'})
		else
			microphoneActive = false
			microphoneSwitch = false
			SendNUIMessage({action = 'microphoneHide'})
		end
    end
end)

RegisterNetEvent("esx_status:onTick")
AddEventHandler("esx_status:onTick", function(status)
    TriggerEvent('esx_status:getStatus', 'hunger', function(status)
        hunger = status.val / 10000
    end)
    TriggerEvent('esx_status:getStatus', 'thirst', function(status)
        thirst = status.val / 10000
    end)
end)

-- Opening Menu
RegisterCommand('hud', function()
	if not isOpen then
		isOpen = true
		SendNUIMessage({ action = 'show' })
		SetNuiFocus(true, true)
	end
end)

RegisterCommand('+levelVoice', function()
	if (microphone == 33) then
		microphone = normal
		SendNUIMessage({
			action = "microphone",
			microphone = microphone
		})
	elseif (microphone == 66) then
		microphone = scream
		SendNUIMessage({
			action = "microphone",
			microphone = microphone
		})
	elseif (microphone == 100) then
		microphone = whisper
		SendNUIMessage({
			action = "microphone",
			microphone = microphone
		})
	end
end)

RegisterKeyMapping('hud', 'Open the hud menu', 'keyboard', 'f7')

RegisterKeyMapping('+levelVoice', 'Do not use', 'keyboard', Config.VoiceChange)

-- Handler
AddEventHandler('playerSpawned', function()
	DisplayRadar(false)
end)
