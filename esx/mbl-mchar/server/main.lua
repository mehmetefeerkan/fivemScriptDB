ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local IdentifierTablo = {
    {table = "playerskins", column = "citizenid"},
    {table = "player_outfits", column = "citizenid"},
    { table = "users", column = "identifier" },
    { table = "addon_account_data", column = "owner" },
    { table = "addon_inventory_items", column = "owner" },
    { table = "datastore_data", column = "owner" },
    { table = "disc_ammo", column = "owner" },
    { table = "disc_inventory", column = "owner" },
    { table = "owned_vehicles", column = "owner" },
    -- { table = "rented_vehicles", column = "owner" },
    { table = "user_licenses", column = "owner" },
    { table = "billing", column = "identifier" },
    { table = "society_moneywash", column = "identifier" },
}


RegisterServerEvent('mbl-mchar:server:disconnect')
AddEventHandler('mbl-mchar:server:disconnect', function()
    local src = source

    DropPlayer(src, "Jezzy Development")
end)

RegisterServerEvent('mbl-mchar:server:loadUserData')
AddEventHandler('mbl-mchar:server:loadUserData', function(cData)
    local src = source
    local cid = tonumber(cData.cid)
    local pos = GetSpawnPos(src, cid)
    SetLastCharacter(src, cid)
    SetCharToIdentifier(GetPlayerIdentifiers(src)[1], cid)
    TriggerClientEvent("esx:kashloaded",src)
    TriggerEvent("esx:onPlayerJoined")
    TriggerClientEvent('apartments:client:setupSpawnUI', src, false, pos,cData)
    print('^2[mbl-multichar]^7 '..GetPlayerName(src)..' (CID: '..cData.citizenid..') basarili bir sekilde yuklendi!')
end)

RegisterServerEvent('mbl-mchar:server:createCharacter')
AddEventHandler('mbl-mchar:server:createCharacter', function(data)
    local src = source
    local newData = {}
    newData.cid = data.cid
    newData = data
    --print(json.encode(data))
    local spawn = {}
    local cid = tonumber(data.cid)
    local identifiertest = GetPlayerIdentifiers(src)[1]
    local steamhex = GetPlayerIdentifiers(src)[1]
    SetLastCharacter(src, cid)
    SetCharToIdentifier(identifiertest, cid)
    spawn = { x = 195.55, y = -933.36, z = 29.90 } -- DEFAULT SPAWN POSITION
    TriggerClientEvent("esx:kashloaded",src)
    TriggerEvent("esx:onPlayerJoined")
    Citizen.Wait(7500)
    exports.ghmattimysql:execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height, `cid` = @cid WHERE identifier = @identifier', {
        ['@identifier']		= identifiertest,
        ['@firstname']		= data.firstname,
        ['@lastname']		= data.lastname,
        ['@dateofbirth']	= data.birthdate,
        ['@sex']			= data.gender,
        ['@height']			= 150,
        ['@cid']			= cid
    })
    print('^2[qb-multicharacter]^7 '..GetPlayerName(src)..' karakteri yüklendi!')
    TriggerClientEvent("mbl-mchar:client:closeNUI", src)
    TriggerClientEvent('apartments:client:setupSpawnUI', src, true,spawn,newData)
end)

RegisterServerEvent('mbl-mchar:server:deleteCharacter')
AddEventHandler('mbl-mchar:server:deleteCharacter', function(citizenid)
    local src = source
    DeleteCharacter(GetPlayerIdentifiers(src)[1], citizenid)
    TriggerClientEvent('qb-multicharacter:client:chooseChar',src)
end)

ESX.RegisterServerCallback("mbl-mchar:server:GetUserCharacters", function(source, cb)
    local steamId = GetPlayerIdentifier(source, 0)

    exports['ghmattimysql']:execute('SELECT * FROM users WHERE steam = @steam', {['@steam'] = steamId}, function(result)
        cb(result)
    end)
end)

-- ESX.RegisterServerCallback("mbl-mchar:server:GetServerLogs", function(source, cb)
--     exports['ghmattimysql']:execute('SELECT * FROM server_logs', function(result)
--         cb(result)
--     end)
-- end)

ESX.RegisterServerCallback("test:yeet", function(source, cb)
    local LastCharId = GetLastCharacter(source)
    SetIdentifierToChar(GetPlayerIdentifiers(source)[1], LastCharId)
    
    local Chars = exports.ghmattimysql:execute("SELECT * FROM `users` WHERE identifier LIKE '%"..GetIdentifierWithoutSteam(GetPlayerIdentifiers(source)[1]).."%'")
    for i = 1, #Chars, 1 do
        charJob = exports.ghmattimysql:execute("SELECT * FROM `jobs` WHERE `name` = '"..Chars[i].job.."'")
        charJobgrade = exports.ghmattimysql:execute("SELECT * FROM `job_grades` WHERE `grade` = '"..Chars[i].job_grade.."' AND `job_name` = '"..Chars[i].job.."'")
        local accounts = json.decode(Chars[i].accounts)
        Chars[i].bank = accounts["bank"]
        Chars[i].money = accounts["money"]
        Chars[i].job = charJob[1].label
        if charJob[1].label == "Unemployed" then
            Chars[i].job_grade = ""
        else
            Chars[i].job_grade = charJobgrade[1].label
        end
    end    
    cb(Chars)
end)

-- CashoutCore.Commands.Add("char", "Give the character menu to the player", {{name="id", help="Player ID"}}, false, function(source, args)
--     CashoutCore.Player.Logout(source)
--     TriggerClientEvent('mbl-mchar:client:chooseChar', source)
-- end, "admin")

-- CashoutCore.Commands.Add("closeNUI", "Give an item to a player", {{name="id", help="Player ID"},{name="item", help="Name of the item (no label)"}, {name="amount", help="Number of items"}}, false, function(source, args)
--     TriggerClientEvent('mbl-mchar:client:closeNUI', source)
-- end)

ESX.RegisterServerCallback("mbl-mchar:server:getSkin", function(source, cb, cid)
    local src = source

    CashoutCore.Functions.ExecuteSql(false, "SELECT * FROM `playerskins` WHERE `citizenid` = '"..cid.."' AND `active` = 1", function(result)
        if result[1] ~= nil then
            cb(result[1].model, result[1].skin)
        else
            cb(nil)
        end
    end)
end)

function GetIdentifierWithoutSteam(Identifier)
    return string.gsub(Identifier, "steam", "")
end

function exports.ghmattimysql:execute(query)
    local IsBusy = true
    local result = nil
    exports.ghmattimysql:execute(query, {}, function(data)
        result = data
        IsBusy = false
    end)
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end

ESX.RegisterServerCallback("qb-multicharacter:server:getSkin", function(source, cb, cid)
    exports.ghmattimysql:execute("SELECT * FROM `playerskins` WHERE `citizenid` = @citizenid AND `active` = 1", {
        ["@citizenid"] = cid,
    }, function(result)
        if result[1] ~= nil then
            cb(result[1].model, result[1].skin)
        else
            cb(nil)
        end
    end)
end)

function GetLastCharacter(source)
    local LastChar = exports.ghmattimysql:execute("SELECT `charid` FROM `user_lastcharacter` WHERE `license` = '"..GetPlayerIdentifiers(source)[1].."'")

    if LastChar[1] ~= nil and LastChar[1].charid ~= nil then
        return tonumber(LastChar[1].charid)
    else
        exports.ghmattimysql:execute("INSERT INTO `user_lastcharacter` (`license`, `charid`) VALUES('"..GetPlayerIdentifiers(source)[1].."', 1)")
        return 1
    end
end

function SetLastCharacter(source, charid)
    exports.ghmattimysql:execute("UPDATE `user_lastcharacter` SET `charid` = '"..charid.."' WHERE `license` = '"..GetPlayerIdentifiers(source)[1].."'")
end

function SetIdentifierToChar(identifier, charid)
    for _, itable in pairs(IdentifierTables) do
        exports.ghmattimysql:execute("UPDATE `"..itable.table.."` SET `"..itable.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."' WHERE `"..itable.column.."` = '"..identifier.."'")
    end
end

function SetCharToIdentifier(identifier, charid)
    for _, itable in pairs(IdentifierTables) do
        exports.ghmattimysql:execute("UPDATE `"..itable.table.."` SET `"..itable.column.."` = '"..identifier.."' WHERE `"..itable.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."'")
    end
end

function DeleteCharacter(identifier, charid)
    for _, itable in pairs(IdentifierTables) do
        exports.ghmattimysql:execute("DELETE FROM `"..itable.table.."` WHERE `"..itable.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."'")
    end
end

function GetSpawnPos(source,charid)
    local spawn = exports.ghmattimysql:execute("SELECT `position` FROM `users` WHERE `identifier` = 'Char"..charid..GetIdentifierWithoutSteam(GetPlayerIdentifiers(source)[1]).."'")
    return json.decode(spawn[1].position)
end