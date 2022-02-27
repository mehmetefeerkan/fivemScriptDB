ESX = nil
local IsDead = false
local level = -1


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)


RegisterNetEvent('fizzfau-armor:SmallArmor')
AddEventHandler('fizzfau-armor:SmallArmor', function()
    local inventory = ESX.GetPlayerData().inventory
    local ped = GetPlayerPed(-1)
    local armor = GetPedArmour(ped)
    local item = 'SmallArmor'

    if(armor >= 100) or (armor+30 > 100) then
        exports['mythic_notify']:SendAlert('error', 'Zaten bir yelek giydin!')
        TriggerServerEvent('returnItem', item)
        return
    end
    exports['mythic_progbar']:Progress({
        name = "smallb_armor",
        duration = 9500,
        label = 'Çelik Yelek Giyiliyor...',
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missmic4",
            anim = "michael_tux_fidget",
            flags = 49,
        },
    }, function(status)
        if not status then
            --SetPedComponentVariation(ped, 9, 10, 0, 0)
            SetPedArmour(ped, 20)
            exports['mythic_notify']:SendAlert('success', 'Hafif yeleği giydin!')
            level = 0
        end
    end)
end)

RegisterNetEvent('fizzfau-armor:MedArmor')
AddEventHandler('fizzfau-armor:MedArmor', function()
    local inventory = ESX.GetPlayerData().inventory
    local ped = GetPlayerPed(-1)
    local armor = GetPedArmour(ped)
    local item = 'MedArmor'

    if(armor >= 100) or (armor+30 > 100) then
        exports['mythic_notify']:SendAlert('error', 'Zaten bir yelek giydin!')
        TriggerServerEvent('returnItem', item)
        return
    end

    exports['mythic_progbar']:Progress({
        name = "smallb_armor",
        duration = 9500,
        label = 'Çelik Yelek Giyiliyor...',
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missmic4",
            anim = "michael_tux_fidget",
            flags = 49,
        },
    }, function(status)
        if not status then
            --SetPedComponentVariation(ped, 9, 10, 0, 0)
            SetPedArmour(ped, 60)
            exports['mythic_notify']:SendAlert('success', 'Ağır yeleği giydin!')
            level = 1
        end
    end)
end)

RegisterNetEvent('fizzfau-armor:HeavyArmor')
AddEventHandler('fizzfau-armor:HeavyArmor', function()
    local inventory = ESX.GetPlayerData().inventory
    local ped = GetPlayerPed(-1)
    local armor = GetPedArmour(ped)
    local item = 'HeavyArmor'

    if(armor >= 100) or (armor+30 > 100) then
        exports['mythic_notify']:SendAlert('error', 'Zaten bir yelek giydin!')
        TriggerServerEvent('returnItem', item)
        return
    end

    exports['mythic_progbar']:Progress({
        name = "smallb_armor",
        duration = 9500,
        label = 'Çelik Yelek Giyiliyor...',
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missmic4",
            anim = "michael_tux_fidget",
            flags = 49,
        },
    },
    function(status)
        if not status then
            --SetPedComponentVariation(ped, 9, 10, 0, 0)
            SetPedArmour(ped, 100)
            exports['mythic_notify']:SendAlert('success', 'Ağır yeleği giydin!')
            level = 2
        end
    end)
end)

RegisterNetEvent('fizzfau:armorcikra')
AddEventHandler('fizzfau:armorcikra', function()

    local ped = GetPlayerPed(-1)
    local armor = GetPedArmour(ped)
    local sikis = GetPedDrawableVariation(ped, 9)
    print(sikis .. " Kevlar numarasi")
    print(armor .. " Armor sayisi")
    if sikis == 10 then
        if armor >= 20 then
            exports['mythic_progbar']:Progress({
                name = "smallb_armor",
                duration = 9500,
                label = 'Çelik Yelek Çıkartılıyor...',
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                animDict = "missmic4",
                anim = "michael_tux_fidget",
                },
            },
            function(status)
                if not status then
                    --SetPedComponentVariation(ped, 9, 0, 0, 0)
                    SetPedArmour(ped, 0)
                    if level == 0 then
                        TriggerServerEvent("armor0")
                    elseif level == 1 then
                        TriggerServerEvent("armor1")
                    else
                        TriggerServerEvent("armor2")
                    end
                    exports['mythic_notify']:SendAlert('success', 'Yeleği Çıkardın!')
                end
            end)
        else 
            exports['mythic_notify']:SendAlert('error', 'Çelik yeleğini patlatıldı')
            exports['mythic_progbar']:Progress({
                name = "smallb_armor",
                duration = 9500,
                label = 'Çelik Yelek Çıkartılıyor...',
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "missmic4",
                    anim = "michael_tux_fidget",
                    flags = 49,
                },
            },
            function(status)
                if not status then
                    --SetPedComponentVariation(ped, 9, 0, 0, 0)
                    SetPedArmour(ped, 0)
                    exports['mythic_notify']:SendAlert('success', 'Yeleği Çıkardın!')
                end
            end)
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Üzerinde çelik yelek yok!')
    end
end)