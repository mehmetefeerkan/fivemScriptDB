isInInventory = false
ESX = nil
local openableself = true
local secondary = nil
local tradetarget = nil

local currentFast = nil
local fastItems = {
	[1] = nil,
	[2] = nil,
    [3] = nil,
    [4] = nil,
    [5] = nil
}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    TriggerServerEvent('m3:inventoryhud:server:freezeGarbages')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

Citizen.CreateThread( function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, Config.OpenControl) and IsInputDisabled(0) then
            openInventory()
        end
    end
end)

function openInventory()
    ESX.UI.Menu.CloseAll()-- this also closes any esx menus to prevent from society inventory duping
    if openableself then
        if not IsEntityPlayingAnim(PlayerPedId(), "random@mugging3", "handsup_standing_base", 3) then
            local pCoords = GetEntityCoords(PlayerPedId())
            local entity, entityDst = ESX.Game.GetClosestObject(Config.GarbageProps)

            if DoesEntityExist(entity) and entityDst <= 2 then
                -- TriggerServerEvent('m3:inventoryhud:server:freezeGarbage', entity)
                local x, y, z = table.unpack(GetEntityCoords(entity))
                local _, floorZ = GetGroundZFor_3dCoord(x, y, z)
                local name = 'Çöp Konteyneri-'..getOwnerFromCoordsForGarbage(vector3(x, y, floorZ))
                
                ESX.TriggerServerCallback('m3:inventoryhud:server:checkOpenable', function(openable)
                    if openable then
                        ESX.TriggerServerCallback('m3:inventoryhud:server:getGarbage', function(table)
                            SendNUIMessage({
                                action = "setInfoText",
                                text = name
                            })

                            SendNUIMessage({
                                action = "setSecondInventoryItems",
                                itemList = table
                            })

                            loadPlayerInventory()
                            isInInventory = true
                    
                            SendNUIMessage({
                                action = "display",
                                type = "garbage",
                                text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                            })
                            SetNuiFocus(true, true)
                            secondary = name
                        end, name)
                    else
                        loadPlayerInventory()
                        isInInventory = true
                
                        SendNUIMessage({
                            action = "display",
                            type = "normal",
                            text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                        })
                        SetNuiFocus(true, true)
                    end
                end, name, entity)
            else
                ESX.Streaming.RequestAnimDict('pickup_object', function()
                    TaskPlayAnim(PlayerPedId(), 'pickup_object', 'putdown_low', 8.0, -8, -1, 48, 0, 0, 0, 0)
                end)

                local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
                local name = 'Yer-'..getOwnerFromCoords(vector3(x, y, z))
                ESX.TriggerServerCallback('m3:inventoryhud:server:checkOpenable', function(openable)
                    if openable then
                        ESX.TriggerServerCallback('m3:inventoryhud:server:getDrop', function(table)
                            SendNUIMessage({
                                action = "setInfoText",
                                text = name
                            })

                            SendNUIMessage({
                                action = "setSecondInventoryItems",
                                itemList = table
                            })
                            loadPlayerInventory()
                            isInInventory = true
                    
                            SendNUIMessage({
                                action = "display",
                                type = "drop",
                                text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                            })
                            SetNuiFocus(true, true)
                            secondary = name
                        end, name)
                    else
                        loadPlayerInventory()
                        isInInventory = true
                
                        SendNUIMessage({
                            action = "display",
                            type = "normal",
                            text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                        })
                        SetNuiFocus(true, true)
                    end
                end, name)
            end
        else
            exports['mythic_notify']:DoHudText('error', 'Ellerin havadayken eşyalarına bakamazsın!', 3000)
        end
    else
        exports['mythic_notify']:DoHudText('error', 'Eşyalarına şuan bir başkası bakıyor!', 3000)
    end
end

function getOwnerFromCoords(coords)
    local x, y, z = table.unpack(coords)
    x = math.floor(math.round(x, 0))
    y = math.floor(math.round(y, 0))
    z = math.floor(math.round(z, 0))
    return 'x' .. x .. 'y' .. y .. 'z' .. z
end

function getOwnerFromCoordsForGarbage(coords)
    local x, y, z = table.unpack(coords)
    x = math.floor(math.round(x, 0))
    y = math.floor(math.round(y, 0))
    return 'x' .. x .. 'y' .. y
end

function math.round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function getCoordsFromOwner(drop)
    local x = tonumber(string.sub(string.match(drop, 'x[-]?%d+'), 2))
    local y = tonumber(string.sub(string.match(drop, 'y[-]?%d+'), 2))
    local z = tonumber(string.sub(string.match(drop, 'z[-]?%d+'), 2))
    return vector3(x, y, z)
end

RegisterNetEvent('m3:inventoryhud:client:freezeGarbage')
AddEventHandler('m3:inventoryhud:client:freezeGarbage', function(entity)
    FreezeEntityPosition(entity, true)
end)

RegisterNetEvent('m3:inventoryhud:client:forceClose')
AddEventHandler('m3:inventoryhud:client:forceClose', function()
    closeInventory()
end)

RegisterCommand('f2fix', function()
    closeInventory()
end)

function closeInventory()
    if secondary ~= nil then
        TriggerServerEvent('m3:inventoryhud:server:closeInv', secondary)
        secondary = nil
    end

    if tradetarget ~= nil then
        TriggerServerEvent('m3:inventoryhud:server:enableTargetInv', tradetarget)
        tradetarget = nil
    end

    isInInventory = false
    SendNUIMessage({
        action = "hide"
    })
    SetNuiFocus(false, false)
    
    openVehicle = nil
end

RegisterNUICallback("NUIFocusOff", function()
    closeInventory()
end)

RegisterNUICallback("GetNearPlayers",function(data, cb)
    local playerPed = PlayerPedId()
    local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
    local foundPlayers = false
    local elements = {}

    for i = 1, #players, 1 do
        if GetPlayerServerId(players[i]) ~= GetPlayerServerId(PlayerId()) then
            ESX.TriggerServerCallback('m3:inventoryhud:server:getCharacterName', function(result)

                table.insert(elements, {
                    label = result, --GetPlayerName(players[i]),
                    player = GetPlayerServerId(players[i])
                })
                
                foundPlayers = true
                SendNUIMessage({
                    action = "nearPlayers",
                    foundAny = foundPlayers,
                    players = elements,
                    item = data.item
                })
            end, GetPlayerServerId(players[i]))
        end
    end

    -- exports['mythic_notify']:DoHudText('error', 'Yakınında kimse yok!', 3000)
    cb("ok")
end)

RegisterNUICallback("UseItem", function(data, cb)
    if data.item.name ~= nil then
        TriggerServerEvent("esx:useItem", data.item.name)
    end

    if shouldCloseInventory(data.item.name) then
        closeInventory()
    else
        Citizen.Wait(150)
        loadPlayerInventory()
    end

    cb("ok")
end)

RegisterNUICallback("GiveItem", function(data, cb)
    local playerPed = PlayerPedId()
    local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
    local foundPlayer = false
    for i = 1, #players, 1 do
        if players[i] ~= GetPlayerServerId(PlayerId()) then
            if GetPlayerServerId(players[i]) == data.player then
                foundPlayer = true
            end
        end
    end

    if foundPlayer then
        if tonumber(data.number) == 0 then
            data.number = data.item.count
        end

        local count = tonumber(data.number)

        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end

        --anim
        ESX.Streaming.RequestAnimDict('mp_common', function()
            TaskPlayAnim(playerPed, 'mp_common', 'givetake1_a', 8.0, -8, -1, 48, 0, 0, 0, 0)
		end)

        if data.item.type == "item_money" then
            TriggerServerEvent("esx:giveInventoryItem", data.player, "item_money", data.item.name, count)
        elseif data.item.type == "item_account" then
            TriggerServerEvent("esx:giveInventoryItem", data.player, "item_account", data.item.name, count)
        elseif data.item.type == "item_weapon" then
            TriggerServerEvent("esx:giveInventoryItem", data.player, "item_weapon", data.item.name, count)
        elseif data.item.type == "item_standard" then
            TriggerServerEvent("esx:giveInventoryItem", data.player, "item_standard", data.item.name, count)
        end
        Wait(250)
        loadPlayerInventory()
    else
        exports['mythic_notify']:DoHudText('error', 'Yakınında kimse yok!', 3000)
    end
    cb("ok")
end)

function shouldCloseInventory(itemName)
    for index, value in ipairs(Config.CloseUiItems) do
        if value == itemName then
            return true
        end
    end

    return false
end

function shouldSkipAccount(accountName)
    for index, value in ipairs(Config.UnlistedAccountsList) do
        if value == accountName then
            return true
        end
    end

    return false
end

function loadPlayerInventory()
    ESX.TriggerServerCallback("m3:inventoryhud:server:getPlayerInventory", function(data)
        items = {}
        inventory = data.inventory
        accounts = data.accounts
        if not Config.ItemWeapons.Enabled then
            weapons = data.weapons
        else
            weapons = nil
        end
        if Config.UseWeight then
            weight = tonumber(data.weight)
            maxWeight = data.maxWeight

            if weight <= 0 then
                weight = 0
            end

            SendNUIMessage({
                action = "setWeight",
                text = weight.. " / " ..maxWeight.. " kg"
            })
        end

        if accounts ~= nil then
            for key, value in pairs(accounts) do
                if not shouldSkipAccount(accounts[key].name) then

                    if accounts[key].money > 0 then
                        accountData = {
                            label = accounts[key].label,
                            count = accounts[key].money,
                            type = "item_account",
                            name = accounts[key].name,
                            weight = 0
                        }
                        if not checkFastSlots(accounts[key]) then
                            table.insert(items, accountData)
                        end
                    end
                end
            end
        end

        if inventory ~= nil then
            for key, value in pairs(inventory) do
                if inventory[key].count <= 0 then
                    inventory[key] = nil
                else
                    inventory[key].type = "item_standard"
                    if not checkFastSlots(inventory[key]) then
                        table.insert(items, inventory[key])
                    end
                end
            end
        end

        if weapons ~= nil then
            for key, value in pairs(weapons) do
                local weaponHash = GetHashKey(weapons[key].name)
                local playerPed = PlayerPedId()
                if weapons[key].name ~= "WEAPON_UNARMED" then
                    local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                    local weaponData = {
                        label = Config.WeaponLabels[weapons[key].name],
                        count = ammo,
                        weight = 0,
                        type = "item_weapon",
                        name = weapons[key].name,
                    }
                    if not checkFastSlots(weaponData) then
                        table.insert(items, weaponData)
                    end
                end
            end
        end

        SendNUIMessage({
            action = "setItems",
            itemList = items,
            fastItems = fastItems
        })
    end, GetPlayerServerId(PlayerId()))
end

checkFastSlots = function(item)
    for i=1, 5, 1 do
        if fastItems[i] ~= nil then
            if fastItems[i].name == item.name then
                fastItems[i].count = item.count
                return true
            end
        end
    end
    return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if isInInventory then
            local playerPed = PlayerPedId()
            DisableAllControlActions(0)
            EnableControlAction(0, 47, true)
            EnableControlAction(0, 245, true)
            EnableControlAction(0, 38, true)
        end
    end
end)

DrawText3D = function(x, y, z, scale, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    if onScreen then 
      SetTextScale(0.30, 0.30)
      SetTextFont(0)
      SetTextProportional(1)
      SetTextColour(255, 255, 255, 215)
      SetTextEntry("STRING")
      SetTextCentre(1)
      AddTextComponentString(text)
      DrawText(_x,_y)
      local factor = (string.len(text)) / 250
      DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 140)
	end
end

--shops
Citizen.CreateThread( function()
    while ESX == nil or ESX.PlayerData.job == nil do 
        Citizen.Wait(10)
    end

    for k, v in pairs(Config.Shops) do
        if v.blip then
            for z, t in pairs(v.job) do
                if t == 'all' or ESX.PlayerData.job.name == t then
                    for val, coords in pairs(v.coords) do
                        local _blip = AddBlipForCoord(coords.x, coords.y, coords.z)

                        SetBlipSprite(_blip, v.blip.id or 1)
                        SetBlipDisplay(_blip, 4)
                        SetBlipScale(_blip, v.blip.scale or 0.5)
                        SetBlipColour(_blip, v.blip.color or 1)
                        SetBlipAsShortRange(_blip, true)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(v.blip.title or 'nil')
                        EndTextCommandSetBlipName(_blip)
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if ESX ~= nil and ESX.PlayerData.job ~= nil then
            local playerPed = PlayerPedId()
            local pcoords = GetEntityCoords(playerPed)
            for k, v in pairs(Config.Shops) do
                for z, t in pairs(v.job) do
                    if t == 'all' or ESX.PlayerData.job.name == t then
                        for val, coords in pairs(v.coords) do
                            local distance = GetDistanceBetweenCoords(pcoords.x, pcoords.y, pcoords.z, coords.x, coords.y, coords.z, true)
                            if distance < 10.0 then
                                DrawMarker(v.markerType or 1, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.markerSize.x or 0.2, v.markerSize.y or 0.2, v.markerSize.z or 0.2, v.markerColour.r or 55, v.markerColour.g or 255, v.markerColour.b or 55, 100, false, true, 2, true, false, false, false)
                                if distance < 1.0 then
                                    if v.use3dtext then
                                        DrawText3D(coords.x, coords.y, coords.z + 0.3, 0.35, v.msg or '[E]')
                                    else
                                        ESX.ShowHelpNotification(v.msg or '~INPUT_CONTEXT~')
                                    end
                                    if IsControlJustPressed(0, 38) then
                                        OpenShopInventory(v.items, k)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

OpenShopInventory = function(items, label)
    if openableself then
        SendNUIMessage({
            action = "setInfoText",
            text = label
        })
        ESX.TriggerServerCallback('m3:inventoryhud:server:getItemsInfo', function(table)
            SendNUIMessage({
                action = "setShopInventoryItems",
                itemList = table
            })
            loadPlayerInventory()
            isInInventory = true

            SendNUIMessage({
                action = "display",
                type = "shop",
                text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
            })
            SetNuiFocus(true, true)
        end, items)
    else
        exports['mythic_notify']:DoHudText('error', 'Eşyalarına şuan bir başkası bakıyor!', 3000)
    end
end

RegisterNUICallback("TakeFromShop", function(data, cb)
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        return
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        ESX.TriggerServerCallback("m3:inventoryhud:server:takeItemFromShop", function(result)
            if result then
                loadPlayerInventory()
                cb("ok")
            end
        end, data.item, tonumber(data.number), tonumber(data.item.price))
    end
end)

--drop
local drops = {}

RegisterNetEvent('m3:inventoryhud:client:registerDrop')
AddEventHandler('m3:inventoryhud:client:registerDrop', function(drop)
    for i=1, #drops, 1 do
        if drops[i] == drop then
            return
        end
    end

    table.insert(drops, drop)
end)

RegisterNetEvent('m3:inventoryhud:client:removeDrop')
AddEventHandler('m3:inventoryhud:client:removeDrop', function(drop)
    if #drops > 0 then
        for i=1, #drops, 1 do
            if drops[i] == drop then
                table.remove(drops, i)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if #drops > 0 then
            for i=1, #drops, 1 do
                local dropCoords = getCoordsFromOwner(drops[i])
                local playerPed = PlayerPedId()
                local pcoords = GetEntityCoords(playerPed)
                local distance = GetDistanceBetweenCoords(dropCoords.x, dropCoords.y, dropCoords.z, pcoords.x, pcoords.y, pcoords.z, true) 
                if distance < 20 then
                    DrawMarker(2, dropCoords.x, dropCoords.y, dropCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 255, 255, 100, false, true, 2, false, false, false, false)
                end
            end
        end
    end
end)

refreshDrop = function(drop)
    ESX.TriggerServerCallback('m3:inventoryhud:server:refreshDrop', function(table)
        SendNUIMessage({
            action = "setSecondInventoryItems",
            itemList = table
        })
    end, drop)
end

RegisterNUICallback("PutIntoDrop",function(data, cb)
    if data.number == 0 then
        data.number = data.item.count
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)

        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end

        ESX.TriggerServerCallback("m3:inventoryhud:server:putIntoDrop", function(result)
            if result ~= nil then
                if not IsEntityPlayingAnim(PlayerPedId(), 'pickup_object', 'putdown_low', 3) then
                    ESX.Streaming.RequestAnimDict('pickup_object', function()
                        TaskPlayAnim(PlayerPedId(), 'pickup_object', 'putdown_low', 8.0, -8, -1, 48, 0, 0, 0, 0)
                    end)
                end

                refreshDrop(secondary)
                Wait(150)
                loadPlayerInventory()
                Wait(150)
                cb("ok")

                if Config.ItemWeapons.Enabled then
                    if string.match(data.item.name, 'WEAPON_') then
                        RemoveWeapon(data.item.name)
                        currentWeapon = nil
                    end
                end
            end
        end, data.item, count, secondary)
    end
end)

RegisterNUICallback("TakeFromDrop",function(data, cb)
    if data.number == 0 then
        data.number = data.item.count
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        ESX.TriggerServerCallback("m3:inventoryhud:server:takeFromDrop", function(result)
            if result ~= nil then
                if not IsEntityPlayingAnim(PlayerPedId(), 'pickup_object', 'putdown_low', 3) then
                    ESX.Streaming.RequestAnimDict('pickup_object', function()
                        TaskPlayAnim(PlayerPedId(), 'pickup_object', 'putdown_low', 8.0, -8, -1, 48, 0, 0, 0, 0)
                    end)
                end

                refreshDrop(secondary)
                Wait(150)
                loadPlayerInventory()
                Wait(150)
                cb("ok")
            end
        end, data.item, tonumber(data.number), secondary)
    end
end)

---glovebox
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2)
        local playerPed = PlayerPedId()
        if IsControlJustReleased(0, Config.TrunkAndGloveboxOpenControl) and IsPedInAnyVehicle(playerPed) then
            local vehicle = GetVehiclePedIsIn(playerPed)
            if DoesEntityExist(vehicle) and Config.VehicleGloveboxs[tonumber(GetVehicleClass(vehicle))] > 0 then
                if (GetPedInVehicleSeat(vehicle, -1) == playerPed) or (GetPedInVehicleSeat(vehicle, 0) == playerPed) then
                    OpenGlovebox(GetVehicleNumberPlateText(vehicle)..'- '..GetVehicleClass(vehicle))
                end
            end
        end
    end
end)

OpenGlovebox = function(platetype)
    if openableself then
        local name = 'Torpido-'..platetype
        ESX.TriggerServerCallback('m3:inventoryhud:server:checkOpenable', function(openable)
            if openable then
                ESX.TriggerServerCallback('m3:inventoryhud:server:getGlovebox', function(table)
                    SendNUIMessage({
                        action = "setInfoText",
                        text = name
                    })

                    -- if Config.UseWeight then
                        local weight = 0
                        local maxWeight = Config.VehicleGloveboxs[tonumber(string.reverse(string.sub(string.reverse(name), 1, 2)))]
                        if table ~= nil then
                            for i=1, #table, 1 do
                                if table[i].type ~= 'item_weapon' then
                                    weight = weight + (table[i].weight * table[i].count)
                                else
                                    weight = weight + (table[i].weight)
                                end
                            end
                        end
            
                        SendNUIMessage({
                            action = "setWeightSecondary",
                            text = weight.. " / " ..maxWeight.. " kg"
                        })
                    -- end
            
                    SendNUIMessage({
                        action = "setSecondInventoryItems",
                        itemList = table
                    })
                    loadPlayerInventory()
                    isInInventory = true
            
                    SendNUIMessage({
                        action = "display",
                        type = "glovebox",
                        text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                    })
                    SetNuiFocus(true, true)
                    secondary = name
                end, name)
            else
                loadPlayerInventory()
                isInInventory = true
        
                SendNUIMessage({
                    action = "display",
                    type = "normal",
                    text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                })
                SetNuiFocus(true, true)
            end
        end, name)
    else
        exports['mythic_notify']:DoHudText('error', 'Eşyalarına şuan bir başkası bakıyor!', 3000)
    end
end

refreshGlovebox = function(plate)
    ESX.TriggerServerCallback('m3:inventoryhud:server:refreshGlovebox', function(table)
        -- if Config.UseWeight then
            local weight = 0
            local maxWeight = Config.VehicleGloveboxs[tonumber(string.reverse(string.sub(string.reverse(plate), 1, 2)))]
            if table ~= nil then
                for i=1, #table, 1 do
                    if table[i].type ~= 'item_weapon' then
                        weight = weight + (table[i].weight * table[i].count)
                    else
                        weight = weight + (table[i].weight)
                    end
                end
            end

            SendNUIMessage({
                action = "setWeightSecondary",
                text = weight.. " / " ..maxWeight.. " kg"
            })
        -- end
        SendNUIMessage({
            action = "setSecondInventoryItems",
            itemList = table
        })
    end, plate)
end

RegisterNUICallback("PutIntoGlovebox",function(data, cb)
    if data.number == 0 then
        data.number = data.item.count
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)

        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end

        ESX.TriggerServerCallback("m3:inventoryhud:server:putIntoGlovebox", function(result)
            if result ~= nil then
                refreshGlovebox(secondary)
                Wait(150)
                loadPlayerInventory()
                Wait(150)
                cb("ok")

                if Config.ItemWeapons.Enabled then
                    if string.match(data.item.name, 'WEAPON_') then
                        RemoveWeapon(data.item.name)
                        currentWeapon = nil
                    end
                end
            end
        end, data.item, count, secondary)
    end
end)

RegisterNUICallback("TakeFromGlovebox",function(data, cb)
    if data.number == 0 then
        data.number = data.item.count
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        ESX.TriggerServerCallback("m3:inventoryhud:server:takeFromGlovebox", function(result)
            if result ~= nil then
                refreshGlovebox(secondary)
                Wait(150)
                loadPlayerInventory()
                Wait(150)
                cb("ok")
            end
        end, data.item, tonumber(data.number), secondary)
    end
end)

--trunk
local openVehicle

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2)
        if IsControlJustReleased(0, Config.TrunkAndGloveboxOpenControl) then
            local playerPed = PlayerPedId()
            local vehicle = ESX.Game.GetVehicleInDirection()
            if DoesEntityExist(vehicle) and GetVehiclePedIsIn(playerPed) == 0 then
                local locked = GetVehicleDoorLockStatus(vehicle) == 2
                local hasBoot = DoesVehicleHaveDoor(vehicle, 5)
                if not locked then
                    local boneIndex = GetEntityBoneIndexByName(vehicle, 'platelight')
                    local vehicleCoords = GetWorldPositionOfEntityBone(vehicle, boneIndex)
                    local playerCoords = GetEntityCoords(playerPed)
                    local distance = GetDistanceBetweenCoords(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, playerCoords.x, playerCoords.y, playerCoords.z, true)
                    if distance < 3 and Config.VehicleTrunks[tonumber(GetVehicleClass(vehicle))] > 0 then
                        OpenTrunk(GetVehicleNumberPlateText(vehicle)..'- '..GetVehicleClass(vehicle))
                        openVehicle = vehicle
                        SetVehicleDoorOpen(openVehicle, 5, false)
                        local playerPed = PlayerPedId()
                        if not IsEntityPlayingAnim(playerPed, 'mini@repair', 'fixing_a_player', 3) then
                            ESX.Streaming.RequestAnimDict('mini@repair', function()
                                TaskPlayAnim(playerPed, 'mini@repair', 'fixing_a_player', 8.0, -8, -1, 49, 0, 0, 0, 0)
                            end)
                        end
                    end
                end
            end
        end
    end
end)

OpenTrunk = function(platetype)
    if openableself then
        local name = 'Bagaj-'..platetype
        ESX.TriggerServerCallback('m3:inventoryhud:server:checkOpenable', function(openable)
            if openable then
                ESX.TriggerServerCallback('m3:inventoryhud:server:getTrunk', function(table)
                    SendNUIMessage({
                        action = "setInfoText",
                        text = name
                    })
                    
                    -- if Config.UseWeight then
                        local weight = 0
                        local maxWeight = Config.VehicleTrunks[tonumber(string.reverse(string.sub(string.reverse(name), 1, 2)))]
                        if table ~= nil then
                            for i=1, #table, 1 do
                                if table[i].type ~= 'item_weapon' then
                                    weight = weight + (table[i].weight * table[i].count)
                                else
                                    weight = weight + (table[i].weight)
                                end
                            end
                        end
            
                        SendNUIMessage({
                            action = "setWeightSecondary",
                            text = weight.. " / " ..maxWeight.. " kg"
                        })
                    -- end
            
                    SendNUIMessage({
                        action = "setSecondInventoryItems",
                        itemList = table
                    })
                    loadPlayerInventory()
                    isInInventory = true
            
                    SendNUIMessage({
                        action = "display",
                        type = "trunk",
                        text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                    })
                    SetNuiFocus(true, true)
                    secondary = name
                end, name)
            else
                loadPlayerInventory()
                isInInventory = true
        
                SendNUIMessage({
                    action = "display",
                    type = "normal",
                    text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                })
                SetNuiFocus(true, true)
            end
        end, name)
    else
        exports['mythic_notify']:DoHudText('error', 'Eşyalarına şuan bir başkası bakıyor!', 3000)
    end
end

RegisterNUICallback('NUIFocusOff', function()
    if openVehicle ~= nil then
        SetVehicleDoorShut(openVehicle, 5, false)
        openVehicle = nil
        ClearPedSecondaryTask(PlayerPedId())
    end
end)

refreshTrunk = function(plate)
    ESX.TriggerServerCallback('m3:inventoryhud:server:refreshTrunk', function(table)
        -- if Config.UseWeight then
            local weight = 0
            local maxWeight = Config.VehicleTrunks[tonumber(string.reverse(string.sub(string.reverse(plate), 1, 2)))]
            if table ~= nil then
                for i=1, #table, 1 do
                    if table[i].type ~= 'item_weapon' then
                        weight = weight + (table[i].weight * table[i].count)
                    else
                        weight = weight + (table[i].weight)
                    end
                end
            end

            SendNUIMessage({
                action = "setWeightSecondary",
                text = weight.. " / " ..maxWeight.. " kg"
            })
        -- end
        SendNUIMessage({
            action = "setSecondInventoryItems",
            itemList = table
        })
    end, plate)
end

RegisterNUICallback("PutIntoTrunk",function(data, cb)
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        return
    end

    if data.number == 0 then
        data.number = data.item.count
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)

        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end

        ESX.TriggerServerCallback("m3:inventoryhud:server:putIntoTrunk", function(result)
            if result ~= nil then
                refreshTrunk(secondary)
                Wait(150)
                loadPlayerInventory()
                Wait(150)
                cb("ok")

                if Config.ItemWeapons.Enabled then
                    if string.match(data.item.name, 'WEAPON_') then
                        RemoveWeapon(data.item.name)
                        currentWeapon = nil
                    end
                end
            end
        end, data.item, count, secondary)
    end
end)

RegisterNUICallback("TakeFromTrunk",function(data, cb)
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        return
    end

    if data.number == 0 then
        data.number = data.item.count
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        ESX.TriggerServerCallback("m3:inventoryhud:server:takeFromTrunk", function(result)
            if result ~= nil then
                refreshTrunk(secondary)
                Wait(150)
                loadPlayerInventory()
                Wait(150)
                cb("ok")
            end
        end, data.item, tonumber(data.number), secondary)
    end
end)

--garbages
refreshGarbage = function(garbage)
    ESX.TriggerServerCallback('m3:inventoryhud:refreshGarbage', function(table)
        SendNUIMessage({
            action = "setSecondInventoryItems",
            itemList = table
        })
    end, garbage)
end

RegisterNUICallback("PutIntoGarbage",function(data, cb)
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        return
    end

    if data.number == 0 then
        data.number = data.item.count
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)

        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end

        ESX.TriggerServerCallback("m3:inventoryhud:server:putIntoGarbage", function(result)
            if result ~= nil then
                refreshGarbage(secondary)
                Wait(150)
                loadPlayerInventory()
                Wait(150)
                cb("ok")

                if Config.ItemWeapons.Enabled then
                    if string.match(data.item.name, 'WEAPON_') then
                        RemoveWeapon(data.item.name)
                        currentWeapon = nil
                    end
                end
            end
        end, data.item, count, secondary)
    end
end)

RegisterNUICallback("TakeFromGarbage",function(data, cb)
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        return
    end

    if data.number == 0 then
        data.number = data.item.count
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        ESX.TriggerServerCallback("m3:inventoryhud:server:takeFromGarbage", function(result)
            if result ~= nil then
                refreshGarbage(secondary)
                Wait(150)
                loadPlayerInventory()
                Wait(150)
                cb("ok")
            end
        end, data.item, tonumber(data.number), secondary)
    end
end)

--stashs
Citizen.CreateThread( function()
    while true do
        Citizen.Wait(0)
        if ESX ~= nil and ESX.PlayerData.job ~= nil then
            local playerPed = PlayerPedId()
            local pcoords = GetEntityCoords(playerPed)
            for k, v in pairs(Config.Stashs) do
                if (v.job == 'all' or ESX.PlayerData.job.name == v.job) and v.useMarker then
                    for val, coords in pairs(v.coords) do
                        local distance = GetDistanceBetweenCoords(pcoords.x, pcoords.y, pcoords.z, coords.x, coords.y, coords.z, true)
                        if distance < 10.0 then
                            DrawMarker(v.markerType or 1, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.markerSize.x or 0.2, v.markerSize.y or 0.2, v.markerSize.z or 0.2, v.markerColour.r or 55, v.markerColour.g or 255, v.markerColour.b or 55, 100, false, true, 2, true, false, false, false)
                            if distance < 1.0 then
                                if v.use3dtext then
                                    DrawText3D(coords.x, coords.y, coords.z + 0.3, 0.35, v.msg or '[E]')
                                else
                                    ESX.ShowHelpNotification(v.msg or '~INPUT_CONTEXT~')
                                end
                                if IsControlJustPressed(0, 38) then
                                    OpenStash(k, v.job)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('m3:inventoryhud:client:openStash')
AddEventHandler('m3:inventoryhud:client:openStash', function(name, job)
    OpenStash(name, job)
end)

OpenStash = function(name, job)
    if openableself then
        if job ~= 'all' then
            ESX.TriggerServerCallback('m3:inventoryhud:server:checkOpenable', function(openable)
                if openable then
                    ESX.TriggerServerCallback('m3:inventoryhud:server:getStash', function(table)
                        SendNUIMessage({
                            action = "setInfoText",
                            text = name
                        })

                        if Config.UseWeight then
                            local weight = 0
                            local maxWeight = Config.Stashs[name].maxweight
                            if table ~= nil then
                                for i=1, #table, 1 do
                                    weight = weight + (table[i].weight * table[i].count)
                                end
                            end
                
                            SendNUIMessage({
                                action = "setWeightSecondary",
                                text = weight.. " / " ..maxWeight.. " kg"
                            })
                        end
                        SendNUIMessage({
                            action = "setSecondInventoryItems",
                            itemList = table
                        })
                        loadPlayerInventory()
                        isInInventory = true
                
                        SendNUIMessage({
                            action = "display",
                            type = "stash",
                            text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                        })
                        SetNuiFocus(true, true)
                        secondary = name
                    end, name)
                else
                    loadPlayerInventory()
                    isInInventory = true
            
                    SendNUIMessage({
                        action = "display",
                        type = "normal",
                        text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                    })
                    SetNuiFocus(true, true)
                end
            end, name)
        else
            ESX.TriggerServerCallback('m3:inventoryhud:server:getStash', function(table)
                SendNUIMessage({
                    action = "setInfoText",
                    text = name
                })

                if Config.UseWeight then
                    local weight = 0
                    local maxWeight = Config.Stashs[name].maxweight
                    if table ~= nil then
                        for i=1, #table, 1 do
                            weight = weight + (table[i].weight * table[i].count)
                        end
                    end
        
                    SendNUIMessage({
                        action = "setWeightSecondary",
                        text = weight.. " / " ..maxWeight.. " kg"
                    })
                end
                SendNUIMessage({
                    action = "setSecondInventoryItems",
                    itemList = table
                })
                loadPlayerInventory()
                isInInventory = true
        
                SendNUIMessage({
                    action = "display",
                    type = "stash",
                    text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                })
                SetNuiFocus(true, true)
                secondary = name
            end, name)
        end
    else
        exports['mythic_notify']:DoHudText('error', 'Eşyalarına şuan bir başkası bakıyor!', 3000)
    end
end

refreshStash = function(stashname)
    ESX.TriggerServerCallback('m3:inventoryhud:refreshStash', function(table)
        if Config.UseWeight then
            local weight = 0
            local maxWeight = Config.Stashs[stashname].maxweight
            if table ~= nil then
                for i=1, #table, 1 do
                    weight = weight + (table[i].weight * table[i].count)
                end
            end

            SendNUIMessage({
                action = "setWeightSecondary",
                text = weight.. " / " ..maxWeight.. " kg"
            })
        end
        SendNUIMessage({
            action = "setSecondInventoryItems",
            itemList = table
        })
    end, stashname)
end

RegisterNUICallback("PutIntoStash",function(data, cb)
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        return
    end

    if data.number == 0 then
        data.number = data.item.count
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)

        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end

        ESX.TriggerServerCallback("m3:inventoryhud:server:putIntoStash", function(result)
            if result ~= nil then
                refreshStash(secondary)
                Wait(150)
                loadPlayerInventory()
                Wait(150)
                cb("ok")

                if Config.ItemWeapons.Enabled then
                    if string.match(data.item.name, 'WEAPON_') then
                        RemoveWeapon(data.item.name)
                        currentWeapon = nil
                    end
                end
            end
        end, data.item, count, secondary)
    end
end)

RegisterNUICallback("TakeFromStash",function(data, cb)
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        return
    end

    if data.number == 0 then
        data.number = data.item.count
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        ESX.TriggerServerCallback("m3:inventoryhud:server:takeFromStash", function(result)
            if result ~= nil then
                refreshStash(secondary)
                Wait(150)
                loadPlayerInventory()
                Wait(150)
                cb("ok")
            end
        end, data.item, tonumber(data.number), secondary)
    end
end)

-- custom stashs
RegisterNetEvent('m3:inventoryhud:client:openCustomStash')
AddEventHandler('m3:inventoryhud:client:openCustomStash', function(name)
    OpenCustomStash(name)
end)

OpenCustomStash = function(name)
    if openableself then
        ESX.TriggerServerCallback('m3:inventoryhud:server:checkOpenable', function(openable)
            if openable then
                ESX.TriggerServerCallback('m3:inventoryhud:server:getCustomStash', function(table, maxweight)
                    SendNUIMessage({
                        action = "setInfoText",
                        text = name
                    })

                    if Config.UseWeight then
                        local weight = 0
                        local maxWeight = maxweight
                        if table ~= nil then
                            for i=1, #table, 1 do
                                weight = weight + (table[i].weight * table[i].count)
                            end
                        end
            
                        SendNUIMessage({
                            action = "setWeightSecondary",
                            text = weight.. " / " ..maxWeight.. " kg"
                        })
                    end
                    SendNUIMessage({
                        action = "setSecondInventoryItems",
                        itemList = table
                    })
                    loadPlayerInventory()
                    isInInventory = true
            
                    SendNUIMessage({
                        action = "display",
                        type = "customstash",
                        text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                    })
                    SetNuiFocus(true, true)
                    secondary = name
                end, name)
            else
                loadPlayerInventory()
                isInInventory = true
        
                SendNUIMessage({
                    action = "display",
                    type = "normal",
                    text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                })
                SetNuiFocus(true, true)
            end
        end, name)
    else
        exports['mythic_notify']:DoHudText('error', 'Eşyalarına şuan bir başkası bakıyor!', 3000)
    end
end

refreshCustomStash = function(stashname)
    ESX.TriggerServerCallback('m3:inventoryhud:refreshCustomStash', function(table, maxweight)
        if Config.UseWeight then
            local weight = 0
            local maxWeight = maxweight
            if table ~= nil then
                for i=1, #table, 1 do
                    weight = weight + (table[i].weight * table[i].count)
                end
            end

            SendNUIMessage({
                action = "setWeightSecondary",
                text = weight.. " / " ..maxWeight.. " kg"
            })
        end
        SendNUIMessage({
            action = "setSecondInventoryItems",
            itemList = table
        })
    end, stashname)
end

RegisterNUICallback("PutIntoCustomStash",function(data, cb)
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        return
    end

    if data.number == 0 then
        data.number = data.item.count
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)

        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end

        ESX.TriggerServerCallback("m3:inventoryhud:server:putIntoCustomStash", function(result)
            if result ~= nil then
                refreshCustomStash(secondary)
                Wait(150)
                loadPlayerInventory()
                Wait(150)
                cb("ok")

                if Config.ItemWeapons.Enabled then
                    if string.match(data.item.name, 'WEAPON_') then
                        RemoveWeapon(data.item.name)
                        currentWeapon = nil
                    end
                end
            end
        end, data.item, count, secondary)
    end
end)

RegisterNUICallback("TakeFromCustomStash",function(data, cb)
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        return
    end

    if data.number == 0 then
        data.number = data.item.count
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        ESX.TriggerServerCallback("m3:inventoryhud:server:takeFromCustomStash", function(result)
            if result ~= nil then
                refreshCustomStash(secondary)
                Wait(150)
                loadPlayerInventory()
                Wait(150)
                cb("ok")
            end
        end, data.item, tonumber(data.number), secondary)
    end
end)

-- notif
function SendNotify(msg, name, label, qty)
    print(msg)
    print(name)
    print(label)
    print(qty)
	local data = {}
    table.insert(data, {
        item = {
            label = label,
            itemId = name
        },
    })
    SendNUIMessage({
        action = msg,
        alerts = data
    })
    print("--------------------")
    print(data)
    print(msg)
end

RegisterNetEvent('esx:useItem')
AddEventHandler('esx:useItem', function(item)
    SendNotify('use', item.name, item.label, 1)
    exports['mythic_notify']:DoHudText('inform', item.label + "kullandın", 3000)
end) 

RegisterNetEvent('esx:dropItem')
AddEventHandler('esx:dropItem', function(item)
    if item.name == 'black_money' then
 		isDropBlackMoney = true
 		item.label = ('$%s'):format(item.label)
 	end

 	if item.name == 'money' then
 		isDropMoney = true
 		item.label = ('$%s'):format(item.label)
 	end

 	if item.name ~= nil and item.label ~= nil then
 		SendNotify('remove', item.name, item.label, 1)
 	end
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item, count)
    exports['mythic_notify']:DoHudText('inform', item.label + "kullandın", 3000)
	SendNotify('add', item.name, item.label, count)
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count)
	if item.name ~= nil and item.label ~= nil then
        SendNotify('remove', item.name, item.label, count)
        for i=1, #fastItems, 1 do
            if Config.ItemWeapons.Enabled then
                if fastItems[i].name == item.name then
                    if fastItems[i].count - count > 0 then
                        fastItems[i].count = fastItems[i].count - count
                    else
                        fastItems[i] = nil
                    end
                    if string.match(item.name, 'WEAPON_') then
                        RemoveWeapon(item.name)
                        currentWeapon = nil
                    end
                end
            else
                if fastItems[i].name == item.name then
                    if fastItems[i].count - count > 0 then
                        fastItems[i].count = fastItems[i].count - count
                    else
                        fastItems[i] = nil
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('esx:addWeapon')
AddEventHandler('esx:addWeapon', function(weaponName, ammo)
	local weaponLabel = Config.WeaponLabels[weaponName]
	local item = {
		name = weaponName,
		label = weaponLabel
	}
	SendNotify('add', item.name, item.label, 1)
end)

RegisterNetEvent('esx:dropWeapon')
AddEventHandler('esx:dropWeapon', function(weaponName)
	isDropWeapon = true	
end)

RegisterNetEvent('esx:removeWeapon')
AddEventHandler('esx:removeWeapon', function(weaponName, ammo)
	if not isDropWeapon	then
		local weaponLabel = Config.WeaponLabels[weaponName]
		local item = {
			name = weaponName,
			label = weaponLabel
		}
        SendNotify('remove', item.name, item.label, 1)
        if not Config.ItemWeapons.Enabled then
            if fastItems[i].name == item.name then
                if string.match(item.name, 'WEAPON_') then
                    SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
                    currentFast = 0
                end
            end
        end
	end
	isDropWeapon = false
end)

Citizen.CreateThread(function()
    if not Config.ItemWeapons.Enabled then
        local currentWeapon
        while true do
            if ESX ~= nil then
                local playerPed = PlayerPedId()
                if currentWeapon ~= GetSelectedPedWeapon(playerPed)then
                    currentWeapon = GetSelectedPedWeapon(playerPed)
                    local _, weapon = GetWeapon(currentWeapon)

                    if weapon ~= nil then

                        local item = {
                            name = weapon.name,
                            label = weapon.label
                        }

                        SendNotify('use', item.name, item.label, 1)
                    end
                end
            end
            Citizen.Wait(500)
        end
    end
end)

GetWeapon = function(weaponHash)
	local weapons = ESX.GetWeaponList()
	for i=1, #weapons, 1 do
		if GetHashKey(weapons[i].name) == weaponHash then
			return i, weapons[i]
		end
	end
end

--fast
RegisterNUICallback("PutIntoFast", function(data, cb)
    for i=1, #fastItems, 1 do
        if i ~= data.slot then
            if fastItems[i].name == data.item.name then
                fastItems[i] = nil
            end
        end
    end

    if data.item.slot ~= nil then
        fastItems[data.item.slot] = nil
    end
    fastItems[data.slot] = data.item
    fastItems[data.slot].slot = data.slot
    loadPlayerInventory()
    cb("ok")
end)
    
RegisterNUICallback("TakeFromFast", function(data, cb)
    fastItems[data.item.slot] = nil
    if Config.ItemWeapons.Enabled then
        if string.match(data.item.name, 'WEAPON_') then
            TriggerEvent('m3:inventoryhud:client:removeCurrentWeapon', data.item.name)
            currentWeapon = nil
        end
    else
        if currentFast == data.item.slot then
            SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
        end
    end
    if currentFast == data.item.slot then
        SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
    end
    loadPlayerInventory()
    cb("ok")
end)

RegisterNetEvent('m3:inventoryhud:client:clearFast')
AddEventHandler('m3:inventoryhud:client:clearFast', function()
    for i = 1, 5, 1 do
        fastItems[i] = nil
    end
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(3)
		HideHudComponentThisFrame(19)
		HideHudComponentThisFrame(20)
		BlockWeaponWheelThisFrame()
		DisableControlAction(0, 37, true)
	end
end)

local fastenabled = true
RegisterNetEvent('m3:inventoryhud:client:invUseable')
AddEventHandler('m3:inventoryhud:client:invUseable', function(variable)
    fastenabled = variable
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if fastenabled then
            if IsDisabledControlJustReleased(1, 157) then
                if fastItems[1] ~= nil then
                    if string.match(fastItems[1].name, 'WEAPON_') and not Config.ItemWeapons.Enabled then
                        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(fastItems[1].name) then
                            SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
                            currentFast = 0
                        else
                            SetCurrentPedWeapon(PlayerPedId(), fastItems[1].name, true)
                            SendNotify('use', fastItems[1].name, fastItems[1].label, 1)
                            currentFast = 1
                        end
                    else
                        if fastItems[1].name ~= nil then
                            TriggerServerEvent("esx:useItem", fastItems[1].name)
                            SendNotify('use', fastItems[1].name, fastItems[1].label, 1)
                        end
                    end
                end
            end
            if IsDisabledControlJustReleased(1, 158) then
                if fastItems[2] ~= nil then
                    if string.match(fastItems[2].name, 'WEAPON_') and not Config.ItemWeapons.Enabled then
                        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(fastItems[2].name) then
                            SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
                            currentFast = 0
                        else
                            SetCurrentPedWeapon(PlayerPedId(), fastItems[2].name, true)
                            SendNotify('use', fastItems[2].name, fastItems[2].label, 1)
                            currentFast = 2
                        end
                    else
                        if fastItems[2].name ~= nil then
                            TriggerServerEvent("esx:useItem", fastItems[2].name)
                            SendNotify('use', fastItems[2].name, fastItems[2].label, 1)
                        end
                    end
                end
            end
            if IsDisabledControlJustReleased(1, 160) then
                if fastItems[3] ~= nil then
                    if string.match(fastItems[3].name, 'WEAPON_') and not Config.ItemWeapons.Enabled then
                        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(fastItems[3].name) then
                            SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
                            currentFast = 0
                        else
                            SetCurrentPedWeapon(PlayerPedId(), fastItems[3].name, true)
                            SendNotify('use', fastItems[3].name, fastItems[3].label, 1)
                            currentFast = 3
                        end
                    else
                        if fastItems[3].name ~= nil then
                            TriggerServerEvent("esx:useItem", fastItems[3].name)
                            SendNotify('use', fastItems[3].name, fastItems[3].label, 1)
                        end
                    end
                end
            end
            if IsDisabledControlJustReleased(1, 164) then
                if fastItems[4] ~= nil then
                    if string.match(fastItems[4].name, 'WEAPON_') and not Config.ItemWeapons.Enabled then
                        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(fastItems[4].name) then
                            SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
                            currentFast = 0
                        else
                            SetCurrentPedWeapon(PlayerPedId(), fastItems[4].name, true)
                            SendNotify('use', fastItems[4].name, fastItems[4].label, 1)
                            currentFast = 4
                        end
                    else
                        if fastItems[4].name ~= nil then
                            TriggerServerEvent("esx:useItem", fastItems[4].name)
                            SendNotify('use', fastItems[4].name, fastItems[4].label, 1)
                        end
                    end
                end
            end
            if IsDisabledControlJustReleased(1, 165) then
                if fastItems[5] ~= nil then
                    if string.match(fastItems[5].name, 'WEAPON_') and not Config.ItemWeapons.Enabled then
                        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(fastItems[5].name) then
                            SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
                            currentFast = 0
                        else
                            SetCurrentPedWeapon(PlayerPedId(), fastItems[5].name, true)
                            SendNotify('use', fastItems[5].name, fastItems[5].label, 1)
                            currentFast = 5
                        end
                    else
                        if fastItems[5].name ~= nil then
                            TriggerServerEvent("esx:useItem", fastItems[5].name)
                            SendNotify('use', fastItems[5].name, fastItems[5].label, 1)
                        end
                    end
                end
            end
        end
    end
end)

--item weapons
local currentWeapon

RegisterNetEvent('m3:inventoryhud:client:useWeapon')
AddEventHandler('m3:inventoryhud:client:useWeapon', function(weapon)
    if currentWeapon ~= nil then
        if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(currentWeapon) then
            RemoveWeapon(currentWeapon)
            currentWeapon = nil
            return
        else
            RemoveWeapon(currentWeapon)

            currentWeapon = weapon
            GiveWeapon(currentWeapon)
            ClearPedTasks(PlayerPedId())
        end
    else
        currentWeapon = weapon
        GiveWeapon(currentWeapon)
        ClearPedTasks(PlayerPedId())
    end
end)

RegisterNetEvent('m3:inventoryhud:client:removeCurrentWeapon')
AddEventHandler('m3:inventoryhud:client:removeCurrentWeapon', function()
    if currentWeapon ~= nil then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        ClearPedTasks(PlayerPedId())
    end
end)

function RemoveWeapon(weapon)
    local playerPed = PlayerPedId()
    local hash = GetHashKey(weapon)
    local ammoCount = GetAmmoInPedWeapon(playerPed, hash)
    TriggerServerEvent('m3:inventoryhud:server:updateAmmoCount', hash, ammoCount)
    RemoveWeaponFromPed(playerPed, hash)
    SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
end

function GiveWeapon(weapon)
    local checkh = Config.ItemWeapons.Throwables
    local playerPed = PlayerPedId()
    local hash = GetHashKey(weapon)
    ESX.TriggerServerCallback('m3:inventoryhud:server:getAmmoCount', function(ammoCount)
        GiveWeaponToPed(playerPed, hash, 1, false, true)
        if checkh[weapon] == hash then
            SetPedAmmo(playerPed, hash, 1)
        elseif Config.ItemWeapons.FuelCan == hash and ammoCount == nil then
            SetPedAmmo(playerPed, hash, 4500)
        else
            SetPedAmmo(playerPed, hash, ammoCount or 0)
        end
    end, hash)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        local player = PlayerPedId()
        if IsPedShooting(player) then
            for k, v in pairs(Config.ItemWeapons.Throwables) do
                if k == currentWeapon then
                    ESX.TriggerServerCallback('m3:inventoryhud:server:takePlayerItem', function(removed)
                        if removed then
                            TriggerEvent('m3:inventoryhud:client:removeCurrentWeapon')
                        end
                    end, currentWeapon, 1)
                end
            end
        end
    end
end)

--search
RegisterNetEvent('m3:inventoryhud:client:disableTargetInv')
AddEventHandler('m3:inventoryhud:client:disableTargetInv', function()
    openableself = false
end)

RegisterNetEvent('m3:inventoryhud:client:enableTargetInv')
AddEventHandler('m3:inventoryhud:client:enableTargetInv', function()
    openableself = true
end)

RegisterNetEvent('m3:inventoryhud:client:openPlayerInventory')
AddEventHandler('m3:inventoryhud:client:openPlayerInventory', function(target, type)
    targetplayer = GetPlayerFromServerId(target)
    if openableself then
        if type == 'admin' then
            local name = 'Oyuncu-'..target
            ESX.TriggerServerCallback('m3:inventoryhud:server:checkOpenable', function(openable)
                if openable then
                    TriggerServerEvent('m3:inventoryhud:server:disableTargetInv', target)
                    refreshTargetInventory(target)
                    Wait(150)
                    loadPlayerInventory()
                    Wait(150)
                    isInInventory = true

                    SendNUIMessage({
                        action = "display",
                        type = "player",
                        text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                    })
                    SetNuiFocus(true, true)
                    secondary = name
                else
                    loadPlayerInventory()
                    isInInventory = true
            
                    SendNUIMessage({
                        action = "display",
                        type = "normal",
                        text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                    })
                    SetNuiFocus(true, true)
                end
            end, name)
        elseif type == 'player' then
            if IsEntityPlayingAnim(GetPlayerPed(targetplayer), 'random@mugging3', 'handsup_standing_base', 3) then
                local name = 'Oyuncu-'..target
                ESX.TriggerServerCallback('m3:inventoryhud:server:checkOpenable', function(openable)
                    if openable then
                        TriggerServerEvent('m3:inventoryhud:server:disableTargetInv', target)
                        refreshTargetInventory(target)
                        Wait(150)
                        loadPlayerInventory()
                        Wait(150)
                        isInInventory = true

                        SendNUIMessage({
                            action = "display",
                            type = "player",
                            text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                        })
                        SetNuiFocus(true, true)
                        secondary = name
                    else
                        loadPlayerInventory()
                        isInInventory = true
                
                        SendNUIMessage({
                            action = "display",
                            type = "normal",
                            text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                        })
                        SetNuiFocus(true, true)
                    end
                end, name)
            else
                exports['mythic_notify']:DoHudText('error', 'Kişi ellerini kaldırmamış!', 3000)
            end
        elseif type == 'dead' then
            if IsEntityPlayingAnim(GetPlayerPed(targetplayer), "misslamar1dead_body", "dead_idle", 3) then
                local name = 'Oyuncu-'..target
                ESX.TriggerServerCallback('m3:inventoryhud:server:checkOpenable', function(openable)
                    if openable then
                        TriggerServerEvent('m3:inventoryhud:server:disableTargetInv', target)
                        refreshTargetInventory(target)
                        Wait(150)
                        loadPlayerInventory()
                        Wait(150)
                        isInInventory = true

                        SendNUIMessage({
                            action = "display",
                            type = "player",
                            text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                        })
                        SetNuiFocus(true, true)
                        secondary = name
                    else
                        loadPlayerInventory()
                        isInInventory = true
                
                        SendNUIMessage({
                            action = "display",
                            type = "normal",
                            text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                        })
                        SetNuiFocus(true, true)
                    end
                end, name)
            else
                exports['mythic_notify']:DoHudText('error', 'Kişi yaralı değil!', 3000)
            end
        elseif type == 'police' then
            if IsEntityPlayingAnim(GetPlayerPed(targetplayer), "random@mugging3", "handsup_standing_base", 3) or IsEntityPlayingAnim(GetPlayerPed(targetplayer), "mp_arresting", "idle", 3) then
                local name = 'Oyuncu-'..target
                ESX.TriggerServerCallback('m3:inventoryhud:server:checkOpenable', function(openable)
                    if openable then
                        TriggerServerEvent('m3:inventoryhud:server:disableTargetInv', target)
                        refreshTargetInventory(target)
                        Wait(150)
                        loadPlayerInventory()
                        Wait(150)
                        isInInventory = true

                        SendNUIMessage({
                            action = "display",
                            type = "player",
                            text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                        })
                        SetNuiFocus(true, true)
                        secondary = name
                    else
                        loadPlayerInventory()
                        isInInventory = true
                
                        SendNUIMessage({
                            action = "display",
                            type = "normal",
                            text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                        })
                        SetNuiFocus(true, true)
                    end
                end, name)
            else
                exports['mythic_notify']:DoHudText('error', 'Kişiyi arayabilmen için kelepçeli veya ellerini kaldırmış olması gerekiyor!', 3000)
            end
        elseif type == 'sheriff' then
            if IsEntityPlayingAnim(GetPlayerPed(targetplayer), "random@mugging3", "handsup_standing_base", 3) or IsEntityPlayingAnim(GetPlayerPed(targetplayer), "mp_arresting", "idle", 3) then
                local name = 'Oyuncu-'..target
                ESX.TriggerServerCallback('m3:inventoryhud:server:checkOpenable', function(openable)
                    if openable then
                        TriggerServerEvent('m3:inventoryhud:server:disableTargetInv', target)
                        refreshTargetInventory(target)
                        Wait(150)
                        loadPlayerInventory()
                        Wait(150)
                        isInInventory = true

                        SendNUIMessage({
                            action = "display",
                            type = "player",
                            text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                        })
                        SetNuiFocus(true, true)
                        secondary = name
                    else
                        loadPlayerInventory()
                        isInInventory = true
                
                        SendNUIMessage({
                            action = "display",
                            type = "normal",
                            text = 'Oyuncu-'..GetPlayerServerId(PlayerId())
                        })
                        SetNuiFocus(true, true)
                    end
                end, name)
            else
                exports['mythic_notify']:DoHudText('error', 'Kişiyi arayabilmen için kelepçeli veya ellerini kaldırmış olması gerekiyor!', 3000)
            end
        end
    else
        exports['mythic_notify']:DoHudText('error', 'Eşyalarına şuan bir başkası bakıyor!', 3000)
    end
end)

refreshTargetInventory = function(target)
    local name = 'Oyuncu-'..target
    tradetarget = target
	ESX.TriggerServerCallback("m3:inventoryhud:server:getPlayerInventory", function(data)
        items = {}
        inventory = data.inventory
        accounts = data.accounts
        if not Config.ItemWeapons.Enabled then
            weapons = data.weapons
        else
            weapons = nil
        end
        if Config.UseWeight then
            weight = data.weight
            maxWeight = data.maxWeight

            SendNUIMessage({
                action = "setWeightSecondary",
                text = weight.. " / " ..maxWeight.. " kg"
            })
        end

        if accounts ~= nil then
            for key, value in pairs(accounts) do
                if not shouldSkipAccount(accounts[key].name) then

                    if accounts[key].money > 0 then
                        accountData = {
                            label = accounts[key].label,
                            count = accounts[key].money,
                            type = "item_account",
                            name = accounts[key].name,
                            usable = false,
                            weight = 0
                        }
                        table.insert(items, accountData)
                    end
                end
            end
        end

        if inventory ~= nil then
            for key, value in pairs(inventory) do
                if inventory[key].count <= 0 then
                    inventory[key] = nil
                else
                    inventory[key].type = "item_standard"
                    table.insert(items, inventory[key])
                end
            end
        end

        if weapons ~= nil then
            for key, value in pairs(weapons) do
                local weaponHash = GetHashKey(weapons[key].name)
                local playerPed = PlayerPedId()
                if weapons[key].name ~= "WEAPON_UNARMED" then
                    local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                    local weaponData = {
                        label = Config.WeaponLabels[weapons[key].name],
                        count = ammo,
                        weight = 0,
                        type = "item_weapon",
                        name = weapons[key].name,
                        -- usable = false
                    }
                    table.insert(items, weaponData)
                end
            end
        end

        SendNUIMessage({
            action = "setSecondInventoryItems",
            itemList = items
        })

        SendNUIMessage({
            action = "setInfoText",
            text = name
        })
    end, target)
end

RegisterNUICallback("PutIntoPlayer",function(data, cb)
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        return
    end

    if data.number == 0 then
        data.number = data.item.count
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)

        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end

        ESX.TriggerServerCallback('m3:inventoryhud:server:tradePlayerItem', function(result)
            if result ~= nil then
                refreshTargetInventory(tradetarget)
                Wait(150)
                loadPlayerInventory()
            end
        end, GetPlayerServerId(PlayerId()), tradetarget, data.item, tonumber(count))
    end
end)

RegisterNUICallback("TakeFromPlayer",function(data, cb)
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        return
    end

    if data.number == 0 then
        data.number = data.item.count
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        ESX.TriggerServerCallback('m3:inventoryhud:server:tradePlayerItem', function(result)
            if result ~= nil then
                refreshTargetInventory(tradetarget)
                Wait(150)
                loadPlayerInventory()
            end
        end, tradetarget, GetPlayerServerId(PlayerId()), data.item, tonumber(data.number))
    end
end)