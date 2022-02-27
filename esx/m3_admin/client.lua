local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)

        Citizen.Wait(0)
    end
end)
local players = {}
local playerPermissions = {}
local banned = {}
local isAdmin = false

local vehicleTypes = { 'Araba', 'Helikopter', 'Tekne' }
local vehicleTypes2 = { 'car', 'helicopter', 'boat' }
local currentItemIndex = 1
local selectedItemIndex = 1

local banTimes = { '1 saat', '2 saat', '3 saat', '4 saat', '5 saat', '10 saat', '1 gün', '2 gün', '3 gün', '1 hafta', '2 hafta', '1 ay', 'perma' }
local banTimesTimestamp = { 3600, 7200, 10800, 14400, 18000, 36000, 86400, 172800, 259200, 604800, 1209600, 2629800, 10444633200 }
local currentItemIndex2 = 1
local selectedItemIndex2 = 1

local moneyTypes = { 'Nakit', 'Banka', 'Karapara' }
local currentItemIndex3 = 1
local selectedItemIndex3 = 1

local availableWeatherTypes = { 'EXTRASUNNY', 'CLEAR', 'NEUTRAL', 'SMOG', 'FOGGY', 'OVERCAST', 'CLOUDS', 'CLEARING', 'RAIN', 'THUNDER', 'SNOW', 'SNOWLIGHT', 'XMAS' }
local currentItemIndex4 = 1
local selectedItemIndex4 = 1

local noclip = false
local invisibility = false
local spectate = false
local spectateOldCoord = nil
local freeze = false
local timefreeze = false
local showcoords = false

local currentPlayer = nil
Citizen.CreateThread(function()
    local openKey = tonumber(GetConvar('m3_admin_menuButton', 10))
	WarMenu.CreateMenu('menu', '') ---Menu name
	WarMenu.CreateSubMenu('players', 'menu', 'OYUNCULAR')
    WarMenu.CreateSubMenu('selfoption', 'menu', 'KISISEL SECENEKLER')
    WarMenu.CreateSubMenu('serveroption', 'menu', 'SUNUCU SECENEKLERI')
    WarMenu.CreateSubMenu('timeweather', 'serveroption', 'Zaman & Hava Durumu')
    WarMenu.CreateSubMenu('banneds', 'menu', 'YASAKLAMALAR')
    WarMenu.CreateSubMenu('player', 'players','OYUNCU')
    WarMenu.CreateSubMenu('bannedplayer', 'banneds','YASAKLI OYUNCU')

    ---This is the menu structure		
    while true do
        -- if #playerPermissions > 0 then
            if WarMenu.IsMenuOpened('menu') then -- If warmenu open then display the following sub menus.
                if WarMenu.MenuButton('Oyuncular', 'players') then
                elseif WarMenu.MenuButton('Kişisel Seçenekler', 'selfoption') then
                elseif WarMenu.MenuButton('Sunucu Seçenekleri', 'serveroption') then
                elseif havePermission('unban') and WarMenu.MenuButton('Yasaklamalar', 'banneds') then
                end
                WarMenu.Display()

            elseif WarMenu.IsMenuOpened('players') then
                for i=1, #players, 1 do
                    if WarMenu.MenuButton('#'..players[i].id..' | '..players[i].name, 'player') then
                        currentPlayer = players[i].id
                        WarMenu.SetSubTitle('player', '#'..players[i].id..' | '..players[i].name)
                    end
                end
                WarMenu.Display()

            elseif WarMenu.IsMenuOpened('player') then
                if havePermission('spectate') and WarMenu.CheckBox('İzle', spectate) then
                    if currentPlayer ~= GetPlayerServerId(PlayerId()) then
                        spectate = not spectate
                        if spectate then
                            spectateOldCoord = GetEntityCoords(PlayerPedId())
                            FreezeEntityPosition(PlayerPedId(), 1)
                            ESX.TriggerServerCallback('m3:admin:server:getTargetCoord', function(coord)
                                if coord ~= nil then
                                    DoScreenFadeOut(200)
                                    Citizen.Wait(350)
                                    SetEntityCoords(PlayerPedId(), coord.x, coord.y, coord.z - 50, 0, 0, 0, 0)
                                    Citizen.Wait(600)
                                    DoScreenFadeIn(200)
                                    NetworkSetInSpectatorMode(1, GetPlayerPed(GetPlayerFromServerId(currentPlayer)))
                                    TriggerEvent('updateVoipTargetPed', GetPlayerPed(GetPlayerFromServerId(currentPlayer)), false)
                                end
                            end, currentPlayer)
                        else
                            DoScreenFadeOut(200)
                            Citizen.Wait(350)
                            RequestCollisionAtCoord(spectateOldCoord.x, spectateOldCoord.y, spectateOldCoord.z)
                            NetworkSetInSpectatorMode(0, PlayerPedId())
                            TriggerEvent('updateVoipTargetPed', PlayerPedId(), true)
                            SetEntityCoords(PlayerPedId(), spectateOldCoord.x, spectateOldCoord.y, spectateOldCoord.z - 1.8, 0, 0, 0, 0)
                            FreezeEntityPosition(PlayerPedId(), 0)
                            DoScreenFadeIn(200)
                        end
                    else
                        notify('error', 'Kendini izleyemezsin!')
                    end
                elseif havePermission('revive') and WarMenu.Button('İyileştir(revive)') then
                    TriggerServerEvent('m3:admin:server:revive', currentPlayer)
                elseif havePermission('heal') and WarMenu.Button('İyileştir(heal)') then
                    TriggerServerEvent('m3:admin:server:heal', currentPlayer)
                elseif havePermission('openinv') and WarMenu.Button('Envanterini Aç') then
                    TriggerServerEvent('m3:admin:server:openInv', currentPlayer)
                elseif havePermission('openinv') and WarMenu.Button('Envanterini Temizle') then
                    TriggerServerEvent('m3:admin:server:clearInv', currentPlayer)
                elseif havePermission('setgps') and WarMenu.Button('GPS\'te İşaretle') then
                    TriggerServerEvent('m3:admin:server:setGps', currentPlayer)
                elseif havePermission('goto') and WarMenu.Button('Yanına Git') then
                    if havePermission('noclip') then
                        if not noclip then
                            noclip = true
                            TriggerServerEvent('m3:admin:server:toggleNoclip')
                        end
                    end
                    TriggerServerEvent('m3:admin:server:goto', currentPlayer)
                elseif havePermission('bring') and WarMenu.Button('Yanına Getir') then
                    TriggerServerEvent('m3:admin:server:bring', currentPlayer)
                elseif havePermission('freeze') and WarMenu.CheckBox('Dondur', freeze) then
                    freeze = not freeze
                    if freeze then
                        TriggerServerEvent('m3:admin:server:toggleFreeze', currentPlayer, true)
                    else
                        TriggerServerEvent('m3:admin:server:toggleFreeze', currentPlayer, false)
                    end
                elseif havePermission('kill') and WarMenu.Button('Öldür') then
                    TriggerServerEvent('m3:admin:server:kill', currentPlayer)
                elseif havePermission('privatemessage') and WarMenu.Button('Özel Mesaj Gönder') then
                    local message = keyboardInput('Mesaj:', '', 255)

                    if message == '' or message == nil then
                        notify('error', 'Mesaj boş olamaz!')
                    else
                        TriggerServerEvent('m3:admin:server:privateMessage', currentPlayer, message)
                    end
                elseif havePermission('kick') and WarMenu.Button('Sunucudan At') then
                    local reason = keyboardInput('Sebep:', '', 255)
                    
                    if reason == '' or reason == nil then
                        TriggerServerEvent('m3:admin:server:kick', currentPlayer, '')
                    else
                        TriggerServerEvent('m3:admin:server:kick', currentPlayer, reason)
                    end
                elseif havePermission('ban') and WarMenu.ComboBox('Sunucudan Yasakla', banTimes, currentItemIndex2, selectedItemIndex2, function(currentIndex, selectedIndex)
                    currentItemIndex2 = currentIndex
                    selectedItemIndex2 = selectedIndex
                end) then
                local reason2 = keyboardInput('Sebep:', '', 255)
            
                TriggerServerEvent('m3:admin:server:ban', currentPlayer, reason2, banTimesTimestamp[selectedItemIndex2])
                elseif havePermission('giveitem') and WarMenu.Button('Eşya Ver') then
                    local itemName = keyboardInput('İtem İsmi:', '', 20)
                
                    if itemName == '' or itemName == nil then
                        notify('error', 'İtem ismi boş olamaz!')
                    else
                        if not string.match(itemName, 'WEAPON_') then
                            local itemCount = keyboardInput('İtem Sayısı:', '', 10)
                    
                            if itemCount == '' or itemCount == nil then
                                TriggerServerEvent('m3:admin:server:giveItem', currentPlayer, itemName, 1)
                            else
                                TriggerServerEvent('m3:admin:server:giveItem', currentPlayer, itemName, itemCount)
                            end
                        else
                            notify('error', 'Bu şekilde silah veremezsin!')
                        end
                    end
                elseif havePermission('givevehicle') and WarMenu.ComboBox('Araç Ver(database)', vehicleTypes, currentItemIndex, selectedItemIndex, function(currentIndex, selectedIndex)
					    currentItemIndex = currentIndex
                        selectedItemIndex = selectedIndex
                    end) then
                    local model = keyboardInput('Araç Modeli:', '', 50)
                
                    if model == '' or model == nil then
                        notify('error', 'Model boş olamaz!')
                    else
                        TriggerServerEvent('m3:admin:server:giveVehicle', currentPlayer, vehicleTypes2[selectedItemIndex], model)
                    end
                elseif havePermission('givemoney') and WarMenu.ComboBox('Para Ver', moneyTypes, currentItemIndex3, selectedItemIndex3, function(currentIndex, selectedIndex)
                    currentItemIndex3 = currentIndex
                    selectedItemIndex3 = selectedIndex
                end) then
                local amount = keyboardInput('Miktar:', '', 10)
            
                if amount == '' or amount == nil then
                    notify('error', 'Miktar boş olamaz!')
                else
                    TriggerServerEvent('m3:admin:server:giveMoney', currentPlayer, moneyTypes[selectedItemIndex3], tonumber(amount))
                end
                elseif havePermission('giveweapon') and WarMenu.Button('Silah Ver') then
                    local weaponName = keyboardInput('Silahın İtem İsmi:', '', 20)
                
                    if weaponName == '' or weaponName == nil then
                        notify('error', 'İtem ismi boş olamaz!')
                    else
                        if string.match(weaponName, 'WEAPON_') then
                            local weaponCount = keyboardInput('İtem Sayısı:', '', 10)
                    
                            if weaponCount == '' or weaponCount == nil then
                                TriggerServerEvent('m3:admin:server:giveWeapon', currentPlayer, string.upper(weaponName), 1)
                            else
                                TriggerServerEvent('m3:admin:server:giveWeapon', currentPlayer, string.upper(weaponName), weaponCount)
                            end
                        else
                            notify('error', 'Bu şekilde silah dışında item veremezsin!')
                        end
                    end
                elseif havePermission('skin') and WarMenu.Button('Skin Menüsünü Açtırt') then
                    if GetPlayerServerId(PlayerId()) ~= currentPlayer then
                        TriggerServerEvent('m3:admin:server:skin', currentPlayer)
                    else
                        notify('error', 'Kendinde skin menüsünü açamazsın!')
                    end
                elseif havePermission('screenshot') and WarMenu.Button('Ekran Görüntüsü Al') then
                    TriggerServerEvent('m3:admin:server:screenshot', currentPlayer)
                elseif havePermission('wipeplayer') and WarMenu.Button('~r~Karakterini Sil(wipe)') then
                    TriggerServerEvent('m3:admin:server:wipePlayer', currentPlayer, nil)
                end
                WarMenu.Display()
            
            elseif WarMenu.IsMenuOpened('selfoption') then
                if havePermission('tp') and WarMenu.Button('İşaretli Konuma Işınlan') then
                    TriggerServerEvent('m3:admin:server:selfLog', 'tpm')
                    local WaypointHandle = GetFirstBlipInfoId(8)

                    if DoesBlipExist(WaypointHandle) then
                        local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

                        for height = 1, 1000 do
                            SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

                            if foundGround then
                                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                                local coord = GetEntityCoords(PlayerPedId())
                                RequestCollisionAtCoord(coord.x, coord.y, coord.z)

                                break
                            end

                            Citizen.Wait(5)
                        end
                    else
                        notify('error', 'Herhangi bir yeri işaretlemediniz!')
                    end
                elseif havePermission('revive') and WarMenu.Button('İyileştir(revive)') then
                    TriggerServerEvent('m3:admin:server:selfRevive')
                elseif havePermission('heal') and WarMenu.Button('İyileştir(heal)') then
                    TriggerServerEvent('m3:admin:server:selfHeal')
                elseif havePermission('kill') and WarMenu.Button('Öldür') then
                    TriggerServerEvent('m3:admin:server:selfKill')
                elseif havePermission('noclip') and WarMenu.CheckBox('Noclip', noclip) then
                    noclip = not noclip
                    TriggerServerEvent('m3:admin:server:toggleNoclip')
                elseif havePermission('invisibility') and WarMenu.CheckBox('Görünmezlik', invisibility) then
                    invisibility = not invisibility
                    SetEntityVisible(PlayerPedId(), not invisibility, 0)
                    NetworkSetEntityInvisibleToNetwork(PlayerPedId(), invisibility)
                    SetForcePedFootstepsTracks(false)
                elseif havePermission('freeze') and WarMenu.CheckBox('Dondur', freeze) then
                    freeze = not freeze
                    if freeze then
                        TriggerServerEvent('m3:admin:server:toggleSelfFreeze', true)
                    else
                        TriggerServerEvent('m3:admin:server:toggleSelfFreeze', false)
                    end
                elseif WarMenu.CheckBox('Koordinat Göster', showcoords) then
                    showcoords = not showcoords
                elseif WarMenu.Button('Koordinat Kopyala') then
                    local coords = GetEntityCoords(PlayerPedId())
                    SendNUIMessage({coords = string.sub(coords.x, 0, 7)..', '..string.sub(coords.y, 0, 7)..', '..string.sub(coords.z, 0, 7)})
                    notify('inform', 'Koordinatlar kopyalandı.')
                end
                WarMenu.Display()

            elseif WarMenu.IsMenuOpened('serveroption') then
                if havePermission('timeweather') and WarMenu.MenuButton('Zaman & Hava Durumu', 'timeweather') then
                elseif havePermission('announce') and WarMenu.Button('Anons Yap') then
                    local message = keyboardInput('Mesaj:', '', 255)

                    if message == '' or message == nil then
                        notify('error', 'Mesaj boş olamaz!')
                    else
                        TriggerServerEvent('m3:admin:server:announce', message)
                    end
                elseif havePermission('cleararea') and WarMenu.Button('Bölgeyi Temizle') then
                    local coord = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('m3:admin:server:clearArea', coord)
                elseif havePermission('allkick') and WarMenu.Button('Herkesi Sunucudan At') then
                    TriggerServerEvent('m3:admin:server:allKick')
                elseif havePermission('bringall') and WarMenu.Button('Herkesi Yanına Getir') then
                    local coord = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('m3:admin:server:allBring', coord)
                elseif havePermission('reviveall') and WarMenu.Button('Herkesi İyileştir(revive)') then
                    TriggerServerEvent('m3:admin:server:reviveAll')
                elseif havePermission('wipeplayer') and WarMenu.Button('~r~Karakter Sil(offlinewipe)') then
                    local steamhex = keyboardInput('Steam(HEX): Örnek: steam:1100041123251e7', '', 21)

                    if steamhex == '' or steamhex == nil then
                        notify('error', 'Steam kimliği boş olamaz!')
                    else
                        if string.match(steamhex, 'steam:') then
                            TriggerServerEvent('m3:admin:server:wipePlayer', nil, steamhex)
                        else
                            notify('error', 'Steam kimliğini hatalı yazdınız! Örnek: steam:1100041123251e7')
                        end
                    end
                end
                WarMenu.Display()

            elseif WarMenu.IsMenuOpened('timeweather') then
                if havePermission('timeweather') and WarMenu.Button('Saati Değiştir') then
                    local hour = keyboardInput('Saat(hh):', '', 2)
                
                    if hour == '' or hour == nil then
                        notify('error', 'Saat boş olamaz!')
                    else
                        local minute = keyboardInput('Dakika(mm):', '', 2)
                    
                        if minute == '' or minute == nil then
                            TriggerServerEvent('m3:admin:server:changeTime', tonumber(hour), 00)
                        else
                            TriggerServerEvent('m3:admin:server:changeTime', tonumber(hour), tonumber(minute))
                        end
                    end
                elseif havePermission('timeweather') and WarMenu.CheckBox('Saati Durdur', timefreeze) then
                    timefreeze = not timefreeze
                    if timefreeze then
                        TriggerServerEvent('m3:admin:server:freezeTime')
                    else
                        TriggerServerEvent('m3:admin:server:unfreezeTime')
                    end
                elseif havePermission('timeweather') and WarMenu.ComboBox('Havayı Değiştir', availableWeatherTypes, currentItemIndex4, selectedItemIndex4, function(currentIndex, selectedIndex)
                    currentItemIndex4 = currentIndex
                    selectedItemIndex4 = selectedIndex
                end) then
                    TriggerServerEvent('m3:admin:server:changeWeather', availableWeatherTypes[selectedItemIndex4])
                elseif havePermission('timeweather') and WarMenu.Button('Senkronizasyon') then
                    TriggerServerEvent('m3:admin:server:requestAllSync')
                end
                WarMenu.Display()

            elseif WarMenu.IsMenuOpened('banneds') then
                if havePermission('banneds') and WarMenu.Button('Yasak Listesini Yenile') then
                    ESX.TriggerServerCallback('m3:admin:server:refreshBanlist', function(banlist)
                        if banlist ~= nil and #banlist > 0 then
                            banned = {}
                            banned = banlist
                            WarMenu.OpenMenu('banneds')
                        else
                            notify('error', 'Yasaklanmış kimse bulunamadı!')
                        end
                    end)
                end
                for i=1, #banned, 1 do
                    if WarMenu.MenuButton(banned[i].name, 'bannedplayer') then
                        bannedPlayer = i
                        WarMenu.SetSubTitle('bannedplayer', banned[i].name)
                    end
                end
                WarMenu.Display()
            
            elseif WarMenu.IsMenuOpened('bannedplayer') then
                if havePermission('banneds') and WarMenu.Button('Yasaklayan: '..banned[bannedPlayer].admin) then
                elseif havePermission('banneds') and WarMenu.Button(banned[bannedPlayer].steam) then
                elseif havePermission('banneds') and WarMenu.Button(banned[bannedPlayer].rockstar) then
                elseif havePermission('banneds') and banned[bannedPlayer].discord ~= nil and WarMenu.Button(banned[bannedPlayer].discord) then
                elseif havePermission('banneds') and banned[bannedPlayer].xbox ~= nil and WarMenu.Button(banned[bannedPlayer].xbox) then
                elseif havePermission('banneds') and banned[bannedPlayer].live ~= nil and WarMenu.Button(banned[bannedPlayer].live) then
                elseif havePermission('banneds') and banned[bannedPlayer].ip ~= nil and WarMenu.Button(banned[bannedPlayer].ip) then
                elseif havePermission('banneds') and banned[bannedPlayer].reason ~= nil and WarMenu.Button('Sebep: '..banned[bannedPlayer].reason) then
                elseif havePermission('banneds') and banned[bannedPlayer].time ~= nil and WarMenu.Button('Yasaklama Bitişi: '..banned[bannedPlayer].time) then
                elseif havePermission('banneds') and banned[bannedPlayer].id ~= nil and WarMenu.Button('~r~Yasaklamayı Kaldır') then
                    WarMenu.OpenMenu('menu')
                    TriggerServerEvent('m3:admin:server:unban', banned[bannedPlayer].id)
                end
                WarMenu.Display()

            elseif IsControlJustReleased(0, openKey) then
                if isAdmin then
                    refreshPlayers()
                    freeze = false
                    bannedPlayer = nil
                    currentPlayer = nil
                    WarMenu.OpenMenu('menu')
                end
            end
        -- end
		Citizen.Wait(0)
    end
end)

function refreshPlayers()
    ESX.TriggerServerCallback('m3:admin:server:getPlayers', function(playerstable)
        if playerstable ~= nil or #playerstable > 0 then
            players = {}
            table.sort(playerstable, function(a, b) return a.id < b.id end)
            players = playerstable
        end
    end)
end

function notify(type, text, time)
    if length == nil then length = 5000 end 
    TriggerEvent('mythic_notify:client:SendAlert', { type = type, text = text, length = length})
end

function havePermission(permName)
    if playerPermissions['fullperm'] then
        return true
    end

    if playerPermissions[permName] then
        return true
    end

    return false
end

--spectate
Citizen.CreateThread(function()
    while true do
        local sleepthread = 500
        if spectate then
            ESX.TriggerServerCallback('m3:admin:server:getTargetCoord', function(coord)
                if coord ~= nil then
                    SetEntityCoords(PlayerPedId(), coord.x, coord.y, coord.z - 50, 0, 0, 0, 0)
                    RequestCollisionAtCoord(coord.x, coord.y, coord.z)
                end
            end, currentPlayer)
            sleepthread = 5000
        else
            sleepthread = 500
        end
        Citizen.Wait(sleepthread)
    end
end)

--noclip
Citizen.CreateThread(function()
    while true do
        if IsControlJustReleased(1, 11) then
            if havePermission('noclip') then
                noclip = not noclip
                TriggerServerEvent('m3:admin:server:toggleNoclip')
            end
        end
        Citizen.Wait(10)
    end
end)

--showcoord
function DrawCoordText(text)
	SetTextColour(186, 186, 186, 255)
	SetTextFont(7)
	SetTextScale(0.388, 0.388)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.39, 0.028)
end

Citizen.CreateThread(function()
    while true do
		local sleepThread = 1000
		
		if showcoords then
			sleepThread = 5

			local playerPed = PlayerPedId()
			local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
			local playerH = GetEntityHeading(playerPed)

			DrawCoordText(("~g~X~u~: %s ~g~Y:~u~ %s ~g~Z:~u~ %s ~g~H:~u~ %s"):format(FormatCoord(playerX), FormatCoord(playerY), FormatCoord(playerZ), FormatCoord(playerH)))
		end

		Citizen.Wait(sleepThread)
	end
end)

FormatCoord = function(coord)
	if coord == nil then
		return "unknown"
	end

	return tonumber(string.format("%.2f", coord))
end

function keyboardInput(arg1, arg2, arg3) 
    AddTextEntry('FMMC_KEY_TIP1', arg1) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", arg2, "", "", "", arg3)

    while (UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2) do
        TriggerEvent('m3:inventoryhud:client:invUseable', false)
        Citizen.Wait(0) 
    end

    if UpdateOnscreenKeyboard() ~= 2 then 
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        TriggerEvent('m3:inventoryhud:client:invUseable', true)
        return result 
    else 
        Citizen.Wait(500)
        TriggerEvent('m3:inventoryhud:client:invUseable', true)
        return nil 
    end 
end

local firstSpawn = true
AddEventHandler('playerSpawned', function()
    TriggerServerEvent('m3:admin:server:requestSync')
    if firstSpawn then
        TriggerServerEvent('m3:admin:server:playerSpawned')
        firstSpawn = false
    end
end)

RegisterNetEvent('m3:admin:client:refreshBanlist')
AddEventHandler('m3:admin:client:refreshBanlist', function(bantable)
    banned = {}
    banned = bantable
end)

RegisterNetEvent('m3:admin:client:loadPermissions')
AddEventHandler('m3:admin:client:loadPermissions', function(table)
    if table ~= nil or #table > 0 then
        for k, v in pairs(table) do
            for t, z in pairs(v) do
                playerPermissions[t] = z
                if z then
                    isAdmin = true
                end
            end
        end
    end
end)

RegisterNetEvent('m3:admin:client:captureScreenshot')
AddEventHandler('m3:admin:client:captureScreenshot', function(adminName, adminSrc)
    exports['screenshot-basic']:requestScreenshotUpload(GetConvar("m3_admin_screenshoturl", 'http://fivem.launchwares.com/upload.php'), GetConvar("m3_admin_screenshotfield", 'files[]'), function(data)
        local resp = json.decode(data)
		TriggerServerEvent('m3:admin:server:sendScreenshot', resp.files[1].url, adminName, adminSrc)
	end)
end)

RegisterNetEvent('m3:admin:client:setCoord')
AddEventHandler('m3:admin:client:setCoord', function(coord)
    SetEntityCoords(PlayerPedId(), coord.x, coord.y, coord.z, 0, 0, 0, 0)
end)

RegisterNetEvent('m3:admin:client:kill')
AddEventHandler('m3:admin:client:kill', function()
    ApplyDamageToPed(PlayerPedId(), 200, 0)
end)

RegisterNetEvent('m3:admin:client:setGps')
AddEventHandler('m3:admin:client:setGps', function(coord)
    SetNewWaypoint(coord.x, coord.y)
end)

RegisterNetEvent('m3:admin:client:clearArea')
AddEventHandler('m3:admin:client:clearArea', function(coord)
    ClearAreaOfEverything(coord.x, coord.y, coord.z, 100.0, 0, 0, 0, 0)
end)

--givevehicle
RegisterNetEvent('m3:admin:client:spawnVehicle')
AddEventHandler('m3:admin:client:spawnVehicle', function(vehiclemodel, type)
	local playerPed = PlayerPedId()
	local pCoords = GetEntityCoords(playerPed)
	ESX.Game.SpawnVehicle(vehiclemodel, pCoords, 1, function (vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

		local newPlate     = GeneratePlate()
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		vehicleProps.plate = newPlate
		SetVehicleNumberPlateText(vehicle, newPlate)

		TriggerServerEvent('m3:admin:server:saveVehicle', vehicleProps, type)
		TriggerServerEvent('m3:vehiclelock:plateRegister', newPlate)
	end)
end)


local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		generatedPlate = string.upper(GetRandomLetter(3) .. ' ' .. GetRandomNumber(3))

		ESX.TriggerServerCallback('esx_vehicleshop:isPlateTaken', function (isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end

-- mixing async with sync tasks
function IsPlateTaken(plate)
	local callback = 'waiting'

	ESX.TriggerServerCallback('esx_vehicleshop:isPlateTaken', function(isPlateTaken)
		callback = isPlateTaken
	end, plate)

	while type(callback) == 'string' do
		Citizen.Wait(0)
	end

	return callback
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end
--

-- weather&time
CurrentWeather = 'OVERCAST'
local lastWeather = CurrentWeather
local baseTime = 0
local timeOffset = 0
local timer = 0
local freezeTime = false

RegisterNetEvent('m3:admin:client:updateWeather')
AddEventHandler('m3:admin:client:updateWeather', function(NewWeather)
    CurrentWeather = NewWeather
end)

Citizen.CreateThread(function()
    while true do
        if lastWeather ~= CurrentWeather then
            lastWeather = CurrentWeather
            SetWeatherTypeOverTime(CurrentWeather, 15.0)
            Citizen.Wait(15000)
        end
        Citizen.Wait(1)
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist(lastWeather)
        SetWeatherTypeNow(lastWeather)
        SetWeatherTypeNowPersist(lastWeather)
        if lastWeather == 'XMAS' then
            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
        else
            SetForceVehicleTrails(false)
            SetForcePedFootstepsTracks(false)
        end
    end
end)

RegisterNetEvent('m3:admin:client:updateTime')
AddEventHandler('m3:admin:client:updateTime', function(base, offset, freeze)
    freezeTime = freeze
    timeOffset = offset
    baseTime = base
end)

Citizen.CreateThread(function()
    local hour = 0
    local minute = 0
    while true do
        Citizen.Wait(0)
        local newBaseTime = baseTime
        if GetGameTimer() - 500  > timer then
            newBaseTime = newBaseTime + 0.25
            timer = GetGameTimer()
        end
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime
        end
        baseTime = newBaseTime
        hour = math.floor(((baseTime+timeOffset)/60)%24)
        minute = math.floor((baseTime+timeOffset)%60)
        NetworkOverrideClockTime(hour, minute, 0)
    end
end)