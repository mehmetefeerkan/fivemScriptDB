ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

local toghud = true

RegisterCommand('hud', function(source, args, rawCommand)

    if toghud then 
        toghud = false
    else
        toghud = true
    end

end)

RegisterNetEvent('hud:toggleui')
AddEventHandler('hud:toggleui', function(show)

    if show == true then
        toghud = true
    else
        toghud = false
    end

end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if toghud == true then
            if (not IsPedInAnyVehicle(PlayerPedId(), false) )then
                DisplayRadar(0)
            else
                DisplayRadar(1)
            end
        else
            DisplayRadar(0)
        end 
        
        TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
            TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)

                    local myhunger = hunger.getPercent() * 1.26
                    local mythirst = thirst.getPercent() * 1.26

                    SendNUIMessage({
                        action = "updateStatusHud",
                        show = toghud,
                        hunger = myhunger,
                        thirst = mythirst,
                    })
            end)
        end)
        Citizen.Wait(5000)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        local player = PlayerPedId()
        local health = (GetEntityHealth(player) - 100)
        local armor = GetPedArmour(player)
        local oxy = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 12.6
        local stamina = GetPlayerSprintTimeRemaining(PlayerId()) * 9.9
        -- local stealth = ''
        -- if (not IsPedInAnyVehicle(PlayerPedId(), false) )then
        --     stealth = GetPlayerCurrentStealthNoise(PlayerId()) * 6.8
        -- else
        --     stealth = GetPlayerCurrentStealthNoise(PlayerId()) * 0
        -- end

        SendNUIMessage({
            action = 'updateStatusHud',
            show = toghud,
            health = health,
            armour = armor,
            oxygen = oxy,
            stamina = stamina,
            -- stealth = stealth
        })
        Citizen.Wait(200)
    end
end)