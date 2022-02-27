ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local ped = PlayerPedId()
        local pCoords = GetEntityCoords(ped)
        local distance = Vdist2(pCoords, Config.TaxOffice.x, Config.TaxOffice.y, Config.TaxOffice.z)
        if distance < 125 then
            sleep = 5
            DrawMarker(2, Config.TaxOffice.x, Config.TaxOffice.y, Config.TaxOffice.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            if distance < 2 then
                DrawText3D(Config.TaxOffice.x, Config.TaxOffice.y, Config.TaxOffice.z + 0.4, '[E] - Tax Office')
                if IsControlJustPressed(0, 38) then
                    VergiKontrol()
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

function VergiKontrol()
    ESX.UI.Menu.Open(
        'dialog', GetCurrentResourceName(), 'vergi_kontrol',
        {
            title = ('Please enter a car plate.'),
        },
        function(data, menu)
            menu.close()
            --TriggerServerEvent('utx-cartax:returncar', data.value)
            ESX.TriggerServerCallback('utx-cartax:carinfo3', function(vergi)
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vergi_kontrol2',
                {
                    title    = 'Your car have '..vergi..'$ tax debt. Do you want to pay?',
                    align    = 'top-left',
                    elements = {
                        {label = 'Yes', value = 'evet'},
                        {label = 'No', value = 'hayir'}
                    }
                },
                function(data2, menu2)
                    if data2.current.value == 'evet' then
                        menu2.close()
                        TriggerServerEvent('utx-cartax:returncar', data.value)
                    elseif data2.current.value == 'hayir' then
                        menu2.close()
                    end
                end,
                function(data2, menu2)
                    menu2.close()
                end)
            end, data.value)
        end,
        function(data, menu)
        menu.close()
    end)
end

RegisterCommand('tax', function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    local plate = GetVehicleNumberPlateText(vehicle)
    local name = GetEntityModel(vehicle)
    ESX.TriggerServerCallback('utx-cartax:carinfo2', function(vergi)
        ESX.ShowNotification('Car\'s current tax: '..vergi..'$')
    end, plate)
    ESX.TriggerServerCallback('utx-cartax:carinfo', function(vergi, sinirvergi)
        ESX.ShowNotification('Car\'s daily tax: '..vergi..'$')
        ESX.ShowNotification('Car\'s limit tax: '..sinirvergi..'$')
    end, name)
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(vector3(Config.TaxOffice.x, Config.TaxOffice.y, Config.TaxOffice.z))

    SetBlipSprite (blip, Config.Blip.sprite)
    SetBlipScale  (blip, Config.Blip.scale)
    SetBlipColour (blip, Config.Blip.colour)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Tax Office')
    EndTextCommandSetBlipName(blip)
end)
