local ESX = nil
local id = GetPlayerServerId(PlayerId())

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

Citizen.CreateThread(function()
while ESX == nil do
        Citizen.Wait(200)
    end
end)

Citizen.CreateThread(function()
	while true do
		SetDiscordAppId(812314162197823518)

		SetDiscordRichPresenceAsset('irp')
        

        SetDiscordRichPresenceAssetText('Imperial Roleplay')

        ESX.TriggerServerCallback("getplayer", function(isim, soyad, oyuncu)
        SetRichPresence("[" .. id .. "] " .. isim .. " " .. soyad .. " " .. #oyuncu .. "/256")
        end)
       
        SetDiscordRichPresenceAssetSmall('irp')

        SetDiscordRichPresenceAssetSmallText('Dev. BrnOrkun#3131 & ephesus#8330')

        -- Yeni discord butonları
        SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/imperialroleplay")
        SetDiscordRichPresenceAction(1, "Server List", "https://servers.fivem.net/servers/detail/3je9mr")

		Citizen.Wait(60000)
	end
end)

--[[
Citizen.CreateThread(function()
	while true do
		SetDiscordAppId(812314162197823518)

		SetDiscordRichPresenceAsset('irp')
        

        SetDiscordRichPresenceAssetText('Imperial V1')

        ESX.TriggerServerCallback("getplayer", function(isim, soyad, oyuncu)
        SetRichPresence("[" .. id .. "] " .. isim .. " " .. soyad .. " " .. #oyuncu .. "/256")
        end)
       
        SetDiscordRichPresenceAssetSmall('irp')

        SetDiscordRichPresenceAssetSmallText('Dev. BrnOrkun#3131')

        -- Yeni discord butonları
        SetDiscordRichPresenceAction(0, "Discord", "https://www.irp.fivemstation.com")
        SetDiscordRichPresenceAction(1, "Server List", "https://servers.fivem.net/servers/detail/p5vqr5")

		Citizen.Wait(60000)
	end
end)
]]--