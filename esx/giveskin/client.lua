RegisterNetEvent('applyskin')
AddEventHandler('applyskin', function(skin)
    Citizen.CreateThread(function()
        local model = GetHashKey(skin)
        RequestModel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 2)
    end)
end)