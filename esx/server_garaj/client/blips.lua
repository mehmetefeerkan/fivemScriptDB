for garage, garageData in pairs(Config.Garages) do
    local garageBlip = AddBlipForCoord(garageData["positions"]["menu"]["position"])

    SetBlipSprite(garageBlip, 357)
    SetBlipDisplay(garageBlip, 4)
    SetBlipScale (garageBlip, 0.50)
    SetBlipColour(garageBlip, 67)
    SetBlipAsShortRange(garageBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Garaj")
    EndTextCommandSetBlipName(garageBlip)
end