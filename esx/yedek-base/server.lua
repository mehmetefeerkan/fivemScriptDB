ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterCommand('kickall', function(source, args, rawCommand)
    kickPl()
end, true)

function kickPl ()
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        xPlayer.kick("##")
        sendToDiscord("##", 56108)
    end
end

function sendToDiscord (canal, name, message, color)
local DiscordWebHook = canal
local embeds = {
    {
        ["title"]= "MB-V2 TEST",
        ["type"]= "rich",
        ["color"] = color,
        ["description"]= message,
        ["footer"]= {
        ["text"]= "MrBerk",
        ["icon_url"]= "https://forum.fivem.net/uploads/default/original/3X/f/3/f39849c511fa123c3346b7afef26971f1f8a740d.png",
       },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
