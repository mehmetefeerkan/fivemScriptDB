
local ppgangAim = true

Citizen.CreateThread(function()
    local ppaim = false

    while true do
        Citizen.Wait(7)

        if ppgangAim then
            if IsControlJustReleased(0, 178) then
                local playerPed = PlayerPedId()

                RequestAnimDict('combat@aim_variations@1h@gang')
                while not HasAnimDictLoaded('combat@aim_variations@1h@gang') do
                    Citizen.Wait(100)
                end

                if ppaim then
                    ppaim = false
                    ClearPedSecondaryTask(playerPed)
                else
                    ppaim = true
                    TaskPlayAnim(playerPed, 'combat@aim_variations@1h@gang', 'aim_variation_a', 3.0, -3.0, -1, 49, 0, 0, 0, 0)
                end
            end
        end
    end
end)