
-- CORE WEAPON

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


local pause = false
local guns = {}

Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end
    end
)

function OpenAttachmentStoreCategory(items, name)
    local elements = {}

    for k, f in pairs(items) do
        for _, v in ipairs(ESX.GetPlayerData().inventory) do
            if v.name == k then
                table.insert(
                    elements,
                    {label = v.label .. " " .. f .. "$", value = k, label_without = v.label, price = f}
                )
            end
        end
    end

    ESX.UI.Menu.Open(
        "default",
        GetCurrentResourceName(),
        "attachment_store_category",
        {
            title = name,
            align = "top-left",
            elements = elements
        },
        function(data2, menu2)
            ESX.TriggerServerCallback(
                "core_weapon:buyItem",
                function(paid)
                    if paid then
                        SendMessage(
                            string.gsub(Config.Text["successful_purchase"], "{item}", data2.current.label_without)
                        )
                    else
                        SendMessage(Config.Text["unsuccessful_purchase"])
                    end
                end,
                data2.current.value,
                data2.current.price
            )
        end,
        function(data2, menu2)
            menu2.close()
        end
    )
end

function OpenAttachmentStore()
    local elements = {}

    ESX.UI.Menu.Open(
        "default",
        GetCurrentResourceName(),
        "attachment_store",
        {
            title = Config.Text["attachment_store_name"],
            align = "top-left",
            elements = {
                {label = Config.Text["attachment_store_clip_category"], value = "clips"},
                {label = Config.Text["attachment_store_attachments_category"], value = "attachments"},
                {label = Config.Text["attachment_store_misc_category"], value = "misc"}
            }
        },
        function(data, menu)
            if data.current.value == "clips" then
                OpenAttachmentStoreCategory(Config.AttachmentStoreItems["weapon_clips"], data.current.label)
            elseif data.current.value == "attachments" then
                OpenAttachmentStoreCategory(Config.AttachmentStoreItems["weapon_attachments"], data.current.label)
            elseif data.current.value == "misc" then
                OpenAttachmentStoreCategory(Config.AttachmentStoreItems["misc"], data.current.label)
            end

            menu.close()
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function openMenu()
    local ped = GetPlayerPed(-1)
    local selected = GetSelectedPedWeapon(ped)
    local attachments = {}
    local weapons = ESX.GetWeaponList()
    local tint = GetPedWeaponTintIndex(ped, selected)

    local suppressor = ""
    local flashlight = ""
    local clip = ""
    local finish = ""
    local armor = ""

    if GetPedArmour(ped) > 0 then
        armor = "armor"
    end

    if tint ~= 0 then
        local tintAttachment = ""
        if tint == 1 then
            tintAttachment = "weapon_tint_green"
        elseif tint == 2 then
            tintAttachment = "weapon_tint_gold"
        elseif tint == 3 then
            tintAttachment = "weapon_tint_pink"
        elseif tint == 4 then
            tintAttachment = "weapon_tint_army"
        elseif tint == 5 then
            tintAttachment = "weapon_tint_lspd"
        elseif tint == 6 then
            tintAttachment = "weapon_tint_orange"
        elseif tint == 7 then
            tintAttachment = "weapon_tint_platinum"
        end

        finish = tintAttachment
    end

    for i = 1, #weapons, 1 do
        if GetHashKey(weapons[i].name) == selected then
            for j = 1, #weapons[i].components, 1 do
                local hash = weapons[i].components[j].hash
                if HasPedGotWeaponComponent(ped, selected, hash) then
                    local name = weapons[i].components[j].name
                    if name == "flashlight" then
                        flashlight = "weapon_" .. name
                    elseif name == "suppressor" then
                        suppressor = "weapon_" .. name
                    elseif name == "luxary_finish" then
                        finish = "weapon_" .. name
                    elseif name == "clip_extended" then
                        clip = "weapon_" .. name
                    end
                end
            end
        end
    end

    SetNuiFocus(true, true)
    SendNUIMessage(
        {
            type = "open",
            suppressor = suppressor,
            flashlight = flashlight,
            clip = clip,
            finish = finish,
            armor = armor
        }
    )
end

function RemoveAttachment(attachment)
    local ped = GetPlayerPed(-1)
    local selected = GetSelectedPedWeapon(ped)
    local tint = GetPedWeaponTintIndex(ped, selected)
    local hash = 0

    local weapons = ESX.GetWeaponList()

    for i = 1, #weapons, 1 do
        if GetHashKey(weapons[i].name) == selected then
            for j = 1, #weapons[i].components, 1 do
                if weapons[i].components[j].name == attachment then
                    hash = weapons[i].components[j].hash
                end
            end
        end
    end

    if HasPedGotWeaponComponent(ped, selected, hash) and not pause then
        pause = true
        local dict, anim = "mp_arresting", "a_uncuff"
        ESX.Streaming.RequestAnimDict(
            dict,
            function()
                TaskPlayAnim(ped, dict, anim, 3.0, 3.0, 1000, 51, 0, false, false, false)
            end
        )
        Citizen.Wait(1000)
        pause = false
        RemoveWeaponComponentFromPed(ped, selected, hash)
        SetPedWeaponTintIndex(ped, selected, 0)
        TriggerServerEvent("core_weapon:getComponent", "weapon_" .. attachment)
    elseif attachment == "luxary_finish" and tint ~= 0 and not pause then
        pause = true
        local tintAttachment = ""
        if tint == 1 then
            tintAttachment = "weapon_tint_green"
        elseif tint == 2 then
            tintAttachment = "weapon_tint_gold"
        elseif tint == 3 then
            tintAttachment = "weapon_tint_pink"
        elseif tint == 4 then
            tintAttachment = "weapon_tint_army"
        elseif tint == 5 then
            tintAttachment = "weapon_tint_lspd"
        elseif tint == 6 then
            tintAttachment = "weapon_tint_orange"
        elseif tint == 7 then
            tintAttachment = "weapon_tint_platinum"
        end

        local dict, anim = "mp_arresting", "a_uncuff"
        ESX.Streaming.RequestAnimDict(
            dict,
            function()
                TaskPlayAnim(ped, dict, anim, 3.0, 3.0, 1000, 51, 0, false, false, false)
            end
        )
        Citizen.Wait(1000)
        pause = false
        TriggerServerEvent("core_weapon:getComponent", tintAttachment)

        SetPedWeaponTintIndex(ped, selected, 0)
    end
end

function TryAddingTint(selected, tint, item)
    local ped = GetPlayerPed(-1)

    local current = GetPedWeaponTintIndex(ped, selected)

    if current ~= tint then
        if selected ~= GetHashKey("WEAPON_UNARMED") then
            local dict, anim = "mp_arresting", "a_uncuff"
            ESX.Streaming.RequestAnimDict(
                dict,
                function()
                    TaskPlayAnim(ped, dict, anim, 3.0, 3.0, 1000, 51, 0, false, false, false)
                end
            )
            Citizen.Wait(1000)
            SetPedWeaponTintIndex(ped, selected, tint)
            TriggerServerEvent("core_weapon:removeItem", item)
        else
            SendMessage(Config.Text["attachment_not_taken"])
        end
    else
        SendMessage(Config.Text["attachment_equipped"])
    end
end

function TryAddingAttachment(selected, attachment, item)
    local ped = GetPlayerPed(-1)

    local hash = 0

    local weapons = ESX.GetWeaponList()

    for i = 1, #weapons, 1 do
        if GetHashKey(weapons[i].name) == selected then
            for j = 1, #weapons[i].components, 1 do
                if weapons[i].components[j].name == attachment then
                    hash = weapons[i].components[j].hash
                end
            end
        end
    end

    if DoesWeaponTakeWeaponComponent(selected, hash) then
        if not HasPedGotWeaponComponent(ped, selected, hash) then
            local dict, anim = "mp_arresting", "a_uncuff"
            ESX.Streaming.RequestAnimDict(
                dict,
                function()
                    TaskPlayAnim(ped, dict, anim, 3.0, 3.0, 1000, 51, 0, false, false, false)
                end
            )
            Citizen.Wait(1000)

            GiveWeaponComponentToPed(ped, selected, hash)
            TriggerServerEvent("core_weapon:removeItem", item)
        else
            SendMessage(Config.Text["attachment_equipped"])
        end
    else
        SendMessage(Config.Text["attachment_not_taken"])
    end
end

function getWeaponType(hash)
    local ped = GetPlayerPed(-1)

    if GetWeapontypeGroup(hash) == -957766203 then
        return "submachine"
    end
    if GetWeapontypeGroup(hash) == 416676503 then
        return "pistol"
    end
    if GetWeapontypeGroup(hash) == 860033945 then
        return "shotgun"
    end
    if GetWeapontypeGroup(hash) == 970310034 then
        return "assault"
    end
    if GetWeapontypeGroup(hash) == 1159398588 then
        return "lightmachine"
    end
    if GetWeapontypeGroup(hash) == -1212426201 then
        return "sniper"
    end
    if GetWeapontypeGroup(hash) == -1569042529 then
        return "heavy"
    end

    return GetWeapontypeGroup(hash)
end

RegisterNUICallback(
    "getArmor",
    function(data)
        local ped = GetPlayerPed(-1)
        local armor = GetPedArmour(ped)

        if armor > 0 and not pause then
            pause = true

            local dict, anim = "clothingtie", "try_tie_negative_a"
            ESX.Streaming.RequestAnimDict(
                dict,
                function()
                    TaskPlayAnim(ped, dict, anim, 3.0, 3.0, 1200, 51, 0, false, false, false)
                end
            )
            Citizen.Wait(1100)

            if armor == 100 then
                TriggerServerEvent("core_weapon:getComponent", "armor")
            end

            SetPedComponentVariation(ped, 9, 0, 0, 0)

            SetPedArmour(ped, 0)
            pause = false
        end
    end
)

RegisterNUICallback(
    "getComponent",
    function(data)
        RemoveAttachment(data.component)
    end
)

RegisterNUICallback(
    "close",
    function(data)
        SetNuiFocus(false, false)
    end
)

Citizen.CreateThread(
    function()
        if Config.AttachmentStoreShowBlip then
            for _, v in ipairs(Config.AttachmentStores) do
                local blip = AddBlipForCoord(v)

                SetBlipSprite(blip, Config.AttachmentStoreBlip)
                SetBlipScale(blip, 0.8)
                SetBlipColour(blip, Config.AttachmentStoreBlipColor)
                SetBlipAsShortRange(blip, true)

                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(Config.AttachmentStoreBlipName)
                EndTextCommandSetBlipName(blip)
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            local ped = GetPlayerPed(-1)
            local pedCoords = GetEntityCoords(ped)

            for _, v in ipairs(Config.AttachmentStores) do
                local dst = GetDistanceBetweenCoords(pedCoords, v)
                if dst < 20 then
                    DrawMarker(
                        Config.AttachmentStoreMarker,
                        v[1],
                        v[2],
                        v[3] - 0.95,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        Config.AttachmentStoreMarkerSize,
                        Config.AttachmentStoreMarkerSize,
                        1.0,
                        Config.AttachmentStoreMarkerColor[1],
                        Config.AttachmentStoreMarkerColor[2],
                        Config.AttachmentStoreMarkerColor[3],
                        100,
                        false,
                        true,
                        2,
                        true,
                        false,
                        false,
                        false
                    )

                    if dst < Config.AttachmentStoreMarkerSize then
                        DrawText3D(v[1], v[2], v[3], Config.Text["open_attachment_store"])

                        if IsControlJustReleased(0, Keys["E"]) then
                            OpenAttachmentStore()
                        end
                    end

                    if dst < Config.AttachmentStoreMarkerSize + 1.0 and dst > Config.AttachmentStoreMarkerSize then
                        ESX.UI.Menu.CloseAll()
                    end
                end
            end

            Citizen.Wait(0)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlJustReleased(0, Keys[Config.UIOpenKey]) and Config.UIOpenKey ~= '' then
                openMenu()
            end
        end
    end
)

RegisterCommand(
    Config.OpenCommand,
    function()
        openMenu()
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(500)

            if Config.UsingCoreEvidence then
                local ped = GetPlayerPed(-1)
                local selectedWeapon = GetSelectedPedWeapon(ped)

                if guns[selectedWeapon] ~= true then
                    TriggerEvent("core_evidence:unmarkedBullets", false)
                else
                    TriggerEvent("core_evidence:unmarkedBullets", true)
                end
            end
        end
    end
)

RegisterNetEvent("core_weapon:useItem")
AddEventHandler(
    "core_weapon:useItem",
    function(item, unmarked)
        local ped = GetPlayerPed(-1)
        local selectedWeapon = GetSelectedPedWeapon(ped)

        if item == "pistol_clip" then
            if getWeaponType(selectedWeapon) == "pistol" then
                if GetAmmoInPedWeapon(ped, selectedWeapon) < GetWeaponClipSize(selectedWeapon) then
                    SetPedAmmo(ped, selectedWeapon, GetWeaponClipSize(selectedWeapon))

                    MakePedReload(GetPlayerPed(-1))
                  

                     if unmarked then
                        TriggerServerEvent("core_weapon:removeItem", item .. '_unmarked')
                        guns[selectedWeapon] = true
                    else
                        TriggerServerEvent("core_weapon:removeItem", item)
                        guns[selectedWeapon] = false
                    end
                else
                    SendMessage(Config.Text["clip_full"])
                end
            else
                SendMessage(Config.Text["wrong_clip"])
            end
        elseif item == "armor" then
            if GetPedArmour(ped) ~= 100 then
                local dict, anim = "clothingtie", "try_tie_negative_a"
                ESX.Streaming.RequestAnimDict(
                    dict,
                    function()
                        TaskPlayAnim(ped, dict, anim, 3.0, 3.0, 1200, 51, 0, false, false, false)
                    end
                )
                Citizen.Wait(1100)
                TriggerServerEvent("core_weapon:removeItem", item)

                local vest = GetPedDrawableVariation(PlayerPedId(), 9)

                if vest == -1 or vest == 0 and Config.SetVestIfNone then
                    SetPedComponentVariation(ped, 9, Config.VestId, 1, 0)
                end
                SetPedArmour(ped, 100)
            else
                SendMessage(Config.Text["full_armor"])
            end
        elseif item == "weapon_flashlight" then
            TryAddingAttachment(selectedWeapon, "flashlight", item)
        elseif item == "weapon_suppressor" then
            TryAddingAttachment(selectedWeapon, "suppressor", item)
        elseif item == "weapon_clip_extended" then
            TryAddingAttachment(selectedWeapon, "clip_extended", item)
        elseif item == "weapon_luxary_finish" then
            TryAddingAttachment(selectedWeapon, "luxary_finish", item)
        elseif item == "weapon_tint_platinum" then
            TryAddingTint(selectedWeapon, 7, item)
        elseif item == "weapon_tint_pink" then
            TryAddingTint(selectedWeapon, 3, item)
        elseif item == "weapon_tint_green" then
            TryAddingTint(selectedWeapon, 1, item)
        elseif item == "weapon_tint_gold" then
            TryAddingTint(selectedWeapon, 2, item)
        elseif item == "weapon_tint_army" then
            TryAddingTint(selectedWeapon, 4, item)
        elseif item == "weapon_tint_lspd" then
            TryAddingTint(selectedWeapon, 5, item)
        elseif item == "weapon_tint_orange" then
            TryAddingTint(selectedWeapon, 6, item)
        elseif item == "rifle_clip" then
            if getWeaponType(selectedWeapon) == "assault" then
                if GetAmmoInPedWeapon(ped, selectedWeapon) < GetWeaponClipSize(selectedWeapon) then
                    SetPedAmmo(ped, selectedWeapon, GetWeaponClipSize(selectedWeapon))

                    MakePedReload(GetPlayerPed(-1))

                    TriggerServerEvent("core_weapon:removeItem", item)

                    if unmarked then
                        TriggerServerEvent("core_weapon:removeItem", item .. '_unmarked')
                        guns[selectedWeapon] = true
                    else
                        TriggerServerEvent("core_weapon:removeItem", item)
                        guns[selectedWeapon] = false
                    end
                else
                    SendMessage(Config.Text["clip_full"])
                end
            else
                SendMessage(Config.Text["wrong_clip"])
            end
        elseif item == "lightsmg_clip" then
            if getWeaponType(selectedWeapon) == "lightmachine" then
                if GetAmmoInPedWeapon(ped, selectedWeapon) < GetWeaponClipSize(selectedWeapon) then
                    SetPedAmmo(ped, selectedWeapon, GetWeaponClipSize(selectedWeapon))

                    MakePedReload(GetPlayerPed(-1))

                    TriggerServerEvent("core_weapon:removeItem", item)

                     if unmarked then
                        TriggerServerEvent("core_weapon:removeItem", item .. '_unmarked')
                        guns[selectedWeapon] = true
                    else
                        TriggerServerEvent("core_weapon:removeItem", item)
                        guns[selectedWeapon] = false
                    end
                else
                    SendMessage(Config.Text["clip_full"])
                end
            else
                SendMessage(Config.Text["wrong_clip"])
            end
        elseif item == "shotgun_clip" then
            if getWeaponType(selectedWeapon) == "shotgun" then
                if GetAmmoInPedWeapon(ped, selectedWeapon) < GetWeaponClipSize(selectedWeapon) then
                    SetPedAmmo(ped, selectedWeapon, GetWeaponClipSize(selectedWeapon))

                    MakePedReload(GetPlayerPed(-1))

                    TriggerServerEvent("core_weapon:removeItem", item)

                   if unmarked then
                        TriggerServerEvent("core_weapon:removeItem", item .. '_unmarked')
                        guns[selectedWeapon] = true
                    else
                        TriggerServerEvent("core_weapon:removeItem", item)
                        guns[selectedWeapon] = false
                    end
                else
                    SendMessage(Config.Text["clip_full"])
                end
            else
                SendMessage(Config.Text["wrong_clip"])
            end
        elseif item == "sniper_clip" then
            if getWeaponType(selectedWeapon) == "sniper" then
                if GetAmmoInPedWeapon(ped, selectedWeapon) < GetWeaponClipSize(selectedWeapon) then
                    SetPedAmmo(ped, selectedWeapon, GetWeaponClipSize(selectedWeapon))

                    MakePedReload(GetPlayerPed(-1))

                    TriggerServerEvent("core_weapon:removeItem", item)

                    if unmarked then
                        TriggerServerEvent("core_weapon:removeItem", item .. '_unmarked')
                        guns[selectedWeapon] = true
                    else
                        TriggerServerEvent("core_weapon:removeItem", item)
                        guns[selectedWeapon] = false
                    end
                else
                    SendMessage(Config.Text["clip_full"])
                end
            else
                SendMessage(Config.Text["wrong_clip"])
            end
        elseif item == "smg_clip" then
            if getWeaponType(selectedWeapon) == "submachine" then
                if GetAmmoInPedWeapon(ped, selectedWeapon) < GetWeaponClipSize(selectedWeapon) then
                    SetPedAmmo(ped, selectedWeapon, GetWeaponClipSize(selectedWeapon))

                    MakePedReload(GetPlayerPed(-1))

                  

                    if unmarked then
                        TriggerServerEvent("core_weapon:removeItem", item .. '_unmarked')
                        guns[selectedWeapon] = true
                    else
                        TriggerServerEvent("core_weapon:removeItem", item)
                        guns[selectedWeapon] = false
                    end
                else
                    SendMessage(Config.Text["clip_full"])
                end
            else
                SendMessage(Config.Text["wrong_clip"])
            end
        end
    end
)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = ((1 / dist) * 2) * (1 / GetGameplayCamFov()) * 100

    if onScreen then
        SetTextColour(255, 255, 255, 255)
        SetTextScale(0.0 * scale, 0.35 * scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextCentre(true)

        SetTextDropshadow(1, 1, 1, 1, 255)

        BeginTextCommandWidth("STRING")
        AddTextComponentString(text)
        local height = GetTextScaleHeight(0.55 * scale, 4)
        local width = EndTextCommandGetWidth(4)

        SetTextEntry("STRING")
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end
