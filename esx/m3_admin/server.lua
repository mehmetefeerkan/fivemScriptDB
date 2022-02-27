--wipe tables
local sqltables = {
    [1] = {
        tablename = 'users',
        identifierparameter = 'identifier'
    },
    [2] = {
        tablename = 'characters',
        identifierparameter = 'identifier'
    },
    [3] = {
        tablename = 'communityservice',
        identifierparameter = 'identifier'
    },
    [4] = {
        tablename = 'crew_phone_bank',
        identifierparameter = 'identifier'
    },
    [5] = {
        tablename = 'datastore_data',
        identifierparameter = 'owner'
    },
    [6] = {
        tablename = 'disc_ammo',
        identifierparameter = 'owner'
    },
    [7] = {
        tablename = 'm3_inv_stashs',
        identifierparameter = 'owner'
    },
    [8] = {
        tablename = 'm3_uber_points',
        identifierparameter = 'identifier'
    },
    [9] = {
        tablename = 'm3_user_peds',
        identifierparameter = 'identifier'
    },
    [10] = {
        tablename = 'owned_vehicles',
        identifierparameter = 'owner'
    },
    [11] = {
        tablename = 'user_licenses',
        identifierparameter = 'owner'
    },
}
--

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local admintable = {}

local permissions = {'fullperm', 'bringall', 'allkick', 'reviveall', 'wipeplayer', 'unban', 'privatemessage', 'tp', 'timeweather', 'skin', 'cleararea', 'screenshot', 'setgps', 'spectate', 'revive', 'heal', 'openinv', 'goto', 'bring', 'freeze', 'kill', 'kick', 'ban', 'giveitem', 'givevehicle', 'giveweapon', 'noclip', 'invisibility'}

RegisterServerEvent('m3:admin:server:playerSpawned')
AddEventHandler('m3:admin:server:playerSpawned', function()
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local perms = {}

    for k, v in pairs(permissions) do
        if IsPlayerAceAllowed(src, 'm3admin.'..v) then
            table.insert(perms, {[v] = true})
            addAdmin(src, xPlayer.identifier)
        else
            table.insert(perms, {[v] = false})
        end
    end

    TriggerClientEvent('m3:admin:client:loadPermissions', src, perms)
end)

ESX.RegisterServerCallback('m3:admin:server:getPlayers', function(source, cb)
    local l = {}
    local players = GetPlayers()
    for i, player in pairs(players) do
        table.insert(l, {id = tonumber(player), name = GetPlayerName(player)})
    end
    cb(l)
end)

ESX.RegisterServerCallback('m3:admin:server:refreshBanlist', function(source, cb)
    local cbbantable = {}
    exports.ghmattimysql:execute('SELECT * FROM m3_banlist', {}, function(results)
        if results[1] ~= nil or #results > 0 then
            for i = 1, #results, 1 do
                table.insert(cbbantable, {id = results[i].id, name = results[i].name, admin = results[i].admin, steam = results[i].steam, rockstar = string.sub(results[i].rockstar, 0, 36)..'...', discord = results[i].discord, xbox = results[i].xbox, live = results[i].live, reason = string.sub(results[i].reason, 0, 36)..'...', ip = results[i].ip, time = os.date('%d.%m.%Y %H:%M', results[i].time)})
                Citizen.Wait(1)
            end
        end
    end)
    cb(cbbantable)
end)

function refreshBanlist()
    local cbbantable = {}
    exports.ghmattimysql:execute('SELECT * FROM m3_banlist', {}, function(results)
        if results[1] ~= nil or #results > 0 then
            for i = 1, #results, 1 do
                table.insert(cbbantable, {id = results[i].id, name = results[i].name, admin = results[i].admin, steam = results[i].steam, rockstar = string.sub(results[i].rockstar, 0, 36)..'...', discord = results[i].discord, xbox = results[i].xbox, live = results[i].live, reason = string.sub(results[i].reason, 0, 36)..'...', ip = results[i].ip, time = os.date('%d.%m.%Y %H:%M', results[i].time)})
                Citizen.Wait(1)
            end
        end
    end)
    for k = 1, #admintable, 1 do
        TriggerClientEvent('m3:admin:client:refreshBanlist', admintable[k].src, cbbantable)
        Citizen.Wait(1)
    end
end

AddEventHandler('playerDropped', function(reason)
    local src = source

    print('^0[^1m3:admin^0] - #'..src..' '..GetPlayerName(src)..' sunucudan ^1ayrildi!^0')

    removeAdmin(src)
end)

function addAdmin(src, identifier)
    for i = 1, #admintable, 1 do
        if admintable[i].src == tonumber(src) then
            return
        end
    end
    table.insert(admintable, {src = tonumber(src), identifier = identifier})
end

function removeAdmin(src)
    for i = 1, #admintable, 1 do
        if admintable[i].src == tonumber(src) then
            table.remove(admintable, i)
            return
        end
    end
end

function removePlayer(src)
    for i = 1, #players, 1 do
        if players[i].id == tonumber(src) then
            table.remove(players, i)
            return
        end
    end
end

ESX.RegisterServerCallback('m3:admin:server:getTargetCoord', function(source, cb, target)
    local player = GetPlayerPed(target)
    local coord = GetEntityCoords(player)
    cb(coord)
end)

function havePermission(src, permName)
    if IsPlayerAceAllowed(src, 'm3admin.fullperm') then
        return true
    end

    if IsPlayerAceAllowed(src, 'm3admin.'..permName) then
        return true
    else
        return false
    end
end

function notify(src, type, text, time)
    if length == nil then length = 5000 end 
    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = type, text = text, length = length})
end

RegisterServerEvent('m3:admin:server:revive')
AddEventHandler('m3:admin:server:revive', function(target)
    local src = source

    if havePermission(src, 'revive') then
        TriggerClientEvent('esx_ambulancejob:revive', target)
        notify(src, 'inform', 'ID '..tonumber(target)..' iyileştirildi(revive).')
        discordLog(src, 'revive', target)
    else
        unauthorizedLog(src, 'revive')
    end
end)

RegisterServerEvent('m3:admin:server:heal')
AddEventHandler('m3:admin:server:heal', function(target)
    local src = source

    if havePermission(src, 'heal') then
        TriggerClientEvent('esx_basicneeds:healPlayer', target)
        notify(src, 'inform', 'ID '..tonumber(target)..' iyileştirildi(heal).')
        discordLog(src, 'heal', target)
    else
        unauthorizedLog(src, 'heal')
    end
end)

RegisterServerEvent('m3:admin:server:openInv')
AddEventHandler('m3:admin:server:openInv', function(target)
    local src = source

    if havePermission(src, 'openinv') then
        TriggerClientEvent("m3:inventoryhud:client:openPlayerInventory", src, target, 'admin')
        notify(src, 'inform', 'ID '..tonumber(target)..' envanteri açıldı.')
        discordLog(src, 'openinv', target)
    else
        unauthorizedLog(src, 'openinv')
    end
end)

RegisterServerEvent('m3:admin:server:clearInv')
AddEventHandler('m3:admin:server:clearInv', function(target)
    local src = source

    if havePermission(src, 'openinv') then
        local tPlayer = ESX.GetPlayerFromId(target)
        for i=1, #tPlayer.inventory, 1 do
			if tPlayer.inventory[i].count > 0 then
				tPlayer.setInventoryItem(tPlayer.inventory[i].name, 0)
			end
		end
        notify(src, 'inform', 'ID '..tonumber(target)..' envanteri boşaltıldı.')
        discordLog(src, 'clearinv', target)
    else
        unauthorizedLog(src, 'clearinv')
    end
end)

RegisterServerEvent('m3:admin:server:setGps')
AddEventHandler('m3:admin:server:setGps', function(target)
    local src = source

    if havePermission(src, 'setgps') then
        local player = GetPlayerPed(target)
        local coord = GetEntityCoords(player)
        TriggerClientEvent("m3:admin:client:setGps", src, coord)
        notify(src, 'inform', 'ID '..tonumber(target)..' gps\'te işaretlenildi.')
        discordLog(src, 'setgps', target)
    else
        unauthorizedLog(src, 'setgps')
    end
end)

RegisterServerEvent('m3:admin:server:goto')
AddEventHandler('m3:admin:server:goto', function(target)
    local src = source

    if havePermission(src, 'goto') then
        local player = GetPlayerPed(target)
        local coord = GetEntityCoords(player)
        TriggerClientEvent('m3:admin:client:setCoord', src, coord)
        notify(src, 'inform', 'ID '..tonumber(target)..' konumuna ışınlanıldı.')
        discordLog(src, 'goto', target)
    else
        unauthorizedLog(src, 'goto')
    end
end)

RegisterServerEvent('m3:admin:server:bring')
AddEventHandler('m3:admin:server:bring', function(target)
    local src = source

    if havePermission(src, 'bring') then
        local player = GetPlayerPed(src)
        local coord = GetEntityCoords(player)
        TriggerClientEvent('m3:admin:client:setCoord', target, coord)
        notify(src, 'inform', 'ID '..tonumber(target)..' konumunuza çekildi.')
        discordLog(src, 'bring', target)
    else
        unauthorizedLog(src, 'bring')
    end
end)

RegisterServerEvent('m3:admin:server:toggleFreeze')
AddEventHandler('m3:admin:server:toggleFreeze', function(target, value)
    local src = source

    if havePermission(src, 'freeze') then
        local player = GetPlayerPed(target)
        if value then
            FreezeEntityPosition(player, 1)
            notify(src, 'inform', 'ID '..tonumber(target)..' donduruldu.')
        else
            FreezeEntityPosition(player, 0)
            notify(src, 'inform', 'ID '..tonumber(target)..' çözüldü.')
        end
        discordLog(src, 'freeze', target)
    else
        unauthorizedLog(src, 'freeze')
    end
end)

RegisterServerEvent('m3:admin:server:privateMessage')
AddEventHandler('m3:admin:server:privateMessage', function(target, message)
    local src = source

    if havePermission(src, 'privatemessage') then
        TriggerClientEvent('chat:addMessage', target, {
            template = '<div class="chat-message server"><b>{0}</b>: {1}</div>',
            args = { '^3 Özel Mesaj - '..GetPlayerName(src)..']', message}
        })
        notify(src, 'inform', 'ID '..tonumber(target)..' mesaj gönderildi.')
        discordLog(src, 'privatemessage', target)
    else
        unauthorizedLog(src, 'privatemessage')
    end
end)

RegisterServerEvent('m3:admin:server:kill')
AddEventHandler('m3:admin:server:kill', function(target)
    local src = source

    if havePermission(src, 'kill') then
        TriggerClientEvent('m3:admin:client:kill', target)
        notify(src, 'inform', 'ID '..tonumber(target)..' öldürüldü.')
        discordLog(src, 'kill', target)
    else
        unauthorizedLog(src, 'kill')
    end
end)

RegisterServerEvent('m3:admin:server:kick')
AddEventHandler('m3:admin:server:kick', function(target, reason)
    local src = source

    if havePermission(src, 'kick') then
        notify(src, 'inform', 'ID '..tonumber(target)..' sunucudan atıldı.')
        discordLog(src, 'kick', target, 'Sebep:', reason)
        DropPlayer(target, '[m3_admin] - '..GetPlayerName(target)..' tarafından sunucudan atıldınız.\nSebep: '..reason)
    else
        unauthorizedLog(src, 'kick')
    end
end)

RegisterServerEvent('m3:admin:server:wipePlayer')
AddEventHandler('m3:admin:server:wipePlayer', function(target, steamhex)
    local src = source

    if havePermission(src, 'wipeplayer') then
        if target ~= nil then
            local tIdentifier = (ESX.GetPlayerFromId(target)).identifier
            local tName = GetPlayerName(target)
            notify(src, 'inform', '#'..tonumber(target)..' - '..tName..' sunucudan atıldı ve karakteri silindi.')
            discordLog(src, 'wipeplayer', target)

            DropPlayer(target, '[aiakos] - '..GetPlayerName(src)..' tarafından sunucudan atıldınız.\nSebep: wipe')

            for i = 1, #sqltables, 1 do
                local sqlquery = 'DELETE FROM '..sqltables[i].tablename..' WHERE '..sqltables[i].identifierparameter..' = @'..sqltables[i].identifierparameter

                exports.ghmattimysql:execute(sqlquery, {['@'..sqltables[i].identifierparameter] = tIdentifier})
            end
        else
            notify(src, 'inform', steamhex..' karakteri silindi.')
            discordselfLog(src, 'wipeplayer', 'SteamHex:', steamhex)

            for i = 1, #sqltables, 1 do
                local sqlquery = 'DELETE FROM '..sqltables[i].tablename..' WHERE '..sqltables[i].identifierparameter..' = @'..sqltables[i].identifierparameter

                exports.ghmattimysql:execute(sqlquery, {['@'..sqltables[i].identifierparameter] = steamhex})
            end
        end
    else
        unauthorizedLog(src, 'wipeplayer')
    end
end)

RegisterServerEvent('m3:admin:server:ban')
AddEventHandler('m3:admin:server:ban', function(target, reason, time)
    local src = source

    if havePermission(src, 'ban') then
        local license, identifier, liveid, xblid, discord, playerip = nil, nil, nil, nil, nil, nil
        for k, v in ipairs(GetPlayerIdentifiers(target))do
            if string.sub(v, 1, string.len("license:")) == "license:" then
                license = v
            elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
                identifier = v
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                liveid = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                xblid  = v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                discord = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                playerip = v
            end
        end
        exports.ghmattimysql:execute('INSERT INTO m3_banlist (name, admin, steam, rockstar, xbox, live, discord, ip, reason, time) VALUES (@name, @admin, @steam, @rockstar, @xbox, @live, @discord, @ip, @reason, @time)',
        { ['@name'] = GetPlayerName(target), ['@admin'] = GetPlayerName(src), ['@steam'] = identifier, ['@rockstar'] = license, ['@xbox'] = xblid, ['@live'] = liveid, ['@discord'] = discord, ['@ip'] = playerip, ['@reason'] = reason, ['@time'] = ostime() + time })
        notify(src, 'inform', 'ID '..tonumber(target)..' sunucudan banlandı.')
        discordLog(src, 'ban', target, 'Sebep:', reason)
        DropPlayer(target, '[m3_admin] - '..GetPlayerName(target)..' tarafından sunucudan banlandınız.\nSebep: '..reason..'\nYasağın biteceği süre: '..os.date('%d.%m.%Y %H:%M', ostime() + time))
    else
        unauthorizedLog(src, 'ban')
    end
end)

RegisterServerEvent('m3:admin:server:unban')
AddEventHandler('m3:admin:server:unban', function(banid)
    local src = source

    if havePermission(src, 'unban') then
        exports.ghmattimysql:execute('SELECT * FROM m3_banlist WHERE id = @id', {['@id'] = banid}, function(result)
            if result[1] ~= nil then
                notify(src, 'inform', 'Yasak kaldırıldı.')
                discordselfLog(src, 'unban', 'Yasağı Kaldırılan Oyuncu:', result[1].name, 'Steam(hex):', bantable[1].steam)
                exports.ghmattimysql:execute('DELETE FROM m3_banlist WHERE id = @id', {['@id'] = banid})
                refreshBanlist()
            end
        end)
    else
        unauthorizedLog(src, 'unban')
    end
end)

RegisterServerEvent('m3:admin:server:giveItem')
AddEventHandler('m3:admin:server:giveItem', function(target, itemName, itemCount)
    local src = source

    if havePermission(src, 'giveitem') then
        local tPlayer = ESX.GetPlayerFromId(target)
        tPlayer.addInventoryItem(itemName, itemCount)
        notify(src, 'inform', 'ID '..tonumber(target)..' '..itemCount..'x '..itemName..' verildi.')
        discordLog(src, 'giveitem', target, 'Eşya ismi:', itemName, 'Eşya Sayısı:', itemCount)
    else
        unauthorizedLog(src, 'giveitem')
    end
end)

RegisterServerEvent('m3:admin:server:giveWeapon')
AddEventHandler('m3:admin:server:giveWeapon', function(target, itemName, itemCount)
    local src = source

    if havePermission(src, 'giveweapon') then
        local tPlayer = ESX.GetPlayerFromId(target)
        tPlayer.addInventoryItem(itemName, itemCount)
        notify(src, 'inform', 'ID '..tonumber(target)..' '..itemCount..'x '..itemName..' verildi.')
        discordLog(src, 'giveweapon', target, 'Silah ismi:', itemName, 'Silah Sayısı:', itemCount)
    else
        unauthorizedLog(src, 'giveweapon')
    end
end)

RegisterServerEvent('m3:admin:server:giveVehicle')
AddEventHandler('m3:admin:server:giveVehicle', function(target, type, model)
    local src = source

    if havePermission(src, 'givevehicle') then
        TriggerClientEvent('m3:admin:client:spawnVehicle', target, model, type)
        notify(src, 'inform', 'ID '..tonumber(target)..' '..model..'('..type..') verildi.')
        discordLog(src, 'givevehicle', target, 'Araç Tipi:', type, 'Araç Modeli:', model)
    else
        unauthorizedLog(src, 'givevehicle')
    end
end)

RegisterServerEvent('m3:admin:server:saveVehicle')
AddEventHandler('m3:admin:server:saveVehicle', function(vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	exports.ghmattimysql:execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
		['@owner'] = xPlayer.identifier,
		['@vehicle'] = json.encode(vehicleProps),
		['@plate'] = vehicleProps.plate,
		['@type'] = type,
		['@job'] = 'sivil',
		['@stored'] = 0
	})
end)

RegisterServerEvent('m3:admin:server:giveMoney')
AddEventHandler('m3:admin:server:giveMoney', function(target, type, amount)
    local src = source

    if havePermission(src, 'givemoney') then
        local tPlayer = ESX.GetPlayerFromId(target)
        if type == 'Nakit' then
            tPlayer.addAccountMoney('money', amount)
        elseif type == 'Banka' then
            tPlayer.addAccountMoney('bank', amount)
        elseif type == 'Karapara' then
            tPlayer.addAccountMoney('black_money', amount)
        end
        notify(src, 'inform', 'ID '..tonumber(target)..' '..amount..'$ '..string.lower(type)..' verildi.')
        discordLog(src, 'givemoney', target, 'Para Tipi:', type, 'Para Miktarı:', amount)
    else
        unauthorizedLog(src, 'givemoney')
    end
end)

RegisterServerEvent('m3:admin:server:skin')
AddEventHandler('m3:admin:server:skin', function(target)
    local src = source

    if havePermission(src, 'skin') then
        -- TriggerClientEvent('esx_skin:openSaveableMenu', target)
		TriggerClientEvent('mpcreator:OpenMenu', target)
        notify(src, 'inform', 'ID '..tonumber(target)..' skin menüsü açıldı.')
        discordLog(src, 'skin', target)
    else
        unauthorizedLog(src, 'skin')
    end
end)

RegisterServerEvent('m3:admin:server:screenshot')
AddEventHandler('m3:admin:server:screenshot', function(target)
    local src = source

    if havePermission(src, 'screenshot') then
        TriggerClientEvent('m3:admin:client:captureScreenshot', target, GetPlayerName(src), src)
        notify(src, 'inform', 'ID '..tonumber(target)..' ekran resmi alındı.')
        discordLog(src, 'screenshot', target)
    else
        unauthorizedLog(src, 'screenshot')
    end
end)

RegisterServerEvent('m3:admin:server:sendScreenshot')
AddEventHandler('m3:admin:server:sendScreenshot', function(url, adminName, adminSrc)
    local src = source
    TriggerClientEvent('chat:addMessage', adminSrc, { template = '<img src="{0}" style="max-width: 400px;" />', args = { url } })

    if GetConvar('m3_admin_discordLog', 'false') then
        local playerName = Sanitize(GetPlayerName(src))
        
        for k, v in ipairs(GetPlayerIdentifiers(src)) do
            if string.match(v, 'steam:') then
                identifierSteamHex = v
            end
            if string.match(v, 'discord:') then
                identifierDiscord = v
            end
            -- if string.match(v, 'ip:') then
            --     identifierIp = v
            -- end
        end
        
        local headers = {
            ['Content-Type'] = 'application/json'
        }
        local data = {
            ['username'] = 'm3 Admin',
            ['avatar_url'] = 'https://i.imgyukle.com/2020/05/11/r8k2GI.png',
            ['embeds'] = {{
                    ['author'] = {
                    ['name'] = 'm3 Admin',
                    ['icon_url'] = 'https://i.imgyukle.com/2020/05/11/r8k2GI.png'
                },
                ['footer'] = {
                    ['text'] = 'dev. by KanOX - EWG Roleplay İçin Yapılmıştır'
                },
                ['color'] = 1942002,
                ['timestamp'] = os.date('!%Y-%m-%dT%H:%M:%SZ')
            }}
        }
        text = '**Ekran Görüntüsü Aldıran:** #'..tonumber(adminSrc)..' - '..adminName
        text = text..'\n**ID**: '..tonumber(src)..'\n**Oyuncu Adı:** '..playerName
        if identifierSteamHex ~= nil then
            text = text..'\n**Steam(hex):** '..identifierSteamHex
            if identifierDiscord ~= nil then
                text = text..'\n**Discord:** <@'..string.sub(identifierDiscord, 9)..'>'
                identifierDiscord = nil
            end
            -- if identifierIp ~= nil then
            --     text = text..'\n**Ip:** '..string.sub(identifierIp, 4)
            --     identifierIp = nil
            -- end
            data['embeds'][1]['description'] = text
            data['embeds'][1]['image'] = { ['url'] = url }
            PerformHttpRequest(GetConvar('m3_admin_discordLogURL', ''), function(err, text, headers) end, 'POST', json.encode(data), headers)
        end
    end
end)

RegisterServerEvent('m3:admin:server:selfRevive')
AddEventHandler('m3:admin:server:selfRevive', function()
    local src = source

    if havePermission(src, 'revive') then
        TriggerClientEvent('esx_ambulancejob:revive', src)
        discordselfLog(src, 'revive')
    else
        unauthorizedLog(src, 'revive')
    end
end)

RegisterServerEvent('m3:admin:server:selfHeal')
AddEventHandler('m3:admin:server:selfHeal', function()
    local src = source

    if havePermission(src, 'heal') then
        TriggerClientEvent('esx_basicneeds:healPlayer', src)
        discordselfLog(src, 'heal')
    else
        unauthorizedLog(src, 'heal')
    end
end)

RegisterServerEvent('m3:admin:server:selfKill')
AddEventHandler('m3:admin:server:selfKill', function()
    local src = source

    if havePermission(src, 'kill') then
        TriggerClientEvent('m3:admin:client:kill', src)
        discordselfLog(src, 'kill')
    else
        unauthorizedLog(src, 'kill')
    end
end)

RegisterServerEvent('m3:admin:server:toggleNoclip')
AddEventHandler('m3:admin:server:toggleNoclip', function()
    local src = source

    if havePermission(src, 'noclip') then
        TriggerClientEvent('m3_noclip:active', src)
        discordselfLog(src, 'noclip')
    else
        unauthorizedLog(src, 'noclip')
    end
end)

RegisterServerEvent('m3:admin:server:clearArea')
AddEventHandler('m3:admin:server:clearArea', function(coord)
    local src = source

    if havePermission(src, 'cleararea') then
        TriggerClientEvent('m3:admin:client:clearArea', -1, coord)
        notify(src, 'inform', 'x'..coord.x..' y'..coord.y..' z'..coord.z..' bölgesi temizlendi.')
        discordselfLog(src, 'cleararea', 'x:', coord.x, 'y:', coord.y, 'z:', coord.z)
    else
        unauthorizedLog(src, 'cleararea')
    end
end)

RegisterServerEvent('m3:admin:server:toggleSelfFreeze')
AddEventHandler('m3:admin:server:toggleSelfFreeze', function(value)
    local src = source

    if havePermission(src, 'freeze') then
        local player = GetPlayerPed(src)
        if value then
            FreezeEntityPosition(player, 1)
        else
            FreezeEntityPosition(player, 0)
        end
        discordselfLog(src, 'freeze')
    else
        unauthorizedLog(src, 'freeze')
    end
end)

RegisterServerEvent('m3:admin:server:announce')
AddEventHandler('m3:admin:server:announce', function(message)
    local src = source

    if havePermission(src, 'announce') then
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message server"><b>{0}</b>: {1}</div>',
            args = { '^3[m3 Admin - Anons]', message}
        })
        discordselfLog(src, 'announce', 'Mesaj:', message)
    else
        unauthorizedLog(src, 'announce')
    end
end)

RegisterServerEvent('m3:admin:server:allKick')
AddEventHandler('m3:admin:server:allKick', function()
    local src = source
    local srcName = GetPlayerName(src)

    if havePermission(src, 'allkick') then
        local allplayers = GetPlayers()
        for i, player in pairs(allplayers) do
            if tonumber(player) ~= tonumber(src) then
                DropPlayer(player, '[m3 admin] - '..srcName..' tarafından atıldınız.(allkick)')
            end
        end
        discordselfLog(src, 'allkick')
        notify(src, 'inform', 'Sunucudaki herkes atıldı.')
    else
        unauthorizedLog(src, 'allkick')
    end
end)

RegisterServerEvent('m3:admin:server:allBring')
AddEventHandler('m3:admin:server:allBring', function(coord)
    local src = source

    if havePermission(src, 'bringall') then
        local allplayers = GetPlayers()
        for i, player in pairs(allplayers) do
            if tonumber(player) ~= tonumber(src) then
                TriggerClientEvent('m3:admin:client:setCoord', player, coord)
            end
        end
        discordselfLog(src, 'bringall')
        notify(src, 'inform', 'Sunucudaki herkes yanınıza getirildi.')
    else
        unauthorizedLog(src, 'bringall')
    end
end)

RegisterServerEvent('m3:admin:server:reviveAll')
AddEventHandler('m3:admin:server:reviveAll', function()
    local src = source

    if havePermission(src, 'reviveall') then
        local allplayers = GetPlayers()
        for i, player in pairs(allplayers) do
            TriggerClientEvent('esx_ambulancejob:revive', player)
        end
        discordselfLog(src, 'reviveall')
        notify(src, 'inform', 'Sunucudaki herkes iyileştirildi.')
    else
        unauthorizedLog(src, 'reviveall')
    end
end)

RegisterServerEvent('m3:admin:server:selfLog')
AddEventHandler('m3:admin:server:selfLog', function(action)
    local src = source

    discordselfLog(src, action)
end)

function ostime()
    return os.time()
end

function discordLog(src, action, target, args1, args2, args3, args4)
    if GetConvar('m3_admin_discordLog', 'false') then
        if target == nil then
            return
        end
        
        local playerName = Sanitize(GetPlayerName(target))
        
        for k, v in ipairs(GetPlayerIdentifiers(target)) do
            if string.match(v, 'steam:') then
                identifierSteamHex = v
            end
            if string.match(v, 'discord:') then
                identifierDiscord = v
            end
            -- if string.match(v, 'ip:') then
            --     identifierIp = v
            -- end
        end
        
        local headers = {
            ['Content-Type'] = 'application/json'
        }
        local data = {
            ['username'] = 'm3 Admin',
            ['avatar_url'] = 'https://i.imgyukle.com/2020/05/11/r8k2GI.png',
            ['embeds'] = {{
                    ['author'] = {
                    ['name'] = 'm3 Admin',
                    ['icon_url'] = 'https://i.imgyukle.com/2020/05/11/r8k2GI.png'
                },
                ['footer'] = {
                    ['text'] = 'dev. by KanOX - EWG ROLEPLAY İÇİN TASARLANMIŞTIR.'
                },
                ['color'] = 1942002,
                ['timestamp'] = os.date('!%Y-%m-%dT%H:%M:%SZ')
            }}
        }
        text = '**İşlem:** ' ..action
        if (args1 ~= nil and args2 ~= nil) then
            text = text..'\n**'..args1..'** '..args2
        end
        if (args3 ~= nil and args4 ~= nil) then
            text = text..'\n**'..args3..'** '..args4
        end
        if (args5 ~= nil and args6 ~= nil) then
            text = text..'\n**'..args5..'** '..args6
        end
        text = text..'\n\n**##İşlem Yapılan Kişinin Bilgileri##**\n**ID**: '..tonumber(src)..'\n**Oyuncu Adı:** '..playerName
        if identifierSteamHex ~= nil then
            text = text..'\n**Steam(hex):** '..identifierSteamHex
            if identifierDiscord ~= nil then
                text = text..'\n**Discord:** <@'..string.sub(identifierDiscord, 9)..'>'
                identifierDiscord = nil
            end
            -- if identifierIp ~= nil then
            --     text = text..'\n**Ip:** '..string.sub(identifierIp, 4)
            --     identifierIp = nil
            -- end
            data['embeds'][1]['description'] = text
            PerformHttpRequest(GetConvar('m3_admin_discordLogURL', ''), function(err, text, headers) end, 'POST', json.encode(data), headers)
        end
    end
end

function discordselfLog(src, action, args1, args2, args3, args4, args5, args6)
    if GetConvar('m3_admin_discordLog', 'false') then
        local src = source
        local playerName = Sanitize(GetPlayerName(src))
        
        for k, v in ipairs(GetPlayerIdentifiers(src)) do
            if string.match(v, 'steam:') then
                identifierSteamHex = v
            end
            if string.match(v, 'discord:') then
                identifierDiscord = v
            end
            -- if string.match(v, 'ip:') then
            --     identifierIp = v
            -- end
        end
        
        local headers = {
            ['Content-Type'] = 'application/json'
        }
        local data = {
            ['username'] = 'm3 Admin',
            ['avatar_url'] = 'https://i.imgyukle.com/2020/05/11/r8k2GI.png',
            ['embeds'] = {{
                    ['author'] = {
                    ['name'] = 'm3 Admin',
                    ['icon_url'] = 'https://i.imgyukle.com/2020/05/11/r8k2GI.png'
                },
                ['footer'] = {
                    ['text'] = 'dev. by KanOX- EWG İÇİN TASARLANDI.'
                },
                ['color'] = 1942002,
                ['timestamp'] = os.date('!%Y-%m-%dT%H:%M:%SZ')
            }}
        }
        text = '**İşlem:** ' ..action
        if (args1 ~= nil and args2 ~= nil) then
            text = text..'\n**'..args1..'** '..args2
        end
        if (args3 ~= nil and args4 ~= nil) then
            text = text..'\n**'..args3..'** '..args4
        end
        if (args5 ~= nil and args6 ~= nil) then
            text = text..'\n**'..args5..'** '..args6
        end
        text = text..'\n**ID**: '..tonumber(src)..'\n**Oyuncu Adı:** '..playerName
        if identifierSteamHex ~= nil then
            text = text..'\n**Steam(hex):** '..identifierSteamHex
            if identifierDiscord ~= nil then
                text = text..'\n**Discord:** <@'..string.sub(identifierDiscord, 9)..'>'
                identifierDiscord = nil
            end
            -- if identifierIp ~= nil then
            --     text = text..'\n**Ip:** '..string.sub(identifierIp, 4)
            --     identifierIp = nil
            -- end
            data['embeds'][1]['description'] = text
            PerformHttpRequest(GetConvar('m3_admin_discordLogURL', ''), function(err, text, headers) end, 'POST', json.encode(data), headers)
        end
    end
end

function unauthorizedLog(src, action)
    if GetConvar('m3_admin_discordLog', 'false') then
        local src = source
        local playerName = Sanitize(GetPlayerName(src))
        
        for k, v in ipairs(GetPlayerIdentifiers(src)) do
            if string.match(v, 'steam:') then
                identifierSteamHex = v
            end
            if string.match(v, 'discord:') then
                identifierDiscord = v
            end
            -- if string.match(v, 'ip:') then
            --     identifierIp = v
            -- end
        end
        
        local headers = {
            ['Content-Type'] = 'application/json'
        }
        local data = {
            ['username'] = 'm3 Admin',
            ['avatar_url'] = 'https://i.imgyukle.com/2020/05/11/r8k2GI.png',
            ['embeds'] = {{
                    ['author'] = {
                    ['name'] = 'm3 Admin',
                    ['icon_url'] = 'https://i.imgyukle.com/2020/05/11/r8k2GI.png'
                },
                ['footer'] = {
                    ['text'] = 'dev. by morpheause#3333 - cloudfivem.com'
                },
                ['color'] = 15927612,
                ['timestamp'] = os.date('!%Y-%m-%dT%H:%M:%SZ')
            }}
        }
        text = '**ID**: '..tonumber(src)..'\n**Oyuncu Adı:** '..playerName
        if identifierSteamHex ~= nil then
            text = text..'\n**Steam(hex):** '..identifierSteamHex
            if identifierDiscord ~= nil then
                text = text..'\n**Discord:** <@'..string.sub(identifierDiscord, 9)..'>'
                identifierDiscord = nil
            end
            -- if identifierIp ~= nil then
            --     text = text..'\n**Ip:** '..string.sub(identifierIp, 4)
            --     identifierIp = nil
            -- end
            data['embeds'][1]['description'] = text
            PerformHttpRequest(GetConvar('m3_admin_discordUnauthorizedLogURL', ''), function(err, text, headers) end, 'POST', json.encode(data), headers)
        end
    end
end

function Sanitize(str)
	local replacements = {
		['&' ] = '&amp;',
		['<' ] = '&lt;',
		['>' ] = '&gt;',
		['\n'] = '<br/>'
	}

	return str
		:gsub('[&<>\n]', replacements)
		:gsub(' +', function(s)
			return ' '..('&nbsp;'):rep(#s-1)
		end)
end

AddEventHandler('playerConnecting', function(name, setCallback, deferrals) 
    local src = source
    local license, identifier, liveid, xblid, discord, playerip = nil, nil, nil, nil, nil, nil
	for k,v in ipairs(GetPlayerIdentifiers(src))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
            identifier = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xblid  = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            playerip = v
        end
    end

	deferrals.defer()
    deferrals.update('Ban listesi kontrol ediliyor...')

    exports.ghmattimysql:execute('SELECT * FROM m3_banlist WHERE steam = @steam OR rockstar = @rockstar OR xbox = @xbox OR live = @live OR discord = @discord OR ip = @ip', {
        ['@steam'] = identifier,
        ['@rockstar'] = license,
        ['@xbox'] = xblid,
        ['@live'] = liveid,
        ['@discord'] = discord,
        ['@ip'] = playerip    
    }, function(results)
        if results[1] ~= nil or #results > 0 then
            for k = 1, #results, 1 do
                if results[k].time > ostime() then
                    deferrals.done('Bu sunucuda yasaklandınız!\nSebep: '..results[k].reason..'\nYasağın biteceği süre: '..os.date('%d.%m.%Y %H:%M', results[k].time))
                    return
                else
                    exports.ghmattimysql:execute('DELETE FROM m3_banlist WHERE id = @id', {['@id'] = results{k}.id})
                    deferrals.done()
                    return
                end
            end
        else
            deferrals.done()
        end
    end)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		print('[^2m3:admin^0] - ^1Scripti sunucu acikken yeniden baslatmayin!^0')
	end
end)

--weather&time
AvailableWeatherTypes = {
    'EXTRASUNNY', 
    'CLEAR', 
    'NEUTRAL', 
    'SMOG', 
    'FOGGY', 
    'OVERCAST', 
    'CLOUDS', 
    'CLEARING', 
    'RAIN', 
    'THUNDER', 
    'SNOW', 
    -- 'BLIZZARD', 
    'SNOWLIGHT', 
    'XMAS', 
    -- 'HALLOWEEN',
}

CurrentWeather = 'OVERCAST'
local baseTime = 0
local timeOffset = 0
local freezeTime = false
local newWeatherTimer = 20

function requestSync()
    TriggerClientEvent('m3:admin:client:updateWeather', -1, CurrentWeather)
    TriggerClientEvent('m3:admin:client:updateTime', -1, baseTime, timeOffset, freezeTime)
end

RegisterServerEvent('m3:admin:server:requestSync')
AddEventHandler('m3:admin:server:requestSync', function()
    local src = source
    TriggerClientEvent('m3:admin:client:updateWeather', src, CurrentWeather)
    TriggerClientEvent('m3:admin:client:updateTime', src, baseTime, timeOffset, freezeTime)
end)

RegisterServerEvent('m3:admin:server:requestAllSync')
AddEventHandler('m3:admin:server:requestAllSync', function()
    local src = source

    if havePermission(src, 'timeweather') then
        requestSync()
        notify(src, 'inform', 'Hava durumu ve zaman herkeste senkronize edildi.')
        discordselfLog(src, 'syncall')
    else
        unauthorizedLog(src, 'syncall')
    end
end)

RegisterServerEvent('m3:admin:server:freezeTime')
AddEventHandler('m3:admin:server:freezeTime', function()
    local src = source

    if havePermission(src, 'timeweather') then
        freezeTime = true
        requestSync()
        notify(src, 'inform', 'Saat akışı durduruldu.')
        discordselfLog(src, 'freezetime')
    else
        unauthorizedLog(src, 'freezetime')
    end
end)

RegisterServerEvent('m3:admin:server:unfreezeTime')
AddEventHandler('m3:admin:server:unfreezeTime', function()
    local src = source

    if havePermission(src, 'timeweather') then
        freezeTime = false
        requestSync()
        notify(src, 'inform', 'Saat akışı devam ettirildi.')
        discordselfLog(src, 'unfreezetime')
    else
        unauthorizedLog(src, 'unfreezetime')
    end
end)

RegisterServerEvent('m3:admin:server:changeWeather')
AddEventHandler('m3:admin:server:changeWeather', function(weather)
    local src = source

    if havePermission(src, 'timeweather') then
        local validWeatherType = false
        for i,wtype in ipairs(AvailableWeatherTypes) do
            if wtype == string.upper(weather) then
                validWeatherType = true
            end
        end
        if validWeatherType then
            notify(src, 'inform', 'Hava durumu '..weather..' olarak değiştirildi.')
            discordselfLog(src, 'changeweather', 'Hava Durumu:', weather)
            CurrentWeather = string.upper(weather)
            newWeatherTimer = 20
            requestSync()
        else
            notify(src, 'error', 'Hava durumu bulunamadı.')
        end
    else
        unauthorizedLog(src, 'changeweather')
    end
end)

RegisterServerEvent('m3:admin:server:changeTime')
AddEventHandler('m3:admin:server:changeTime', function(hour, minute)
    local src = source

    if havePermission(src, 'timeweather') then
        if tonumber(hour) ~= nil and tonumber(minute) ~= nil then
            local argh = tonumber(hour)
            local argm = tonumber(minute)
            if argh < 24 then
                ShiftToHour(argh)
            else
                ShiftToHour(0)
            end
            if argm < 60 then
                ShiftToMinute(argm)
            else
                ShiftToMinute(0)
            end
            notify(src, 'inform', 'Saat '..hour..':'..minute..' olarak değiştirildi.')
            discordselfLog(src, 'changetime', 'Saat:', hour..':'..minute)
            requestSync()
        else
            notify(src, 'error', 'Hatalı zaman girdiniz.')
        end
    else
        unauthorizedLog(src, 'changetime')
    end
end)

function ShiftToMinute(minute)
    timeOffset = timeOffset - ( ( (baseTime+timeOffset) % 60 ) - minute )
end

function ShiftToHour(hour)
    timeOffset = timeOffset - ( ( ((baseTime+timeOffset)/60) % 24 ) - hour ) * 60
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local newBaseTime = os.time(os.date("!*t"))/2 + 360
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
    end
end)

Citizen.CreateThread(function()
    local dynamicWeather = GetConvar('m3_admin_dynamicWeather', 'false')
    while dynamicWeather == 'true' do
        newWeatherTimer = newWeatherTimer - 1
        Citizen.Wait(60000)
        if newWeatherTimer == 0 then
            NextWeatherStage()
            newWeatherTimer = 20
        end
    end
end)

function NextWeatherStage()
    if CurrentWeather == 'CLEAR' or CurrentWeather == 'EXTRASUNNY' then
        local new = math.random(1, 2)
        if new == 1 then
            CurrentWeather = 'EXTRASUNNY'
        else
            CurrentWeather = 'OVERCAST'
        end
    elseif CurrentWeather == 'OVERCAST' then
        local new = math.random(1, 10)
        if new == 1 then
            CurrentWeather = 'EXTRASUNNY' 
        elseif new == 2 then
            CurrentWeather = 'CLOUDS'
        elseif new == 3 then
            CurrentWeather = 'CLEAR'
        elseif new == 4 then
            CurrentWeather = 'EXTRASUNNY'
        elseif new == 5 then
            CurrentWeather = 'SMOG'
        elseif new == 6 then
            CurrentWeather = 'CLEAR'
        elseif new == 7 then
            CurrentWeather = 'EXTRASUNNY'
        elseif new == 8 then
            CurrentWeather = 'CLEAR'
        elseif new == 9 then
            CurrentWeather = 'EXTRASUNNY'
        else
            CurrentWeather = 'FOGGY'
        end
    elseif CurrentWeather == 'THUNDER' then
        CurrentWeather = 'FOGGY'
    elseif CurrentWeather == 'SMOG' or CurrentWeather == 'FOGGY' then
        CurrentWeather = 'CLEAR'
    elseif CurrentWeather == 'CLOUDS' then
        CurrentWeather = 'THUNDER'
    end
    print('[^m3:admin^0] - Hava durumu '..CurrentWeather..' olarak degisti.')
    requestSync()
end