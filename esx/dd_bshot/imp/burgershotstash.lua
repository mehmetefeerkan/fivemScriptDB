RegisterNetEvent("_rc_limitinv:openbshotInventory")
AddEventHandler("_rc_limitinv:openbshotInventory", function(data)
        setbshotInventoryData(data)
        openbshotInventory()
        SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
    end
)

function refreshbshotInventory()
    ESX.TriggerServerCallback("_rc_bshot:getbshotInventory", function(inventory)
            setbshotInventoryData(inventory)
        end,
        ESX.GetPlayerData().identifier
    )
end

function setbshotInventoryData(data)
    items = {}

    local bshotItems = data.items
    local bshotWeapons = data.weapons

    for i = 1, #bshotItems, 1 do
        local item = bshotItems[i]

        if item.count > 0 then
            item.type = "item_standard"
            item.usable = false
            item.rare = false
            item.weight = -1
            item.canRemove = false

            table.insert(items, item)
        end
    end

    -- for i = 1, #bshotWeapons, 1 do
    --     local weapon = bshotWeapons[i]

    --     if bshotWeapons[i].name ~= "WEAPON_UNARMED" then
    --         table.insert(
    --             items,
    --             {
    --                 label = ESX.GetWeaponLabel(weapon.name),
    --                 count = weapon.ammo,
    --                 weight = -1,
    --                 type = "item_weapon",
    --                 name = weapon.name,
    --                 usable = false,
    --                 rare = false,
    --                 canRemove = false
    --             }
    --         )
    --     end
    -- end

    SendNUIMessage(
        {
            action = "setSecondInventoryItems",
            itemList = items
        }
    )
end

function openbshotInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "bshot"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback("PutIntobshot", function(data, cb)
    -- if ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'bshot' then
    --     exports['dd_core']:notify('inform', 'Action invalid')
    -- else
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("_rc_bshot:putItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, count)
        end

        Wait(150)
        refreshbshotInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    -- end
end)

RegisterNUICallback("TakeFrombshot", function(data, cb)
    -- if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bshot' then
    --     exports['dd_core']:notify('inform', 'Action invalid')
    -- else
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("_rc_bshot:getItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number))
            openbshotInventory() 
        end

        Wait(150)
        refreshbshotInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    -- end
end)
----[[bshotStorage]]----
RegisterNetEvent("_rc_limitinv:openbshotStorageInventory")
AddEventHandler(
    "_rc_limitinv:openbshotStorageInventory",
    function(data)
        setPropertybshotStorageData(data)
        openbshotStorageInventory()
        SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
    end
)

function refreshPropertybshotStorageInventory()
    ESX.TriggerServerCallback("_rc_bshot:getbshotStorageInventory", function(inventory)
		setPropertybshotStorageData(inventory)
	end, ESX.GetPlayerData().identifier, currentbshotStorage)
end

function setPropertybshotStorageData(data)

    items = {}
	-- currentbshotStorage = data.stash_name
    -- SendNUIMessage(
    --             {
    --                 action = "setInfoText",
    --                 text = data.stash_name .." - Stash"
    --             }
    --         )

    local blackMoney = data.blackMoney
    local appleCoin = data.appleCoin
    local wetMoney = data.wetMoney
    local chequeMoney = data.chequeMoney
    local propertyItems = data.items
    local propertyWeapons = data.weapons

    if blackMoney > 0 then
        accountData = {
            label = 'Black Money',
            count = blackMoney,
            type = "item_account",
            name = "black_money",
            usable = false,
            rare = false,
            limit = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end
    if appleCoin > 0 then
        accountData = {
            label = 'Apple Coin',
            count = appleCoin,
            type = "item_account",
            name = "apple_coin",
            usable = false,
            rare = false,
            weight = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end

    if wetMoney > 0 then
        accountData = {
            label = 'Wet Money',
            count = wetMoney,
            type = "item_account",
            name = "wet_money",
            usable = false,
            rare = false,
            weight = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end

    if chequeMoney > 0 then
        accountData = {
            label = 'Cheque',
            count = chequeMoney,
            type = "item_account",
            name = "cheque",
            usable = false,
            rare = false,
            weight = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end

    for i = 1, #propertyItems, 1 do
        local item = propertyItems[i]

        if item.count > 0 then
            item.type = "item_standard"
            item.usable = false
            item.rare = false
            item.limit = -1
            item.canRemove = false

            table.insert(items, item)
        end
    end

    for i = 1, #propertyWeapons, 1 do
        local weapon = propertyWeapons[i]

        if propertyWeapons[i].name ~= "WEAPON_UNARMED" then
            table.insert(
                items,
                {
                    label = ESX.GetWeaponLabel(weapon.name),
                    count = weapon.ammo,
                    limit = -1,
                    type = "item_weapon",
                    name = weapon.name,
                    usable = false,
                    rare = false,
                    canRemove = false
                }
            )
        end
    end

    SendNUIMessage(
        {
            action = "setSecondInventoryItems",
            itemList = items
        }
    )
end

function openbshotStorageInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "bshotStorage"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntobshotStorage",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("_rc_bshot:putbshotStorage", ESX.GetPlayerData().identifier, data.item.type, data.item.name, count, currentbshotStorage)
            AnimWood() 
        end

        Wait(150)
        refreshPropertybshotStorageInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFrombshotStorage",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("_rc_bshot:getbshotStorage", ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number), currentbshotStorage)
            AnimWood()
        end

        Wait(150)
        refreshPropertybshotStorageInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)