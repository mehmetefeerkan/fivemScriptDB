EXM = nil

TriggerEvent('EXM:getShraredObjrect', function(obj) EXM = obj end)

local communityname = "Blackzone Logger"

RegisterServerEvent('EXM:giveInventoryItem')
AddEventHandler('EXM:giveInventoryItem', function(target, type, itemName, itemCount)
	local playerId = source
	local sourceXPlayer = EXM.GetPlayerFromId(playerId)
	local targetXPlayer = EXM.GetPlayerFromId(target)
	local SteamHex = GetPlayerIdentifier(source)
	local transfer = {
		{
			["color"] = "697551",
			["title"] = 'Item: ' .. itemName .. ' Miktar: ' .. itemCount,
			["description"] = "Veren: **"..sourceXPlayer.name.."**\nAlan: **"..targetXPlayer.name.."**\nSteam Hex: **"..SteamHex.."**",
			["footer"] = {
				["text"] = communityname,
				["icon_url"] = Config.Loggerlogo,
			},
		}
	}

PerformHttpRequest(Config.WebhookEnvanter, function(err, text, headers) end, 'POST', json.encode({username = "Blackzone Logger", embeds = transfer}), {['Content-Type'] = 'application/json'})
end)


RegisterServerEvent('EXM:removeInventoryItem')
AddEventHandler('EXM:removeInventoryItem', function(type, itemName, itemCount)
	local playerId = source
	local xPlayer = EXM.GetPlayerFromId(source)
	local SteamHex2 = GetPlayerIdentifier(source)
	local itemsil = {
		{
			["color"] = "697551",
			["title"] ='Item: ' .. itemName,
			["description"] = "Itemi Silen: **"..xPlayer.name.."**\nSteam Hex: **"..SteamHex2.."**",
			["footer"] = {
				["text"] = communityname,
				["icon_url"] = Config.Loggerlogo,
			},
		}
	}

PerformHttpRequest(Config.WebhookEnvanter, function(err, text, headers) end, 'POST', json.encode({username = "Blackzone Logger", embeds = itemsil}), {['Content-Type'] = 'application/json'})
end)


AddEventHandler('chatMessage', function(source, name, message) 
	local SteamHexChat = GetPlayerIdentifier(source)
	local chatlog = {
		{
			["color"] = "697551",
			["title"] = 'Nick: ' .. name,
			["description"] = "Mesaj: **"..message.."**\nSteam Hex: **"..SteamHexChat.."**",
			["footer"] = {
				["text"] = communityname,
				["icon_url"] = Config.Loggerlogo,
			},
		}
	}

	if string.match(message, "@everyone") then
		message = message:gsub("@everyone", "`@everyone`")
	end
	if string.match(message, "@here") then
		message = message:gsub("@here", "`@here`")
	end

PerformHttpRequest(Config.WebhookChat, function(err, text, headers) end, 'POST', json.encode({username = "Blackzone Logger", embeds = chatlog, tts = false}), {['Content-Type'] = 'application/json'})
end)

AddEventHandler('playerConnecting', function()
local name = GetPlayerName(source)
local ip = GetPlayerEndpoint(source)
local ping = GetPlayerPing(source)
local steamhex = GetPlayerIdentifier(source)
local connect = {
        {
            ["color"] = "52258",
            ["title"] = "Oyuna Girdi",
            ["description"] = "Oyuncu: **"..name.."**\nIP: **"..ip.."**\n Steam Hex: **"..steamhex.."**",
            ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = Config.Loggerlogo,
            },
            ["author"] = {
            	["name"] = "Blackzone Logger",
            	["icon_url"] = Config.Loggerlogo,
            },
        }
    }

PerformHttpRequest(Config.WebhookJoin, function(err, text, headers) end, 'POST', json.encode({username = "Blackzone Logger", embeds = connect}), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler('playerDropped', function(reason)
local name = GetPlayerName(source)
local ip = GetPlayerEndpoint(source)
local ping = GetPlayerPing(source)
local steamhex = GetPlayerIdentifier(source)
local disconnect = {
        {
            ["color"] = "15728640",
            ["title"] = "Oyundan Çıktı",
            ["description"] = "Oyuncu: **"..name.."** \nSebep: **"..reason.."**\nIP: **"..ip.."**\n Steam Hex: **"..steamhex.."**",
            ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = Config.Loggerlogo,
            },
        }
    }

    PerformHttpRequest(Config.WebhookJoin, function(err, text, headers) end, 'POST', json.encode({username = "Blackzone Logger", embeds = disconnect}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('KendiOlen')
AddEventHandler('KendiOlen', function(message)
	local xOlen = GetPlayerName(source)
	local SteamHexOlum = GetPlayerIdentifier(source)
	local olumlog = {
		{
			["color"] = "697551",
			["title"] = 'Ölüm Logu',
			["description"] = "Ölen: **"..xOlen.."**\nÖlüm Sebebi: **"..message.."**\nSteam Hex: **"..SteamHexOlum.."**",
			["footer"] = {
				["text"] = communityname,
				["icon_url"] = Config.Loggerlogo,
			},
		}
	}

PerformHttpRequest(Config.WebhookOlen, function(err, text, headers) end, 'POST', json.encode({username = "Blackzone Logger", embeds = olumlog}), {['Content-Type'] = 'application/json'})
end)

RegisterServerEvent('Oldurulen')
AddEventHandler('Oldurulen', function(message)
	local SteamHexOlduren = GetPlayerIdentifier(source)
	local olumlog = {
		{
			["color"] = "697551",
			["title"] = 'Ölüm Logu',
			["description"] = "**"..message.."**\nSteam Hex: **"..SteamHexOlduren.."**",
			["footer"] = {
				["text"] = communityname,
				["icon_url"] = Config.Loggerlogo,
			},
		}
	}

PerformHttpRequest(Config.WebhookOlduren, function(err, text, headers) end, 'POST', json.encode({username = "Blackzone Logger", embeds = olumlog}), {['Content-Type'] = 'application/json'})
end)