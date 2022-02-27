local onNight = false
local onThermal = false
local clearcommand = "goggles"

RegisterNetEvent("policegoggles:toggleNight")
AddEventHandler("policegoggles:toggleNight", function()
    local ped = PlayerPedId()

    if onNight then
        RequestAnimDict("missheist_agency2ahelmet")
        while not HasAnimDictLoaded("missheist_agency2ahelmet") do
            Citizen.Wait(1)
        end
        
        onNight = false
        onThermal = false
        SetSeethrough(false)
        SetNightvision(false)
        TaskPlayAnim(ped, "missheist_agency2ahelmet", "take_off_helmet_stand", 8.0, 8.0, 1500, 1, 1, 0, 0, 0)
        if GetPedPropIndex(ped, 0) == 116 then
            Citizen.Wait(1200)
            ClearPedProp(ped, 0)
        end
    elseif not onNight then
        RequestAnimDict("missheistdockssetup1hardhat@")
        while not HasAnimDictLoaded("missheistdockssetup1hardhat@") do
            Citizen.Wait(1)
        end
        onNight = true
        onThermal = false
        SetSeethrough(false)
        SetNightvision(true)
        TaskPlayAnim(ped, "missheistdockssetup1hardhat@", "put_on_hat", 8.0, 8.0, 1500, 1, 1, 0, 0, 0)
        Citizen.Wait(1500)
        SetPedPropIndex(ped, 0, 116, 0, true)
    end
end)

RegisterNetEvent("policegoggles:toggleThermal")
AddEventHandler("policegoggles:toggleThermal", function()
    local ped = PlayerPedId()

    if onThermal then
        RequestAnimDict("missheist_agency2ahelmet")
        while not HasAnimDictLoaded("missheist_agency2ahelmet") do
            Citizen.Wait(1)
        end
        onThermal = false
        onNight = false
        SetNightvision(false)
        SetSeethrough(false)
        TaskPlayAnim(ped, "missheist_agency2ahelmet", "take_off_helmet_stand", 8.0, 8.0, 1500, 1, 1, 0, 0, 0)
        if GetPedPropIndex(ped, 0) == 118 then
            Citizen.Wait(1200)
            ClearPedProp(ped, 0)
        end
    elseif not onThermal then
        onThermal = true
        onNight = false
        SetNightvision(false)
        SetSeethrough(true)
        TaskPlayAnim(ped, "missheistdockssetup1hardhat@", "put_on_hat", 8.0, 8.0, 1500, 1, 1, 0, 0, 0)
        Citizen.Wait(1500)
        SetPedPropIndex(ped, 0, 118, 0, true)
    end
end)

RegisterCommand(clearcommand, function()
    local ped = PlayerPedId()

    if GetPedPropIndex(ped, 0) == 118 or GetPedPropIndex(ped, 0) == 116 then
        RequestAnimDict("missheist_agency2ahelmet")
        while not HasAnimDictLoaded("missheist_agency2ahelmet") do
            Citizen.Wait(1)
        end
        TaskPlayAnim(ped, "missheist_agency2ahelmet", "take_off_helmet_stand", 8.0, 8.0, 1500, 1, 1, 0, 0, 0)
        Citizen.Wait(1500)
        ClearPedProp(ped, 0)
        onNight = false
        onThermal = false
        SetSeethrough(false)
        SetNightvision(false)
    end
end)
