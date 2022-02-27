--====================================================================================
-- #XenKnighT
--====================================================================================

math.randomseed(os.time()) 
--[[

local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
    ESX.RegisterServerCallback('xentablet:getItemAmount', function(source, cb, item)
        print('xentablet:getItemAmount call item : ' .. item)
        local xPlayer = ESX.GetPlayerFromId(source)
        local items = xPlayer.getInventoryItem(item)
        if items == nil then
            cb(0)
        else
            cb(items.count)
        end
    end)
end)
--]]



--====================================================================================
--  OnLoad
--====================================================================================
AddEventHandler('es:playerLoaded',function(source)
    local sourcePlayer = tonumber(source)
end)

-- Just For reload
RegisterServerEvent('xentablet:allUpdate')
AddEventHandler('xentablet:allUpdate', function()
    local sourcePlayer = tonumber(source)
	TriggerEvent("Server_xentablet:getlicense", sourcePlayer)
end)


AddEventHandler('onMySQLReady', function ()
    -- MySQL.Async.fetchAll("DELETE FROM phone_messages WHERE (DATEDIFF(CURRENT_DATE,time) > 10)")
end)

function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end



