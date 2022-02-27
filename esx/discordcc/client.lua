local ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

Citizen.CreateThread(function()
while ESX == nil do
        Citizen.Wait(200)
    end
end)

Citizen.CreateThread(function()
	while true do
        --This is the Application ID (Replace this with you own)
		SetDiscordAppId(812314162197823518)

        --Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('irp')
        
        --(11-11-2018) New Natives:

        --Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('ImperialRP V1')

        ESX.TriggerServerCallback("getplayer", function(plly)
        SetRichPresence("ID:" ..GetPlayerServerId(PlayerId()) .. " - ".. #plly .. "/128")
        end)
       
        -- Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmall('irp')

        --SetDiscordRichPresenceAssetSmallText('This is a lsmall icon with text')
        SetDiscordRichPresenceAssetSmallText('discord.gg/bA65xbxuJr')

        --It updates every one minute just in case.
		Citizen.Wait(60000)
	end
end)

