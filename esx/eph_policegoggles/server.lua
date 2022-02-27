ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local whitelistedNight = true -- set false if you want to make night vision usable for everyone
local whitelistNight = { -- jobs that can use night vision
    "police"
}

local whitelistedThermal = true -- set false if you want to make thermal vision usable for everyone
local whitelistThermal = { -- jobs that can use thermal vision
    "police"
}

ESX.RegisterUsableItem("nightvision_goggles", function(source)
    local _source = source

    if whitelistedNight then
        local xPlayer = ESX.GetPlayerFromId(_source)
        local job = xPlayer.getJob()

        for i = 1, #whitelistNight, 1 do
            if job.name == whitelistNight[i] then
                TriggerClientEvent("policegoggles:toggleNight", _source)
                return
            end
        end
    else
        TriggerClientEvent("policegoggles:toggleNight", _source)
    end
end)

ESX.RegisterUsableItem("thermal_goggles", function(source)
    local _source = source

    if whitelistedThermal then
        local xPlayer = ESX.GetPlayerFromId(_source)
        local job = xPlayer.getJob()

        for i = 1, #whitelistThermal, 1 do
            if job.name == whitelistThermal[i] then
                TriggerClientEvent("policegoggles:toggleThermal", _source)
                return
            end
        end
    else
        TriggerClientEvent("policegoggles:toggleThermal", _source)
    end
end)