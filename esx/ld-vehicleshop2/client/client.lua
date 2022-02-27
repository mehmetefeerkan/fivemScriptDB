local lastSelectedVehicleEntity
local startCountDown
local testDriveEntity
local lastPlayerCoords
local hashListLoadedOnMemory = {}

local inTheShop = false
local profileName
local profileMoney

ESX                           = nil

Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


local rgbColorSelected = {
    255,255,255,
}

local rgbSecondaryColorSelected = {
    255,255,255,
}

local vehicleshopCoords = {
    vector3(-56.49, -1096.58, 26.42),
}

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(3)
            local ped = PlayerPedId()
            for i = 1, #vehicleshopCoords do
            local actualShop = vehicleshopCoords[i]
            local dist = #(actualShop - GetEntityCoords(ped))
                if dist <= 50.0 then                    
                    if dist <= 4.0 then                 
                        DrawText3Ds(actualShop.x, actualShop.y, actualShop.z,"~r~E~w~ Basarak Araçlara Bakın")
                    end
                    DrawMarker(23, actualShop.x, actualShop.y, actualShop.z - 0.97, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.7, 200, 10, 10, 100, 0, 0, 0, 0, 0, 0, 0)
                    if dist <= 2.0 then
                        if IsControlJustPressed(0, 38) then
                            OpenVehicleShop()
                        end
                    end
                end
            end
        end
    end
)


RegisterNetEvent('vehicleshop.receiveInfo')
AddEventHandler('vehicleshop.receiveInfo', function(bank, name)
    if name then
        profileName = name
    end
    profileMoney = bank
end)


RegisterNetEvent('vehicleshop.sussessbuy')
AddEventHandler('vehicleshop.sussessbuy', function(vehicleName,vehiclePlate,value)    
    SendNUIMessage(
        {
            type = "sussess-buy",
            vehicleName = vehicleName,
            vehiclePlate = vehiclePlate,
            value = value
        }
    )       
    CloseNui()
end)

RegisterNetEvent('vehicleshop.notify')
AddEventHandler('vehicleshop.notify', function(type, message)    
    SendNUIMessage(
        {
            type = "notify",
            typenotify = type,
            message = message,
        }
    ) 
end)

local vehiclesTable = {}

local provisoryObject = {}

RegisterNetEvent('vehicleshop.vehiclesInfos')
AddEventHandler('vehicleshop.vehiclesInfos', function(tableVehicles)      

    for _,value in pairs(tableVehicles) do
        vehiclesTable[value.category] = {}
    end

    for _,value in pairs(tableVehicles) do

        local vehicleModel = GetHashKey(value.model)
        local brandName

        if Config.Build2060 then
            brandName = GetLabelText(Citizen.InvokeNative(0xF7AF4F159FF99F97, vehicleModel, Citizen.ResultAsString()))    
        else
            brandName = nil
        end

        if brandName == nil then
            brandName = 'Custom'
        end    

        local vehicleName   

        if GetLabelText(value.model) == "NULL" then
            vehicleName = value.model:gsub("^%l", string.upper)
        else 
            vehicleName = GetLabelText(value.model)
        end

        provisoryObject = 
        {
            brand = brandName,
            name = vehicleName,
            price = value.price,
            model = value.model,
            qtd = value.stock
        }
        table.insert(vehiclesTable[value.category], provisoryObject)
    end
end)

function OpenVehicleShop()
    inTheShop = true
    local ped = PlayerPedId()

    TriggerServerEvent("vehicleshop.requestInfo")

    Citizen.Wait(1000)

    SendNUIMessage(
        {
            data = vehiclesTable,
            type = "display",
            playerName = profileName,
            playerMoney = profileMoney,
            testDrive = Config.TestDrive
        }
    )

    SetNuiFocus(true, true)

    RequestCollisionAtCoord(x, y, z)

    --SetEntityVisible(ped, false, 0)
    --SetEntityCoords(ped, 404.90, -949.58, -99.71, 0, 0, 0, false)

    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 974.1, -2997.94, -39.00, 216.5, 0.00, 0.00, 60.00, false, 0)
    PointCamAtCoord(cam, 979.1, -3003.00, -40.50)

    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1, true, true)
        
    SetFocusPosAndVel(974.1, -2997.94, -39.72, 0.0, 0.0, 0.0)

    DisplayHud(false)
    DisplayRadar(false)

    while inTheShop do
        Citizen.Wait(0)        
   --    DrawLightWithRange(404.99, -949.60, -98.98, 255, 255, 255, 20.000, 100.000)
    end

    if lastSelectedVehicleEntity ~= nil then
        DeleteEntity(lastSelectedVehicleEntity)
    end

end

function updateSelectedVehicle(model)
    local hash = GetHashKey(model)

    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end

    if lastSelectedVehicleEntity ~= nil then
        DeleteEntity(lastSelectedVehicleEntity)
    end
  --  lastSelectedVehicleEntity = CreateVehicle(hash, 404.99, -949.60, -99.98, 50.117, 0, 1)
    
  lastSelectedVehicleEntity = CreateVehicle(hash, 978.19, -3001.99, -40.62, 89.5, 0, 1)


    local vehicleData = {}

    
    vehicleData.traction = GetVehicleMaxTraction(lastSelectedVehicleEntity)


    vehicleData.breaking = GetVehicleMaxBraking(lastSelectedVehicleEntity) * 0.9650553    
    if vehicleData.breaking >= 1.0 then
        vehicleData.breaking = 1.0
    end

    vehicleData.maxSpeed = GetVehicleEstimatedMaxSpeed(lastSelectedVehicleEntity) * 0.9650553
    if vehicleData.maxSpeed >= 50.0 then
        vehicleData.maxSpeed = 50.0
    end

    vehicleData.acceleration = GetVehicleAcceleration(lastSelectedVehicleEntity) * 2.6
    if  vehicleData.acceleration >= 1.0 then
        vehicleData.acceleration = 1.0
    end


    SendNUIMessage(
        {
            data = vehicleData,
            type = "updateVehicleInfos",        
        }
    )

  --  SetVehicleCustomPrimaryColour(lastSelectedVehicleEntity,  rgbColorSelected[1], rgbColorSelected[2], rgbColorSelected[3])
  --  SetVehicleCustomSecondaryColour(lastSelectedVehicleEntity,  rgbSecondaryColorSelected[1], rgbSecondaryColorSelected[2], rgbSecondaryColorSelected[3])
    SetEntityHeading(lastSelectedVehicleEntity, 89.5)
end


function rotation(dir)
    local entityRot = GetEntityHeading(lastSelectedVehicleEntity) + dir
    SetEntityHeading(lastSelectedVehicleEntity, entityRot % 360)
end

RegisterNUICallback(
    "rotate",
    function(data, cb)
        if (data["key"] == "left") then
            rotation(2)
        else
            rotation(-2)
        end
        cb("ok")
    end
)


RegisterNUICallback(
    "SpawnVehicle",
    function(data, cb)
        updateSelectedVehicle(data.modelcar)
    end
)



RegisterNUICallback(
    "RGBVehicle",
    function(data, cb)
        if data.primary then
            rgbColorSelected = data.color
            SetVehicleCustomPrimaryColour(lastSelectedVehicleEntity, math.ceil(data.color[1]), math.ceil(data.color[2]), math.ceil(data.color[3]) )
        else
            rgbSecondaryColorSelected = data.color
            SetVehicleCustomSecondaryColour(lastSelectedVehicleEntity, math.ceil(data.color[1]), math.ceil(data.color[2]), math.ceil(data.color[3]))
        end
    end
)

RegisterNUICallback(
    "Buy",
    function(data, cb)

        local newPlate     = GeneratePlate()
        local vehicleProps = ESX.Game.GetVehicleProperties(lastSelectedVehicleEntity)
        vehicleProps.plate = newPlate

        TriggerServerEvent('vehicleshop.CheckMoneyForVeh',data.modelcar, data.sale, data.name, vehicleProps)

        Wait(1500)        
        -- SendNUIMessage(
        --     {
        --         type = "updateMoney",
        --         playerMoney = profileMoney
        --     }
        -- )
    end
)


RegisterNetEvent('vehicleshop.spawnVehicle')
AddEventHandler('vehicleshop.spawnVehicle', function(model, plate)    
    local hash = GetHashKey(model)

    lastPlayerCoords = GetEntityCoords(PlayerPedId())
    
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    
    local vehicleBuy = CreateVehicle(hash, -11.87, -1080.87, 25.71, 132.0, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    
    SetVehicleNumberPlateText(vehicleBuy, plate)
    
  --  SetVehicleCustomPrimaryColour(vehicleBuy,  math.ceil(rgbColorSelected[1]), math.ceil(rgbColorSelected[2]), math.ceil(rgbColorSelected[3]))
  --  SetVehicleCustomSecondaryColour(vehicleBuy,  math.ceil(rgbSecondaryColorSelected[1]), math.ceil(rgbSecondaryColorSelected[2]), math.ceil(rgbSecondaryColorSelected[3]))
end)




RegisterNUICallback(
    "TestDrive",
    function(data, cb)        
        if Config.TestDrive then
            startCountDown = true

            local hash = GetHashKey(data.vehicleModel)

            lastPlayerCoords = GetEntityCoords(PlayerPedId())

            if not HasModelLoaded(hash) then
                RequestModel(hash)
                while not HasModelLoaded(hash) do
                    Citizen.Wait(10)
                end
            end
        
            if testDriveEntity ~= nil then
                DeleteEntity(testDriveEntity)
            end
        
            testDriveEntity = CreateVehicle(hash, -11.87, -1080.87, 25.71, 132.0, 1, 1)
            SetPedIntoVehicle(PlayerPedId(), testDriveEntity, -1)
            local timeGG = GetGameTimer()

            
         --   SetVehicleCustomPrimaryColour(testDriveEntity,  math.ceil(rgbColorSelected[1]), math.ceil(rgbColorSelected[2]), math.ceil(rgbColorSelected[3]))
         --   SetVehicleCustomSecondaryColour(testDriveEntity,  math.ceil(rgbSecondaryColorSelected[1]), math.ceil(rgbSecondaryColorSelected[2]), math.ceil(rgbSecondaryColorSelected[3]))

            CloseNui()

            while startCountDown do
                local countTime
                Citizen.Wait(1)
                if GetGameTimer() < timeGG+tonumber(1000*Config.TestDriveTime) then
                    local secondsLeft = GetGameTimer() - timeGG
                    drawTxt(_U('testdrive') .. math.ceil(Config.TestDriveTime - secondsLeft/1000),4,0.5,0.93,0.50,255,255,255,180)
                else
                    DeleteEntity(testDriveEntity)
                    SetEntityCoords(PlayerPedId(), lastPlayerCoords)
                    startCountDown = false
                end
            end        
        end
    end
)


RegisterNUICallback(
    "menuSelected",
    function(data, cb)
        local categoryVehicles

        local playerIdx = GetPlayerFromServerId(source)
        local ped = GetPlayerPed(playerIdx)
        
        if data.menuId ~= 'all' then
            categoryVehicles = vehiclesTable[data.menuId]
        else
            SendNUIMessage(
                {
                    data = vehiclesTable,
                    type = "display",
                    playerName = GetPlayerName(ped)
                }
            )
            return
        end

        SendNUIMessage(
            {
                data = categoryVehicles,
                type = "menu"
            }
        )
    end
)


RegisterNUICallback(
    "Close",
    function(data, cb)
        CloseNui()       
    end
)

function CloseNui()
    SendNUIMessage(
        {
            type = "hide"
        }
    )
    SetNuiFocus(false, false)
    if inTheShop then
        if lastSelectedVehicleEntity ~= nil then
            DeleteVehicle(lastSelectedVehicleEntity)
        end
        RenderScriptCams(false)
        DestroyAllCams(true)
        SetFocusEntity(GetPlayerPed(PlayerId())) 
        DisplayHud(true)
        DisplayRadar(true)
    end
    inTheShop = false
end

-- function CloseNui()
--     SendNUIMessage(
--         {
--             type = "hide"
--         }
--     )
--     SetNuiFocus(false, false)

--     if inTheShop then
--         if lastSelectedVehicleEntity ~= nil then
--             DeleteEntity(lastSelectedVehicleEntity)
--         end

--         local  = PlayerPedId()
--     --  SetEntityVisible(ped, true, 0)        
--     --  SetEntityCoords(ped, -44.80, -1097.82, 26.42, 0, 0, 0, false)        
--         RenderScriptCams(false)
--         DestroyAllCams(true)
--         ClearFocus()
--         DisplayHud(true)
--         DisplayRadar(true)
--     end

--     inTheShop = false
-- end


function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end


local blip 

-- Create Blips
Citizen.CreateThread(function ()

    for i = 1, #vehicleshopCoords do    
        local actualShop = vehicleshopCoords[i]
        blip = AddBlipForCoord(actualShop.x, actualShop.y, actualShop.z)

        SetBlipSprite (blip, 326)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.8)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(_U('car_dealer'))
        EndTextCommandSetBlipName(blip)
    end
end)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
           CloseNui()
           RemoveBlip(blip)
        end
    end
)
