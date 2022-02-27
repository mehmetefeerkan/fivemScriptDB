local OwnedHouse = nil
local AvailableHouses = {}
local blips = {}
local Knockings = {}
PlayerData = {}


Citizen.CreateThread(function()
    while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Wait(0) end
    while ESX.GetPlayerData().job == nil do Wait(0) end
    TriggerServerEvent('loaf_housing:getOwned')
    while OwnedHouse == nil do Wait(0) end

    
    local DepoEv = AddBlipForCoord(vector3(Config.StashHouseBuy["x"], Config.StashHouseBuy["y"], Config.StashHouseBuy["z"]))
    SetBlipSprite(DepoEv, 375)
    SetBlipColour(DepoEv, 2)
    SetBlipAsShortRange(DepoEv, true)
    SetBlipScale(DepoEv, 0.7)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Depo Ev Satın Al")
    EndTextCommandSetBlipName(DepoEv)

    
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
    while true do
        sleepthread = 1000
        local playerPed = PlayerPedId()
        local pedCoords = GetEntityCoords(playerPed)
        
        for k, v in pairs(Config.Houses) do
            if Vdist2(pedCoords, v['door'])  <= 2.5 and v['marker'] == true and v['houseJob'] == PlayerData.job.name then
                sleepthread = 5
                DrawMarker(2, v['door'], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 100, false, true, 2, false, false, false, false)
            end
        end
        Citizen.Wait(sleepthread)
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)


RegisterCommand('stver', function()
    local player, distance = ESX.Game.GetClosestPlayer()

    for k, v in pairs(Config.Houses) do
        if Vdist2(GetEntityCoords(PlayerPedId()), v['door']) <= 2.5 then
            if OwnedHouse.houseId == k then
                if distance ~= -1 and distance <= 3.0 then
                    TriggerServerEvent('kagan-stash:setRoommate', GetPlayerServerId(player), k)
                else
                    exports['mythic_notify']:DoLongHudText('error', 'Yakınlarda oyuncu yok!')
                end
            else
                exports['mythic_notify']:DoLongHudText('error', 'Bu ev senin değil!')
            end
        end
    end
end)

RegisterCommand('stgir', function()
    for k, v in pairs(Config.Houses) do
        if Vdist2(GetEntityCoords(PlayerPedId()), v['door']) <= 2.5 then
            exports['np-taskbar']:taskBar(500, 'Şifre Giriliyor')
            TriggerEvent("trap:attempt", k)
        end
    end
end)

RegisterCommand('straid', function()
    for k, v in pairs(Config.Houses) do
        if Vdist2(GetEntityCoords(PlayerPedId()), v['door']) <= 2.5 and PlayerData.job.name == "police" then
            ESX.TriggerServerCallback('sp-housing:getPin', function(housepin)
                TriggerEvent("loaf_housing:eve-isinlan", k, housepin)
            end, k)
        end
    end
end)




Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local distance = #(GetEntityCoords(PlayerPedId()) - vector3(Config.StashHouseBuy["x"], Config.StashHouseBuy["y"], Config.StashHouseBuy["z"]))
        if distance < 10 then
            sleep = 7
            DrawMarker(2, Config.StashHouseBuy["x"], Config.StashHouseBuy["y"], Config.StashHouseBuy["z"]-0.25, vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(0.5, 0.5, 0.5), 255, 0, 0, 150, false, true, 2, false, false, false)
            if distance < 1.5 then
                TgiannDrawText3D(Config.StashHouseBuy["x"], Config.StashHouseBuy["y"], Config.StashHouseBuy["z"]+0.3, "[E] Depo Ev Satın Al")
                if IsControlJustReleased(0, 38) then
                    HouseBuyMenu()
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

function HouseBuyMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'houseBuyFirstMenu',
    {
        title    = 'Depo Evler',
        align    = 'left',
        elements = {
            {label = "Depo Ev Satın Al", value = "depo_ev"},
            {label = "Satın Aldığım Evler", value = "evlerim"},
            {label = "Satın Alınabilen Evleri Göster/Gizle", value = "evgoster"},
            {label = "Evinizin Şifresini Değiştirin", value = "evsifre"}
        }
    },function(data, menu)
        if data.current.value == "depo_ev" then
            BuyHouse()
        elseif data.current.value == "evlerim" then
            myHouse()
        elseif data.current.value == "evgoster" then  
            menu.close()
            satilanEvler()
        elseif data.current.value == 'evsifre' then
            menu.close()
            for k, v in pairs(Config.Houses) do
                if OwnedHouse.houseId == k then
                    ChangePassword(k)
                end
            end
        end
    end,function(data, menu)
        menu.close()
    end)
end


function BuyHouse()
    local elements = {}
    local Houses = Config.Houses
    for x, y in pairs(Houses) do
        table.insert(elements, {label =  x .." Nolu Depo Evi Satın Al $".. Houses[x]["price"], value = x})
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buyHouse',
    {
        title    = 'Depo Evi Satın Al',
        align    = 'left',
        elements = elements
    },function(data, menu)
        if data.current.value then
            local evNo = data.current.value
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buyHouseSoru',
            {
                title    = evNo .. ' Nolu Depo Evi Satın Almak İçin Eminmisin',
                align    = 'left',
                elements = {
                    {label =  "Evet", value = "yes"},
                    {label =  "Hayır", value = "no"}
                }
            },function(data2, menu2)
                menu2.close()
                if data2.current.value == "yes" then
                    ESX.UI.Menu.CloseAll()
                    TriggerServerEvent('loaf_housing:buyHouse', evNo)
                    ChangePassword(evNo)
                end
            end,function(data2, menu2)
                menu2.close()
            end)
        end
    end,function(data, menu)
        menu.close()
    end)
end

function ChangePassword(evNo)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Ev Şifresi', {
		title = "Ev Şifresini Giriniz",
	}, function (data2, menu)
        local password  = data2.value

        if password  ~= nil then 
            TriggerServerEvent("sp-housing:password", evNo, password )
            exports['mythic_notify']:DoLongHudText('inform', 'Şifreniz kayıt oldu!  '.. '=> ' .. password)
            menu.close()
        else
            exports['mythic_notify']:DoLongHudText('error', 'Geçersiz şifre!')
            menu.close()
		end
	end, function (data2, menu)
        menu.close()
	end)
end


-- Kendi evini gösterme ve satma
function myHouse()
    local elements = {}

    for k, v in pairs(Config.Houses) do
        if OwnedHouse.houseId == k then
            fiyat = math.floor(Config.Houses[k]['price']*(Config.SellPercentage/100))
            if anahtar then
                table.insert(elements, {label =  OwnedHouse.houseId .." Nolu Depo Evin Anahtarını Bırak", value = OwnedHouse.houseId, durum = "sat"})
            else
                table.insert(elements, {label =  OwnedHouse.houseId .." Nolu Depo Evi Sat $".. fiyat, value = OwnedHouse.houseId, durum = "sat"})
                table.insert(elements, {label =  "Evin Anahtarını Yakınındaki Kişiye Kopyala", value = OwnedHouse.houseId, durum = "anahtar"})
                table.insert(elements, {label =  "Evin Anahtarını Değiştir", value = OwnedHouse.houseId, durum = "anahtar_temizle"})
            end
        else
            table.insert(elements, {label = "Satın Aldığın Herhangi Bir Depo Ev Yok"})
        end
    end
    
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'myHouse',
    {
        title    = 'Depo Evlerim',
        align    = 'left',
        elements = elements
    },function(data, menu)
        if data.current.value then
            if data.current.durum == "sat" then
                if anahtar then 
                    yazi = data.current.value .. " Nolu Depo Evin Anahtarını Bırak"
                else
                    yazi = data.current.value .. " Nolu Depo Evi ".. fiyat .."$ Karşılığında Satmak İstediğinden Eminmisin"
                end

    
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'myHouseSoruMenu',
                {
                    title    = yazi,
                    align    = 'left',
                    elements = {
                        {label =  "Evet", value = "yes"},
                        {label =  "Hayır", value = "no"}
                    }
                },function(data2, menu2)
                    menu2.close()
                    if data2.current.value == "yes" then
                        ESX.UI.Menu.CloseAll()
                        TriggerServerEvent('loaf_housing:sellHouse', data.current.value, anahtar)
                    end
                end,function(data2, menu2)
                    menu2.close()
                end)
            elseif data.current.durum == "anahtar" then
                local player, distance = ESX.Game.GetClosestPlayer()
                if distance ~= -1 and distance <= 3.0 then
                    TriggerServerEvent('loaf_housing:anahtar-ver',  GetPlayerServerId(player), data.current.value)
                else
                    ESX.ShowNotification('Yakınlarda Kimse Yok')
                end

            elseif data.current.durum == "anahtar_temizle" then
                ESX.UI.Menu.CloseAll()
                TriggerServerEvent('loaf_housing:anahtar-temizle', data.current.value)
                ESX.ShowNotification('Evin Ana Anahtarı Değişti')
            end    
        end
    end,function(data, menu)
        menu.close()
    end)
end

function satilanEvler()
    if not goster then
        goster = true
        for k, v in pairs(Config.Houses) do
            CreateBlip(v['door'], 374, 0, 0.45, '')
        end
        ESX.ShowNotification('Haritada Satın Alınabilen Evler Açıldı')
    else
        goster = false
        for k, v in pairs(blips) do
            RemoveBlip(v)
        end
        ESX.ShowNotification('Haritada Satın Alınabilen Evler Kapatıldı')
    end
end


RegisterNetEvent('loaf_housing:leaveHouse')
AddEventHandler('loaf_housing:leaveHouse', function(house)
    DoScreenFadeOut(750)
    while not IsScreenFadedOut() do Wait(0) end
    SetEntityCoords(PlayerPedId(), Config.Houses[house]['door'])
    for i = 1, 25 do
        SetEntityCoords(PlayerPedId(),  Config.Houses[house]['door'])
        Wait(50)
    end
    while IsEntityWaitingForWorldCollision(PlayerPedId()) do
        SetEntityCoords(PlayerPedId(), Config.Houses[house]['door'])
        Wait(50)
    end
    DoScreenFadeIn(1500)
end)


RegisterNetEvent('loaf_housing:reloadHouses')
AddEventHandler('loaf_housing:reloadHouses', function()
    while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Wait(0) end
    while ESX.GetPlayerData().job == nil do Wait(0) end
    TriggerServerEvent('loaf_housing:getOwned')
end)


RegisterNetEvent('loaf_housing:setHouse')
AddEventHandler('loaf_housing:setHouse', function(house, purchasedHouses)
    OwnedHouse = house

    for k, v in pairs(blips) do
        RemoveBlip(v)
    end

    for k, v in pairs(purchasedHouses) do
        if v.houseid ~= OwnedHouse.houseId then
            AvailableHouses[v.houseid] = v.houseid
        end
    end

    for k, v in pairs(Config.Houses) do
        if OwnedHouse.houseId == k then
            CreateBlip(v['door'], 40, 3, 0.75, 'Evim')
        end
    end
end)


EnterHouse = function(prop, coords)
    local obj = CreateObject(prop, coords, false)
    FreezeEntityPosition(obj, true)
    return obj
end


RegisterNetEvent("loaf_housing:eve-isinlan")
AddEventHandler("loaf_housing:eve-isinlan", function(id, pin)
    local playerPed = PlayerPedId()
    local evId = id
    local coords = vector3(Config.Houses[evId]["door"].x, Config.Houses[evId]["door"].y, Config.Houses[evId]["door"].z-80)
    local disKapi = vector3(coords.x+3.69, coords.y-15.65, coords.z+1.7)
    local depo = vector3(coords.x+9.17, coords.y-1.34, coords.z+1.7)
    local in_house = true
    if Config.Houses[tonumber(evId)]['houseJob'] ~= PlayerData.job.name then
        ESX.TriggerServerCallback('sp-housing:getPin', function(housepin)
            if tonumber(pin) ~= housepin then
                in_house = false
                exports['mythic_notify']:DoShortHudText('error', 'Girilen şifre hatalı!')
                return
            else
                TriggerEvent('kagan:onstash', true)
                evYarat({x = coords.x, y = coords.y, z = coords.z})
                DoScreenFadeOut(750)
                while not IsScreenFadedOut() do Wait(0) end
                SetEntityCoords(playerPed, disKapi)
                TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'DoorOpen', 0.5)
                for i = 1, 25 do
                    SetEntityCoords(playerPed,  disKapi)
                    Wait(50)
                end
                while IsEntityWaitingForWorldCollision(playerPed) do
                    SetEntityCoords(playerPed, disKapi)
                    Wait(50)
                end
                DoScreenFadeIn(1500)
                while in_house do
                    local kordinat = GetEntityCoords(playerPed)
                    DrawMarker(2, disKapi, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 100, false, true, 2, false, false, false, false)
                    DrawMarker(2, depo, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 100, false, true, 2, false, false, false, false)
                    if #(kordinat - depo) <= 2.0 then
                        TgiannDrawText3D(depo.x, depo.y, depo.z+0.5, "[E] Depo & Dolap")
                        if IsControlJustReleased(0, 38) then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'StashOpen', 0.5)
                            if Config.Inv == "np" then
                                TriggerEvent("server-inventory-open", "1", "Depo Ev - "..tostring(evId))
                            elseif Config.Inv == "disc" then
                                TriggerEvent('m3:inventoryhud:client:openStash', 'Stash', 'all')
                            end
                        end
                    end
                    if #(kordinat - disKapi) <= 1.5 then
                        TgiannDrawText3D(disKapi.x, disKapi.y, disKapi.z+0.5, "[E] Evi Yönet")
                        if IsControlJustReleased(0, 38) then
                            ESX.UI.Menu.CloseAll()
                            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'houseBuyFirstMenu',
                            {
                                title    = 'Evi Yönet',
                                align    = 'left',
                                elements = {
                                    {label = "Evden Çık", value = "evdencik"},
                                    {label = "Şifre Değiştir", value = "evsifre"}
                                }
                            },function(data, menu)
                                if data.current.value == "evdencik" then
                                    ESX.UI.Menu.CloseAll()
                                    TriggerEvent('loaf_housing:leaveHouse', evId)
                                    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'DoorOpen', 0.5)
                                    TriggerEvent('kagan:onstash', false)
                                    Citizen.Wait(1500)
                                    in_house = false
                                elseif data.current.value == 'evsifre' then
                                    ESX.UI.Menu.CloseAll()
                                    for k, v in pairs(Config.Houses) do
                                        if OwnedHouse.houseId == k then
                                            ChangePassword(k)
                                        end
                                    end
                                end
                            end,function(data, menu)
                                menu.close()
                            end)
                        end
                    end
                    Citizen.Wait(1)
                end
                DeleteSpawnedHouse(evId)
            end
        end, evId)
    else
         TriggerEvent('kagan:onstash', true)
         evYarat({x = coords.x, y = coords.y, z = coords.z})

         DoScreenFadeOut(750)
    
         while not IsScreenFadedOut() do Wait(0) end
    
         SetEntityCoords(playerPed, disKapi)
         TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'DoorOpen', 0.5)

         for i = 1, 25 do
             SetEntityCoords(playerPed,  disKapi)
             Wait(50)
         end
    
         while IsEntityWaitingForWorldCollision(playerPed) do
             SetEntityCoords(playerPed, disKapi)
             Wait(50)
         end
         DoScreenFadeIn(1500)
    
    
         while in_house do
             local kordinat = GetEntityCoords(playerPed)
             DrawMarker(2, disKapi, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 100, false, true, 2, false, false, false, false)
             DrawMarker(2, depo, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 100, false, true, 2, false, false, false, false)
             if #(kordinat - depo) <= 2.0 then
                 TgiannDrawText3D(depo.x, depo.y, depo.z+0.5, "[E] Depo & Dolap")
                 if IsControlJustReleased(0, 38) then
                     TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'StashOpen', 0.5)
                     TriggerEvent("server-inventory-open", "1", "Ev"..tostring(evId))
                 end
             end
             if #(kordinat - disKapi) <= 1.5 then
                 TgiannDrawText3D(disKapi.x, disKapi.y, disKapi.z+0.5, "[E] Evi Yönet")
                 if IsControlJustReleased(0, 38) then
                     ESX.UI.Menu.CloseAll()
                     ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'houseBuyFirstMenu',
                     {
                         title    = 'Evi Yönet',
                         align    = 'left',
                         elements = {
                             {label = "Evden Çık", value = "evdencik"},
                             {label = "Şifre Değiştir", value = "evsifre"}
                         }
                     },function(data, menu)
                         if data.current.value == "evdencik" then
                             ESX.UI.Menu.CloseAll()
                             TriggerEvent('loaf_housing:leaveHouse', evId)
                             TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'DoorOpen', 0.5)
                             TriggerEvent('kagan:onstash', false)
                             Citizen.Wait(1500)
                             in_house = false
                         elseif data.current.value == 'evsifre' then
                             ESX.UI.Menu.CloseAll()
                             for k, v in pairs(Config.Houses) do
                                 if OwnedHouse.houseId == k then
                                     ChangePassword(k)
                                 end
                             end
                         end
                     end,function(data, menu)
                         menu.close()
                     end)
                 end
             end
             Citizen.Wait(1)
         end
         DeleteSpawnedHouse(evId)
    end
end)

function TgiannDrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 250
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 140)
end

function evYarat(generator)
    local building = CreateObject(`shell_v16mid`, generator.x+2.25, generator.y-1.32, generator.z+1.18, false, false, false)
    FreezeEntityPosition(building, true)
end

function DeleteSpawnedHouse(evId)
    local housePosition = Config.Houses[evId]["door"]
    local handle, ObjectFound = FindFirstObject()
    local success
    repeat
    local pos = GetEntityCoords(ObjectFound)
    local distance = GetDistanceBetweenCoords(housePosition.x, housePosition.y, (housePosition.z - 15.0), pos, true)
    if distance < 35.0 and ObjectFound ~= PlayerPedId() then
        if IsEntityAPed(ObjectFound) then
            if not IsPedAPlayer(ObjectFound) then
                DeleteObject(ObjectFound)
            end
        else
            DeleteObject(ObjectFound)
        end
    end
    success, ObjectFound = FindNextObject(handle)
    until not success
    EndFindObject(handle)
end


function getRotation(input)
    return 360/(10*input)
end

CreateBlip = function(coords, sprite, colour, scale, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, scale)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    table.insert(blips, blip)
end


