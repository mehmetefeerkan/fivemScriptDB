ESX = nil
local jobGrade = ''
local job = ''
-- ESX Stuff----
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)
---------------
Citizen.CreateThread(function()
	while true do			
			
			if ESX.PlayerData.job then
			 	--Setting players image to reflect their job
				SetDiscordRichPresenceAssetSmall(ESX.PlayerData.job.name)
				job = ESX.PlayerData.job.label
				jobGrade = ESX.PlayerData.job.grade_label
				--Setting the job text
				SetDiscordRichPresenceAssetSmallText(job .. " - " .. jobGrade)	
			else			
				Citizen.Wait(500)
			end	
						
			
        --This is the Application ID (Replace this with you own)
		SetDiscordAppId(Config.ClientID)

        --Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('big')
			
		SetRichPresence('ID:' .. GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))) .. ' | ' .. GetPlayerName(PlayerId()) .. ' | ' ..' '.. Config.PlayerText .. '/' .. tostring(Config.PlayerCount))
        

        --Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('XO Roleplay')
	
        --It updates every five seconds just in case.
		Citizen.Wait(Config.ResourceTimer*1000)
	end
end)