ESX = nil
local banned = {}
local sebep = {}
local webhook = {
	ban = "https://discord.com/api/webhooks/821449269495857212/16l-9FdmzIPZ0OLTMkLesJdrrLonKMP7i9VuS23dpnOMMpm4Mpssey2EUM5Ns3pVekfy",
	kick = "https://discord.com/api/webhooks/821449269495857212/16l-9FdmzIPZ0OLTMkLesJdrrLonKMP7i9VuS23dpnOMMpm4Mpssey2EUM5Ns3pVekfy",
	unban = "https://discord.com/api/webhooks/821449269495857212/16l-9FdmzIPZ0OLTMkLesJdrrLonKMP7i9VuS23dpnOMMpm4Mpssey2EUM5Ns3pVekfy",
	connect = "https://discord.com/api/webhooks/821449470100635708/3_SQg0Te9PiAHw8yVx7ivX12utrrdQWkNZwYoUwxotb1QxsFOojzQqPWD3Tm9YYCivZz",

}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("ban", function(source, args)
    local player = ESX.GetPlayerFromId(source)
    local name = "Konsol"
    if source ~= 0 then
        player = ESX.GetPlayerFromId(source)
        name = GetPlayerName(source)
    end
    if not args then
        return
    end
    local id = tonumber(args[1])
    if player.getGroup() == "admin" or source == 0 then
        local tplayer = ESX.GetPlayerFromId(id)
        local tName = GetPlayerName(tplayer.source)
        local identifier = tplayer.identifier
        local discord = GetDiscordId(id)
        local sebep = args[2] or "Sebep boş bırakıldı"
        banned[discord] = true
        dclog(webhook.ban, "Ban Log", "**Banlayan Kişi: **" ..name.. "\n **Banlanan Kişi: **" ..tName.. " \n **Banlanan Discord Id:** " ..discord.. "\n **Banlanan Identifier: **" ..identifier.. "\n **Banlanma Sebebi: **" ..sebep)
        DropPlayer(tplayer.source, " Orospu Cocugu Anani Sikerim Senin Banlandin \n Banlanma Sebebi: " ..sebep)
        exports.ghmattimysql:execute("INSERT INTO banned_players (identifier, discord, sebep) VALUES (@identifier, @discord, @sebep)", {
            ["@identifier"] = identifier,
            ["@discord"] = discord,
            ["@sebep"] = sebep
        })
    end
end)

RegisterCommand("kick", function(source, args)
	local webhook = "https://discord.com/api/webhooks/784072769427472384/JQixjyD4i5nh9r9j5gSqY8M2zIZAZDJafOEzAgpmuCgnjiaqw3-JPRWQ7_8h9kEmp9oD"
	local player
	local name = "Konsol"
	if source ~= 0 then
		player = ESX.GetPlayerFromId(source)
		name = GetPlayerName(source)
	end
	if not args then
		return
	end
	local id = tonumber(args[1])
	if player.getGroup() == "admin" or source == 0 then
		local tplayer = ESX.GetPlayerFromId(id)
		local tName = GetPlayerName(tplayer.source)
		local identifier = tplayer.identifier
		local discord = GetDiscordId(id)
		local sebep = args[2] or "Sebep boş bırakıldı"
		dclog(webhook.kick, "Kick Log", "**Kickleyen Kişi: **" ..name.. "\n **Kicklenen Kişi: **" ..tName.. " \n **Kicklenen Discord Id:** " ..discord.. "\n **Kicklenen Identifier: **" ..identifier.. "\n **Kicklenme Sebebi: **" ..sebep)
		DropPlayer(tplayer.source, " Orospu Cocugu Anani Sikerim Senin Banlandin \n Banlanma Sebebi: " ..sebep)
	end
end)

RegisterCommand("unban", function(source, args)
	local player
	local name = "Konsol"
	if source ~= 0 then
		player = ESX.GetPlayerFromId(source)
		name = GetPlayerName(source)
	end
	if not args then
		return
	end
	if player.getGroup() == "admin" then
		local discord = args[1]
		if banned[discord] ~= nil then
			banned[discord] = nil
			dclog(webhook.unban, "Ban Log", "**Banı Açan Kişi: **" ..name..  " \n **Banı Açılan Discord Id:** " ..discord)
			exports.ghmattimysql:execute("DELETE FROM banned_players WHERE discord = @discord", {
				["@discord"] = discord
			})
		end
	end
end)

exports["ghmattimysql"]:ready(function()
	local result = exports.ghmattimysql:executeSync("SELECT * FROM banned_players")
	for i = 1, #result do
		banned[result[i].discord] = true
		sebep[result[i].discord] = result[i].sebep
	end
end)

AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
	local discord = GetDiscordId(source)
	deferrals.defer()
	deferrals.update("Yasaklar kontrol ediliyor...")
	if banned[discord] == nil then
		deferrals.done()
		dclog(webhook.connect, "Connect Log", "**Bağlanan Kişi: **" ..name.. " \n **Discord Id:** " ..discord)
	else
		deferrals.update("Bu sunucunun yasaklanmışlar listesindesiniz... \n Banlanma Sebebi: " ..sebep[discord])
		dclog(webhook.connect, "Connect Log", "**Banlanmış Kişi Oyuna Girmeyi Denedi** \n**Bağlanan Kişi: **" ..name.. " \n **Discord Id:** " ..discord)
	end
end)

AddEventHandler("playerDropped", function(player, reason)
	local playerId = source
	local discord = GetDiscordId(playerId)
	local name = GetPlayerName(source)
	dclog(webhook.connect, "Connect Log", "**Oyundan Çıkan Kişi: **" ..name.. " \n Discord Id: " ..discord)
end)

function GetDiscordId(source)
	local identifier
	local identifiers = {}
	identifiers = GetPlayerIdentifiers(source)
	for i = 1, #identifiers do
		if string.match(identifiers[i], "discord:") then
			identifier = string.sub(identifiers[i], 9)
		end
	end
	return identifier
end

function dclog(webhook, title, text)
	local ts = os.time()
    local time = os.date('%Y-%m-%d %H:%M:%S', ts)
    local connect = {
        {
            ["color"] = 3092790,
            ["title"] = title,
            ["description"] = text,
            ["footer"] = {
                ["text"] = "by fizzfau                             " ..time,
                ["icon_url"] = "https://i.ytimg.com/vi/RciuGXnHhR8/hqdefault.jpg",
            },
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "fizzfau-logsystem", embeds = connect}), { ['Content-Type'] = 'application/json' })
end