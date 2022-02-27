ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Id = 0

Units = {}
Calls = {}
UnitStatus = {}

RegisterServerEvent("Brn_dispach:playerStatus")
AddEventHandler(
    "Brn_dispach:playerStatus",
    function(status)
        local src = source

        if status.carPlate ~= "" then
            Units[src] = {plate = status.carPlate, type = status.type, job = status.job, netId = status.netId}
        else
            Units[src] = nil
        end
    end
)

RegisterServerEvent("Brn_dispach:removeCall")
AddEventHandler(
    "Brn_dispach:removeCall",
    function(id)
        Calls[tonumber(id)] = nil
    end
)

RegisterServerEvent("Brn_dispach:changeStatus")
AddEventHandler(
    "Brn_dispach:changeStatus",
    function(userid, status)


        UnitStatus[userid] = status


    end
)

RegisterServerEvent("Brn_dispach:unitDismissed")
AddEventHandler(
    "Brn_dispach:unitDismissed",
    function(id, job)
        local src = source
        local count = 1

        for _, v in ipairs(Calls[tonumber(id)].respondingUnits) do
            if v.unit == src then
                table.remove(Calls[tonumber(id)].respondingUnits, count)
            end
            count = count + 1
        end
    end
)

RegisterServerEvent("Brn_dispach:unitResponding")
AddEventHandler(
    "Brn_dispach:unitResponding",
    function(id, job)
        local src = source
        table.insert(Calls[tonumber(id)].respondingUnits, {unit = src, type = job})
    end
)

RegisterServerEvent("Brn_dispach:forwardCall")
AddEventHandler(
    "Brn_dispach:forwardCall",
    function(id, job)
        local add = true
        for _, v in ipairs(Calls[tonumber(id)].job) do
            if v == job then
                add = false
            end
        end

        if add then
            table.insert(Calls[tonumber(id)].job, job)

            TriggerClientEvent("Brn_dispach:callAdded", -1, tonumber(id), Calls[tonumber(id)], job, 5000)
        end
    end
)

RegisterServerEvent("Brn_dispach:addMessage")
AddEventHandler(
    "Brn_dispach:addMessage",
    function(message, location, job, cooldown, sprite, color)
        local src = source
        local identifier = ESX.GetPlayerFromId(src).getIdentifier()
        local phone =
            MySQL.Sync.fetchScalar(
            "SELECT phone_number FROM users WHERE identifier = @identifier ",
            {["@identifier"] = identifier}
        )
        Calls[Id] = {
            code = "",
            title = "",
            extraInfo = {},
            respondingUnits = {},
            coords = location,
            job = {job},
            phone = phone,
            message = message,
            type = "message",
            caller = src
        }

        TriggerClientEvent("Brn_dispach:callAdded", -1, Id, Calls[Id], job, cooldown or 5000, sprite or 11, color or 5)

        Id = Id + 1


    end
)

RegisterServerEvent("Brn_dispach:addCall")
AddEventHandler(
    "Brn_dispach:addCall",
    function(code, title, info, location, job, cooldown, sprite, color)
        Calls[Id] = {
            code = code,
            title = title,
            extraInfo = info,
            respondingUnits = {},
            coords = location,
            job = {job},
            type = "call"
        }

        TriggerClientEvent("Brn_dispach:callAdded", -1, Id, Calls[Id], job, cooldown or 3500, sprite or 11, color or 5)


         Id = Id + 1
    end
)

RegisterServerEvent("Brn_dispach:arrivalNotice")
AddEventHandler(
    "Brn_dispach:arrivalNotice",
    function(caller)
    	if caller ~= nil then
        TriggerClientEvent("Brn_dispach:arrivalNotice", caller)
    end
    end
)

ESX.RegisterServerCallback(
    "Brn_dispach:getPersonalInfo",
    function(source, cb)
        local identifier = ESX.GetPlayerFromId(source).getIdentifier()
        local firstname =
            MySQL.Sync.fetchScalar(
            "SELECT firstname FROM users WHERE identifier = @identifier ",
            {["@identifier"] = identifier}
        )
        local lastname =
            MySQL.Sync.fetchScalar(
            "SELECT lastname FROM users WHERE identifier = @identifier ",
            {["@identifier"] = identifier}
        )

        cb(firstname, lastname)
    end
)

ESX.RegisterServerCallback(
    "Brn_dispach:getInfo",
    function(source, cb)
        local generated = {}

        for k, v in pairs(Units) do
            if GetPlayerPing(k) > 0 then
                local identifier = ESX.GetPlayerFromId(k).getIdentifier()
                local firstname =
                    MySQL.Sync.fetchScalar(
                    "SELECT firstname FROM users WHERE identifier = @identifier ",
                    {["@identifier"] = identifier}
                )
                local lastname =
                    MySQL.Sync.fetchScalar(
                    "SELECT lastname FROM users WHERE identifier = @identifier ",
                    {["@identifier"] = identifier}
                )

                if generated[v.plate] == nil then
                    generated[v.plate] = {
                        type = Config.Icons[v.type],
                        units = {{id = k, name = firstname .. " " .. lastname}},
                        job = v.job
                    }
                elseif generated[v.plate].job == v.job then
                    table.insert(generated[v.plate].units, {id = k, name = firstname .. " " .. lastname})
                end
            end
        end
        cb(generated, Calls, UnitStatus)
    end
)

ESX.RegisterServerCallback(
    "Brn_dispach:getUnits",
    function(source, cb)
        local generated = {}

        for k, v in pairs(Units) do
            if GetPlayerPing(k) > 0 then
                local identifier = ESX.GetPlayerFromId(k).getIdentifier()
                local firstname =
                    MySQL.Sync.fetchScalar(
                    "SELECT firstname FROM users WHERE identifier = @identifier ",
                    {["@identifier"] = identifier}
                )
                local lastname =
                    MySQL.Sync.fetchScalar(
                    "SELECT lastname FROM users WHERE identifier = @identifier ",
                    {["@identifier"] = identifier}
                )

                generated[k] = {netId = v.netId, firstname = firstname, lastname = lastname, type = v.type, job = v.job}
            end
        end
        cb(generated)
    end
)
