Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        id = PlayerId()
        DisablePlayerVehicleRewards(id)
    end
end)