ESX = nil

TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
    end
)

RegisterServerEvent("core_weapon:removeItem")
AddEventHandler(
    "core_weapon:removeItem",
    function(itemName)
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeInventoryItem(itemName, 1)

        ESX.SavePlayer(
            xPlayer,
            function()
            end
        )
    end
)

RegisterServerEvent("core_weapon:getComponent")
AddEventHandler(
    "core_weapon:getComponent",
    function(itemName)
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeWeaponComponent("WEAPON_ASSAULTRIFLE", itemName)
        xPlayer.addInventoryItem(itemName, 1)
        ESX.SavePlayer(xPlayer, cb)
    end
)

ESX.RegisterServerCallback(
    "core_weapon:buyItem",
    function(source, cb, item, price)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getMoney() >= price then
            if xPlayer.canCarryItem(item, 1) then
                xPlayer.addInventoryItem(item, 1)
                xPlayer.removeMoney(price)
                cb(true)
            else
                cb(false)
            end
        else
            cb(false)
        end
    end
)

ESX.RegisterUsableItem(
    "weapon_clip_extended",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "weapon_clip_extended")
    end
)

ESX.RegisterUsableItem(
    "weapon_tint_green",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "weapon_tint_green")
    end
)

ESX.RegisterUsableItem(
    "weapon_tint_gold",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "weapon_tint_gold")
    end
)

ESX.RegisterUsableItem(
    "weapon_tint_pink",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "weapon_tint_pink")
    end
)

ESX.RegisterUsableItem(
    "weapon_tint_army",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "weapon_tint_army")
    end
)

ESX.RegisterUsableItem(
    "weapon_tint_lspd",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "weapon_tint_lspd")
    end
)

ESX.RegisterUsableItem(
    "weapon_tint_orange",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "weapon_tint_orange")
    end
)

ESX.RegisterUsableItem(
    "weapon_tint_platinum",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "weapon_tint_platinum")
    end
)

ESX.RegisterUsableItem(
    "armor",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "armor")
    end
)

ESX.RegisterUsableItem(
    "weapon_luxary_finish",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "weapon_luxary_finish")
    end
)

ESX.RegisterUsableItem(
    "pistol_clip",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "pistol_clip")
    end
)

ESX.RegisterUsableItem(
    "weapon_flashlight",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "weapon_flashlight")
    end
)

ESX.RegisterUsableItem(
    "weapon_suppressor",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "weapon_suppressor")
    end
)

ESX.RegisterUsableItem(
    "smg_clip",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "smg_clip")
    end
)

ESX.RegisterUsableItem(
    "lightsmg_clip",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "lightsmg_clip")
    end
)

ESX.RegisterUsableItem(
    "rifle_clip",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "rifle_clip")
    end
)

ESX.RegisterUsableItem(
    "shotgun_clip",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "shotgun_clip")
    end
)

ESX.RegisterUsableItem(
    "sniper_clip",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "sniper_clip")
    end
)

ESX.RegisterUsableItem(
    "sniper_clip_unmarked",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "sniper_clip", true)
    end
)

ESX.RegisterUsableItem(
    "shotgun_clip_unmarked",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "shotgun_clip", true)
    end
)

ESX.RegisterUsableItem(
    "rifle_clip_unmarked",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "rifle_clip", true)
    end
)

ESX.RegisterUsableItem(
    "pistol_clip_unmarked",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "pistol_clip", true)
    end
)

ESX.RegisterUsableItem(
    "smg_clip_unmarked",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "smg_clip", true)
    end
)

ESX.RegisterUsableItem(
    "lightsmg_clip_unmarked",
    function(source)
        TriggerClientEvent("core_weapon:useItem", source, "lightsmg_clip", true)
    end
)
