ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(5)
  end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


--Fonksiyonlar--
---- Blipler ----

RegisterNetEvent('AnimSet:default');
AddEventHandler('AnimSet:default', function()
    ResetPedMovementClipset(PlayerPedId(), 0)
    AnimSet = "default";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:Hurry');
AddEventHandler('AnimSet:Hurry', function()
    RequestAnimSet("move_m@hurry@a")
    while not HasAnimSetLoaded("move_m@hurry@a") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@hurry@a", true)
    AnimSet = "move_m@hurry@a";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:Business');
AddEventHandler('AnimSet:Business', function()
    RequestAnimSet("move_m@business@a")
    while not HasAnimSetLoaded("move_m@business@a") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@business@a", true)
    AnimSet = "move_m@business@a";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:Brave');
AddEventHandler('AnimSet:Brave', function()
    RequestAnimSet("move_m@brave")
    while not HasAnimSetLoaded("move_m@brave") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@brave", true)
    AnimSet = "move_m@brave";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:Tipsy');
AddEventHandler('AnimSet:Tipsy', function()
    RequestAnimSet("move_m@drunk@slightlydrunk")
    while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
        Citizen.Wait(0)
    end
    SetPedMovementClipset(PlayerPedId(), "move_m@drunk@slightlydrunk", true)
    AnimSet = "move_m@drunk@slightlydrunk";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:Injured');
AddEventHandler('AnimSet:Injured', function()
    RequestAnimSet("move_m@injured")
    while not HasAnimSetLoaded("move_m@injured") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@injured", true)
    AnimSet = "move_m@injured";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:ToughGuy');
AddEventHandler('AnimSet:ToughGuy', function()
    RequestAnimSet("move_m@tough_guy@")
    while not HasAnimSetLoaded("move_m@tough_guy@") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@tough_guy@", true)
    AnimSet = "move_m@tough_guy@";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:Sassy');
AddEventHandler('AnimSet:Sassy', function()
    RequestAnimSet("move_m@sassy")
    while not HasAnimSetLoaded("move_m@sassy") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@sassy", true)
    AnimSet = "move_m@sassy";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:Sad');
AddEventHandler('AnimSet:Sad', function()
    RequestAnimSet("move_m@sad@a")
    while not HasAnimSetLoaded("move_m@sad@a") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@sad@a", true)
    AnimSet = "move_m@sad@a";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:Posh');
AddEventHandler('AnimSet:Posh', function()
    RequestAnimSet("move_m@posh@")
    while not HasAnimSetLoaded("move_m@posh@") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@posh@", true)
    AnimSet = "move_m@posh@";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:Alien');
AddEventHandler('AnimSet:Alien', function()
    RequestAnimSet("move_m@alien")
    while not HasAnimSetLoaded("move_m@alien") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@alien", true)
    AnimSet = "move_m@alien";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:NonChalant');
AddEventHandler('AnimSet:NonChalant', function()
    RequestAnimSet("move_m@non_chalant")
    while not HasAnimSetLoaded("move_m@non_chalant") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@non_chalant", true)
    AnimSet = "move_m@non_chalant";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:Hobo');
AddEventHandler('AnimSet:Hobo', function()
    RequestAnimSet("move_m@hobo@a")
    while not HasAnimSetLoaded("move_m@hobo@a") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@hobo@a", true)
    AnimSet = "move_m@hobo@a";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:Money');
AddEventHandler('AnimSet:Money', function()
    RequestAnimSet("move_m@money")
    while not HasAnimSetLoaded("move_m@money") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@money", true)
    AnimSet = "move_m@money";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:Swagger');
AddEventHandler('AnimSet:Swagger', function()
    RequestAnimSet("move_m@swagger")
    while not HasAnimSetLoaded("move_m@swagger") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@swagger", true)
    AnimSet = "move_m@swagger";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:Joy');
AddEventHandler('AnimSet:Joy', function()
    RequestAnimSet("move_m@joy")
    while not HasAnimSetLoaded("move_m@joy") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@joy", true)
    AnimSet = "move_m@joy";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:Moon');
AddEventHandler('AnimSet:Moon', function()

    RequestAnimSet("move_m@powerwalk")
    while not HasAnimSetLoaded("move_m@powerwalk") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@powerwalk", true)
    AnimSet = "move_m@powerwalk";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:Shady');
AddEventHandler('AnimSet:Shady', function()
    RequestAnimSet("move_m@shadyped@a")
    while not HasAnimSetLoaded("move_m@shadyped@a") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@shadyped@a", true)
    AnimSet = "move_m@shadyped@a";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:Tired');
AddEventHandler('AnimSet:Tired', function()
    RequestAnimSet("move_m@tired")
    while not HasAnimSetLoaded("move_m@tired") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_m@tired", true)
    AnimSet = "move_m@tired";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:Sexy');
AddEventHandler('AnimSet:Sexy', function()
    RequestAnimSet("move_f@sexy")
    while not HasAnimSetLoaded("move_f@sexy") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_f@sexy", true)
    AnimSet = "move_f@sexy";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:ManEater');
AddEventHandler('AnimSet:ManEater', function()
    RequestAnimSet("move_f@maneater")
    while not HasAnimSetLoaded("move_f@maneater") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_f@maneater", true)
    AnimSet = "move_f@maneater";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent('AnimSet:ChiChi');
AddEventHandler('AnimSet:ChiChi', function()
    RequestAnimSet("move_f@chichi")
    while not HasAnimSetLoaded("move_f@chichi") do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), "move_f@chichi", true)
    AnimSet = "move_f@chichi";
    TriggerServerEvent("police:setAnimData", AnimSet)
end)

RegisterNetEvent("adez:marketler")
AddEventHandler("adez:marketler",function()
    TriggerEvent("adez_blip:turn", 1)
end)

RegisterNetEvent("adez:berberler")
AddEventHandler("adez:berberler",function()
    TriggerEvent("adez_blip:turn", 2)
end)

RegisterNetEvent("adez:garajlar")
AddEventHandler("adez:garajlar",function()
    TriggerEvent("adez_blip:turn", 3)
end)

RegisterNetEvent("adez:kıyafetciler")
AddEventHandler("adez:kıyafetciler",function()
    TriggerEvent("adez_blip:turn", 4)
end)

RegisterNetEvent("adez:dovmeciler")
AddEventHandler("adez:dovmeciler",function()
    TriggerEvent("adez_blip:turn", 5)
end)

RegisterNetEvent("adez:bankalar")
AddEventHandler("adez:bankalar",function()
    TriggerEvent("adez_blip:turn", 6)
end)

RegisterNetEvent("adez:benzinlikler")
AddEventHandler("adez:benzinlikler",function()
    TriggerEvent("adez_blip:turn", 7)
end)



----------------
RegisterNetEvent("pw:kirmaBaslat")
AddEventHandler("pw:kirmaBaslat",function(targetid, playerheading, playerCoords,  playerlocation)
	TriggerEvent('chubbsprogbar:client:progress',{
		name = 'kelepce_kiriliyor',
		duration = 10000,
		label = 'Kelepçeler kırılıyor...',
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
			anim = "machinic_loop_mechandplayer",
			flags = 49,
		},
		}, function(status)
			if not status then
				TriggerServerEvent("kelepce:zorlaDone",targetid, playerheading, playerCoords,  playerlocation)
			end
	end)
end)

RegisterNetEvent('pw:handcuff');
AddEventHandler('pw:handcuff', function()
    local target, distance = ESX.Game.GetClosestPlayer()
    playerheading = GetEntityHeading(PlayerPedId())
    playerlocation = GetEntityForwardVector(PlayerPedId())
    playerCoords = GetEntityCoords(PlayerPedId())
    local target_id = GetPlayerServerId(target)
    print(distance)
    if distance <= 2.0 then
        if distance == -1 then
            exports['mythic_notify']:SendAlert('error', 'Yakında kelepçeleyebileceğin biri yok', 4000)
        else
            TriggerServerEvent('esx_policejob:requestarrest', target_id, playerheading, playerCoords, playerlocation)
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında kelepçeleyebileceğin biri yok', 4000)
    end
end)

RegisterNetEvent('pw:checkGSR');
AddEventHandler('pw:checkGSR', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        TriggerServerEvent('GSR:Status2', GetPlayerServerId(closestPlayer))
    end
end)

RegisterNetEvent('pw:uncuff');
AddEventHandler('pw:uncuff', function()
    local target, distance = ESX.Game.GetClosestPlayer()
    playerheading = GetEntityHeading(PlayerPedId())
    playerlocation = GetEntityForwardVector(PlayerPedId())
    playerCoords = GetEntityCoords(PlayerPedId())
    local target_id = GetPlayerServerId(target)
    print(distance)
    if distance <= 2.0 then
        if distance == -1 then
            exports['mythic_notify']:SendAlert('error', 'Yakında kelepçeleyebileceğin biri yok', 4000)
        else
            TriggerServerEvent('esx_policejob:requestrelease', target_id, playerheading, playerCoords, playerlocation)
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında kelepçeleyebileceğin biri yok', 4000)
    end
end)
RegisterNetEvent('pw:escort');
AddEventHandler('pw:escort', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
    end
end)
RegisterNetEvent('pw:putinvehicle');
AddEventHandler('pw:putinvehicle', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
    end
end)
RegisterNetEvent('pw:takeoutvehicle');
AddEventHandler('pw:takeoutvehicle', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
    end
end)
RegisterNetEvent('pw:putv');
AddEventHandler('pw:putv', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        TriggerServerEvent('esx_ambulancejob:putInVehicle', GetPlayerServerId(closestPlayer))
    end
end)
RegisterNetEvent('pw:outv');
AddEventHandler('pw:outv', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        TriggerServerEvent('esx_ambulancejob:OutVehicle', GetPlayerServerId(closestPlayer))
    end
end)
RegisterNetEvent('pw:pdrevive');
AddEventHandler('pw:pdrevive', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    local health = GetEntityHealth(closestPlayerPed)
    if health == 0 then
        local playerPed = PlayerPedId()
        Citizen.CreateThread(function()
        TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
        Wait(5000)
        ClearPedTasks(playerPed)
            if GetEntityHealth(closestPlayerPed) == 0 then
                TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))--('esx_policejob:revive')
            else
                exports['mythic_notify']:SendAlert('error', 'Yakında ölü biri yok', 4000)
            end
        end)
    end
end)
RegisterNetEvent('pw:getid');
AddEventHandler('pw:getid', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        OpenIdentityCardMenu(closestPlayer)
    end
end)
RegisterNetEvent('pw:menuimpound');
AddEventHandler('pw:menuimpound', function()
    local playerPed = PlayerPedId()
    local vehicle = ESX.Game.GetVehicleInDirection()
    if vehicle ~= nil then
        exports['progressBars']:startUI(10000, "Araç Çekiliyor")
        TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
        Citizen.Wait(10000)
        ClearPedTasks(playerPed)
        DeleteVehicle(vehicle)
        exports['mythic_notify']:SendAlert('success', 'Araba çekildi')
        Citizen.Wait(100)
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında araba yok')
    end
end)
RegisterNetEvent('pw:open');
AddEventHandler('pw:open', function()
    local playerPed = PlayerPedId()
    local coords  = GetEntityCoords(playerPed)
    local vehicle = ESX.Game.GetVehicleInDirection()
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
        exports['progressBars']:startUI(10000, "Araç Açılıyor")
        Citizen.Wait(10000)
        ClearPedTasksImmediately(playerPed)

        SetVehicleDoorsLocked(vehicle, 1)
        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
        PlayVehicleDoorOpenSound(vehicle, 0)
        SetVehicleLights(vehicle, 2)
        Citizen.Wait(150)
        SetVehicleLights(vehicle, 0)
        exports['mythic_notify']:SendAlert('inform', 'Aracın kilidini açtın', 4000)
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında araba yok', 4000)
    end
end)

RegisterNetEvent("ygx:togglegas")
AddEventHandler("ygx:togglegas", function()
    DeleteWaypoint()

    local currentGasBlip = 0

	local coords = GetEntityCoords(PlayerPedId())
	local closest = 3000
	local closestCoords

	for k,v in pairs(GasStations) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
            closestCoords = v
        end
    end

    SetNewWaypoint(closestCoords)
    exports.pNotify:SendNotification({text = "En yakın benzin istasyonu GPS'inize işaretlendi.", type = "info", timeout = math.random(1000, 3000)})

end)

RegisterNetEvent("ygx:togglebarber")
AddEventHandler("ygx:togglebarber", function()
    DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 10000
	local closestCoords1

	for k,v in pairs(BarberShops) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords1 = v
		end
    end
    
    SetNewWaypoint(closestCoords1)
    exports.pNotify:SendNotification({text = "En yakın berber GPS'inize işaretlendi.", type = "info", timeout = math.random(1000, 3000)})
end)

RegisterNetEvent("ygx:toggletattos")
AddEventHandler("ygx:toggletattos", function()
    DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 10000
	local closestCoords2

	for k,v in pairs(TattoShops) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
    exports.pNotify:SendNotification({text = "En yakın dövmeci GPS'inize işaretlendi.", type = "info", timeout = math.random(1000, 3000)})
end)

RegisterNetEvent("fk:karakol")
AddEventHandler("fk:karakol", function()
    DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 200000
	local closestCoords2

	for k,v in pairs(Karakol) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
    exports.pNotify:SendNotification({text = "Market GPS'inize işaretlendi.", type = "info", timeout = math.random(1000, 3000)})
end)

RegisterNetEvent("fk:hastane")
AddEventHandler("fk:hastane", function()
    DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 200000
	local closestCoords2

	for k,v in pairs(Hastane) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
    exports.pNotify:SendNotification({text = "Hastane GPS'inize işaretlendi.", type = "info", timeout = math.random(1000, 3000)})
end)

RegisterNetEvent("fk:galeri")
AddEventHandler("fk:galeri", function()
    DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 200000
	local closestCoords2

	for k,v in pairs(Galeri) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
    exports.pNotify:SendNotification({text = "En Yakın Garaj GPS'inize işaretlendi.", type = "info", timeout = math.random(1000, 3000)})
end)

RegisterNetEvent("fk:motel")
AddEventHandler("fk:motel", function()
    DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 200000
	local closestCoords2

	for k,v in pairs(Motel) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
    exports.pNotify:SendNotification({text = "En Yakın Kıyafetci GPS'inize işaretlendi.", type = "info", timeout = math.random(1000, 3000)})
end)
RegisterNetEvent("fk:deleteblip")
AddEventHandler("fk:deleteblip", function()
    DeleteWaypoint()

    exports.pNotify:SendNotification({text = "İşaretiniz kaldırıldı.", type = "info", timeout = math.random(1000, 3000)})
end)

RegisterNetEvent("ygx:togglegarage")
AddEventHandler("ygx:togglegarage", function()
    DeleteWaypoint()
	local currentGasBlip = 0
	local coords = GetEntityCoords(PlayerPedId())
	local closest = 3000
	local closestCoords2

	for k,v in pairs(Garage) do
		local dstcheck = GetDistanceBetweenCoords(coords, v)

		if dstcheck < closest then
			closest = dstcheck
			closestCoords2 = v
		end
    end
    
    SetNewWaypoint(closestCoords2)
    exports.pNotify:SendNotification({text = "En yakın garaj GPS'inize işaretlendi.", type = "info", timeout = math.random(1000, 3000)})
end)

TattoShops = {
	vector3(1322.6, -1651.9, 51.2),
	vector3(-1153.6, -1425.6, 4.9),
	vector3(322.1, 180.4, 103.5),
	vector3(-3170.0, 1075.0, 20.8),
	vector3(1864.6, 3747.7, 33.0),
	vector3(-293.7, 6200.0, 31.4)
}

Karakol = {
    vector3(25.73, -1347.27, 29.5),
    vector3(-48.37, -1757.93, 29.42),
    vector3(-1222.26, -906.86, 12.33),
    vector3(-1487.62, -378.60, 40.16),
    vector3(-707.31, -914.66, 19.22),
    vector3(1135.7, -982.79, 46.42),
    vector3(1163.67, -323.92, 69.21),
    vector3(373.55, 325.52, 103.57),
    vector3(2557.44, 382.03, 108.62),
    vector3(-3039.16, 585.71, 7.91),
    vector3(-3242.11, 1001.20, 12.83),
    vector3(-2967.78, 391.49, 15.04),
    vector3(-1820.38, 792.69, 138.11),
    vector3(547.75, 2671.53, 42.16),
    vector3(1165.36, 2709.45, 38.16),
    vector3(2678.82, 3280.36, 55.24),
    vector3(1961.17, 3740.5, 32.34),
    vector3(1393.13, 3605.2, 34.98),
    vector3(1697.92, 4924.46, 42.06),
    vector3(1728.78, 6414.41, 35.04),
 }

Galeri = {
	vector3(273.67422485352, -344.15573120117, 44.919834136963),
    vector3(-1803.8967285156, -341.45928955078, 43.986347198486),
    vector3(1893.77, 3712.21, 32.78),
    vector3(77.53, 6361.71, 31.49),
    vector3(846.2601, -1050.778, 27.95996),
    vector3(1107.18, 60.58, 80.89),
    vector3(1036.09, -763.36, 57.99),
    vector3(56.05059, -876.4091, 30.65991),
    vector3(-72.69, 908.39, 235.63),
    vector3(-72.69, 908.39, 235.63),
    vector3(-3155.68, 1125.22, 20.86),
    vector3(213.8, -809.00, 31.00),
    vector3(-52.79, -220.93, 45.44),
    vector3(2549.39, 4669.95, 34.08),
    vector3(951.42, -122.64, 74.35),
    vector3(-1414.61, -653.81, 28.67),
    vector3(541.1, -1791.09, 29.14),
    vector3(-737.11, 5822.99, 17.31),
    vector3(1098.0, 2659.54, 38.14),
}

Garaj = {
	vector3(273.67422485352, -344.15573120117, 44.919834136963),
    vector3(-1803.8967285156, -341.45928955078, 43.986347198486),
    vector3(1893.77, 3712.21, 32.78),
    vector3(77.53, 6361.71, 31.49),
    vector3(846.2601, -1050.778, 27.95996),
    vector3(1107.18, 60.58, 80.89),
    vector3(1036.09, -763.36, 57.99),
    vector3(56.05059, -876.4091, 30.65991),
    vector3(-72.69, 908.39, 235.63),
    vector3(-72.69, 908.39, 235.63),
    vector3(-3155.68, 1125.22, 20.86),
    vector3(213.8, -809.00, 31.00),
    vector3(-52.79, -220.93, 45.44),
    vector3(2549.39, 4669.95, 34.08),
    vector3(951.42, -122.64, 74.35),
    vector3(-1414.61, -653.81, 28.67),
    vector3(541.1, -1791.09, 29.14),
    vector3(-737.11, 5822.99, 17.31),
    vector3(1098.0, 2659.54, 38.14),

}

Motel = {
    vector3(72.254, -1399.102, 28.376),
    vector3(-703.776, -152.258, 36.415),
    vector3(-167.863, -298.969, 38.733),
    vector3(428.694, -800.106,  28.491),
    vector3(-829.413, -1073.710, 10.328),
    vector3(-1447.797, -242.461,  48.820),
    vector3(11.632, 6514.224,  30.877),
    vector3(123.646,  -219.440,  53.557),
    vector3(1696.291,  4829.312,  41.063),
    vector3(618.093,  2759.629,  41.088),
    vector3(1190.550, 2713.441, 37.222),
    vector3(-1193.429, -772.262,  16.324),
    vector3(-3172.496, 1048.133,  19.863),
    vector3(458.29, -989.21,  30.69),
    vector3(-1108.441, 2708.923,  18.107),
}

BarberShops = {
	vector3(-814.308, -183.823, 36.568),
	vector3(136.826, -1708.373, 28.291),
	vector3(-1282.604, -1116.757, 5.990),
	vector3(1931.513, 3729.671, 31.844),
	vector3(1212.840, -472.921, 65.208),
	vector3(-32.885, -152.319, 56.076),
	vector3(-278.077, 6228.463, 30.695),
}

GasStations = {
	vector3(49.4187, 2778.793, 58.043),
	vector3(263.894, 2606.463, 44.983),
	vector3(1039.958, 2671.134, 39.550),
	vector3(1207.260, 2660.175, 37.899),
	vector3(2539.685, 2594.192, 37.944),
	vector3(2679.858, 3263.946, 55.240),
	vector3(2005.055, 3773.887, 32.403),
	vector3(1687.156, 4929.392, 42.078),
	vector3(1701.314, 6416.028, 32.763),
	vector3(179.857, 6602.839, 31.868),
	vector3(-94.4619, 6419.594, 31.489),
	vector3(-2554.996, 2334.40, 33.078),
	vector3(-1800.375, 803.661, 138.651),
	vector3(-1437.622, -276.747, 46.207),
	vector3(-2096.243, -320.286, 13.168),
	vector3(-724.619, -935.1631, 19.213),
	vector3(-526.019, -1211.003, 18.184),
	vector3(-70.2148, -1761.792, 29.534),
	vector3(265.648, -1261.309, 29.292),
	vector3(819.653, -1028.846, 26.403),
	vector3(1208.951, -1402.567,35.224),
	vector3(1181.381, -330.847, 69.316),
	vector3(620.843, 269.100, 103.089),
	vector3(2581.321, 362.039, 108.468),
	vector3(176.631, -1562.025, 29.263),
	vector3(176.631, -1562.025, 29.263),
	vector3(-319.292, -1471.715, 30.549),
	vector3(1784.324, 3330.55, 41.253)
}

RegisterNetEvent('pw:mechrepair');
AddEventHandler('pw:mechrepair', function()
    local playerPed = PlayerPedId()
    local coords  = GetEntityCoords(playerPed)
    local vehicle = ESX.Game.GetVehicleInDirection()
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
        TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
        exports['progressBars']:startUI(10000, "Araç Tamir Ediliyor")
        Citizen.Wait(10000)
        ClearPedTasksImmediately(playerPed)

        SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleUndriveable(vehicle, false)
        SetVehicleEngineOn(vehicle, true, true)
        exports['mythic_notify']:SendAlert('inform', 'Aracı Tamir ettin', 4000)
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında araba yok', 4000)
    end
end)
RegisterNetEvent('pw:mechclean');
AddEventHandler('pw:mechclean', function()
    local playerPed = PlayerPedId()
    local coords  = GetEntityCoords(playerPed)
    local vehicle = ESX.Game.GetVehicleInDirection()
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
        TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
        exports['progressBars']:startUI(10000, "Araç Temizleniyor")
        Citizen.Wait(10000)
        ClearPedTasksImmediately(playerPed)

        WashDecalsFromVehicle(vehicle, 1.0)
        SetVehicleDirtLevel(vehicle)
        exports['mythic_notify']:SendAlert('inform', 'Aracı temizledin', 4000)
    else
        exports['mythic_notify']:SendAlert('error', 'Yakında araba yok', 4000)
    end
end)
RegisterNetEvent('pw:kamu');
AddEventHandler('pw:kamu', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        SendToCommunityService(GetPlayerServerId(closestPlayer))
    end
end)
RegisterNetEvent('pw:ceza');
AddEventHandler('pw:ceza', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        OzelFaturaKes(closestPlayer)
    end
end)

RegisterNetEvent('pw:search');
AddEventHandler('pw:search', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        openBodySearchMenu(closestPlayer)
    end
end)

RegisterNetEvent('pw:jail');
AddEventHandler('pw:jail', function()   
        TriggerEvent("chubbsjail:openJailMenu")   
end)

RegisterNetEvent('pw:gpsgir');
AddEventHandler('pw:gpsgir', function()   
        TelsizKoduSor(closestPlayer)   
end)

RegisterNetEvent('pw:faturagor');
AddEventHandler('pw:faturagor', function()   
        OpenUnpaidBillsMenu(closestPlayer)   
end)

RegisterNetEvent('pw:lisansver');
AddEventHandler('pw:lisansver', function()   
        OpenGiveLicense(closestPlayer)   
end)

RegisterNetEvent('pw:medicbill');
AddEventHandler('pw:medicbill', function()   
        OzelFaturaKesAmbulance(closestPlayer)   
end)

RegisterNetEvent('pw:tshirt');
AddEventHandler('pw:tshirt', function()   
        TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['tshirt_1'] = -1, ['tshirt_2'] = 0,
		['torso_1'] = -1, ['torso_2'] = 0,
		['arms'] = 15, ['arms_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)   
end)
RegisterNetEvent('pw:pants');
AddEventHandler('pw:pants', function()   
        TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['pants_1'] = 14, ['pants_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end) 
end)
RegisterNetEvent('pw:mask');
AddEventHandler('pw:mask', function()   
        TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['mask_1'] = -1, ['mask_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end) 
end)
RegisterNetEvent('pw:glass');
AddEventHandler('pw:glass', function()   
        TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['glass_1'] = 11, ['glass_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end) 
end)
RegisterNetEvent('pw:shoes');
AddEventHandler('pw:shoes', function()   
        TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['shoes_1'] = 47, ['shoes_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)  
end)
RegisterNetEvent('pw:getdressed');
AddEventHandler('pw:getdressed', function()
ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('qb-clothes:loadPlayerSkin', skin)
		TriggerEvent('chat:addSuggestion', 'giysilerini giy')
end)
end)
RegisterNetEvent('pw:playerescort');
AddEventHandler('pw:playerescort', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        TriggerEvent('playerfunction:drag', GetPlayerServerId(closestPlayer))
    end
end)
RegisterNetEvent('pw:playerputv');
AddEventHandler('pw:playerputv', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        TriggerEvent('playerfunction:putInVehicle', GetPlayerServerId(closestPlayer))
    end
end)
RegisterNetEvent('pw:playeroutv');
AddEventHandler('pw:playeroutv', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestDistance <= 2.0 then
        TriggerEvent('playerfunction:OutVehicle', GetPlayerServerId(closestPlayer))
    end
end)	


function OzelFaturaKesAmbulance()
local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer == -1 or closestDistance > 3.0 then
				exports['mythic_notify']:SendAlert('error', 'Yakında Fatura Kesilecek Kimse Yok')
			return
end
ESX.UI.Menu.Open(
		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
		{
			title = "Fatura Miktarı Giriniz"
		},
	function(data2, menu2)
	local amount = tonumber(data2.value)
	    if amount == nil then
			exports['mythic_notify']:SendAlert('inform', (_U('invalid_amount')))
		else
		TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_ambulance', 'EMS CITY HOSPITAL', tonumber(data2.value))
		menu2.close()
		end
	end, function(data2, menu2)
		menu2.close()
	end)
end	


function OzelFaturaKes()
local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer == -1 or closestDistance > 3.0 then
				exports['mythic_notify']:SendAlert('error', 'Yakında Fatura Kesilecek Kimse Yok')
			return
end
ESX.UI.Menu.Open(
		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
		{
			title = "Fatura Miktarı Giriniz"
		},
	function(data2, menu2)
	local amount = tonumber(data2.value)
	    if amount == nil then
			exports['mythic_notify']:SendAlert('inform', 'Geçersiz Miktar')
		else
		TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'LSPD & LAW', tonumber(data2.value))
		menu2.close()
		end
	end, function(data2, menu2)
		menu2.close()
	end)
end		

function SendToCommunityService(player)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Community Service Menu', {
		title = "Community Service Menu",
	}, function (data2, menu)
		local community_services_count = tonumber(data2.value)
		
		if community_services_count == nil then
			ESX.ShowNotification('Invalid services count.')
		else
			TriggerServerEvent("esx_communityservice:sendToCommunityService", player, community_services_count)
			menu.close()
		end
	end, function (data2, menu)
		menu.close()
	end)
end


function openBodySearchMenu(player)    
	TriggerServerEvent("disc-inventoryhud:search", GetPlayerServerId(player), GetPlayerName(GetPlayerFromServerId(player)))
end

function OpenIdentityCardMenu(player)

	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)

		local elements    = {}
		local nameLabel   = 'Adı: ' .. data.name
		local jobLabel    = nil
		local sexLabel    = nil
		local dobLabel    = nil
		local heightLabel = nil
		local idLabel     = nil
	
		if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
			jobLabel = 'Meslek: ' .. data.job.label .. ' - ' .. data.job.grade_label
		else
			jobLabel = 'Meslek: ' .. data.job.label
		end
	
			nameLabel = 'Adı: ' .. data.firstname .. ' ' .. data.lastname
	
			if data.sex ~= nil then
				if string.lower(data.sex) == 'm' then
					sexLabel = 'Erkek'
				else
					sexLabel = 'Kadın'
				end
			else
				sexLabel = 'Bilinmiyor'
			end
	
			if data.dob ~= nil then
				dobLabel = 'Doğum Tarihi: ' .. data.dob
			else
				dobLabel = 'Doğum Tarihi: Bilinmiyor'
			end
	
			if data.height ~= nil then
				heightLabel = 'Boy: ' .. data.height
			else
				heightLabel = 'Boy: Bilinmiyor'
			end
	
			if data.name ~= nil then
				idLabel = 'Kimlik: ' .. data.name
			else
				idLabel = 'Kimlik: Bilinmiyor'
			end
	
		local elements = {
			{label = nameLabel, value = nil},
			{label = jobLabel,  value = nil},
		}
	
			table.insert(elements, {label = sexLabel, value = nil})
			table.insert(elements, {label = dobLabel, value = nil})
			table.insert(elements, {label = heightLabel, value = nil})
			table.insert(elements, {label = idLabel, value = nil})
	
		
	
		if data.licenses ~= nil then
	
			table.insert(elements, {label = 'Lisans Adı:', value = nil})
	
			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label, value = nil})
			end
	
		end
	
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
		{
			title    = 'Vatandaş Etkileşimi',
			align    = 'top-left',
			elements = elements,
		}, function(data, menu)
	
		end, function(data, menu)
			menu.close()
		end)
	
	end, GetPlayerServerId(player))

end

function OpenUnpaidBillsMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_billing:getTargetBills', function(bills)
		for k,bill in ipairs(bills) do
			table.insert(elements, {
				label = ('%s - <span style="color:red;">%s</span>'):format(bill.label, _U('armory_item', ESX.Math.GroupDigits(bill.amount))),
				billId = bill.id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
			title    = _U('unpaid_bills'),
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function TelsizKoduSor()
	ESX.UI.Menu.Open(
		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
		{
			title = "Telsiz kodunuzu belirtiniz:"
		},
	function(data2, menu2)
		TriggerServerEvent('esx_policejob:telsizKodu',data2.value)
		menu2.close()
	end, function(data2, menu2)
		menu2.close()
	end)
end

function OpenGiveLicense(player)
ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'give_license',
    {
      title    = ('Silah Ruhsatı'),
      align    = 'top-right',
      elements = {
        {label = ('Tabanca'), value = 'tabanca'},
        {label = ('Hafif Makineli'),   value = 'hafif'},
        {label = ('Ağır'), value = 'agir'},
		{label = ('Dürbünlü'), value = 'sniper'}
      },
    },
	function(data, menu)

    if data.current.value == 'tabanca' then
	TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(player), data.current.value)
	ESX.ShowNotification('Tabanca Silah Ruhsatı verildi. ',targetName)	
	elseif data.current.value == 'hafif' then
	TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(player), data.current.value)
	ESX.ShowNotification('Hafif Makineli Silah Ruhsatı verildi. ',targetName)	
	elseif data.current.value == 'agir' then
	TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(player), data.current.value)
	ESX.ShowNotification('Ağır Silah Ruhsatı verildi. ',targetName)
	elseif data.current.value == 'sniper' then
	TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(player), data.current.value)
	ESX.ShowNotification('Sniper Silah Ruhsatı verildi. ',targetName)	
	end

    end,
    function(data, menu)
      menu.close()
    end
  )

end

--DOKTOR--
RegisterNetEvent('pw:emsRevive');
AddEventHandler('pw:emsRevive', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer == -1 or closestDistance > 1.0 then
        exports['mythic_notify']:SendAlert('error', 'Yakında oyuncu yok')
    else
        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
            if quantity > 0 then
                local closestPlayerPed = GetPlayerPed(closestPlayer)

                if IsPedDeadOrDying(closestPlayerPed, 1) then
                    local playerPed = PlayerPedId()


                    local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

                    for i=1, 15, 1 do
                        Citizen.Wait(900)
                
                        ESX.Streaming.RequestAnimDict(lib, function()
                            TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                        end)
                    end

                    TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
                    TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
                else
                    exports['mythic_notify']:SendAlert('error', 'Kişinin kritik durumu yok')
                end
            else
                exports['mythic_notify']:SendAlert('error', 'Medikitin yok')
            end

        end, 'medikit')
    end
end)
RegisterNetEvent('pw:emssmallheal');
AddEventHandler('pw:emssmallheal', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer == -1 or closestDistance > 1.0 then
        exports['mythic_notify']:SendAlert('error', 'Yakında oyuncu yok')
    else
        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
            if quantity > 0 then
                local closestPlayerPed = GetPlayerPed(closestPlayer)
                local health = GetEntityHealth(closestPlayerPed)

                if health > 0 then
                    local playerPed = PlayerPedId()

                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                    Citizen.Wait(10000)
                    ClearPedTasks(playerPed)

                    TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
                    TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
                else
                    exports['mythic_notify']:SendAlert('error', 'Kişinin kötü durumu yok')
                end
            else
                exports['mythic_notify']:SendAlert('error', 'Bandajın yok')
            end
        end, 'bandage')
    end
end)
RegisterNetEvent('pw:emsbigheal');
AddEventHandler('pw:emsbigheal', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer == -1 or closestDistance > 1.0 then
        exports['mythic_notify']:SendAlert('error', 'Yakında oyuncu yok')
    else
        ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
            if quantity > 0 then
                local closestPlayerPed = GetPlayerPed(closestPlayer)
                local health = GetEntityHealth(closestPlayerPed)

                if health > 0 then
                    local playerPed = PlayerPedId()

                    IsBusy = true
                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                    Citizen.Wait(10000)
                    ClearPedTasks(playerPed)

                    TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
                    TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
                    IsBusy = false
                else
                    exports['mythic_notify']:SendAlert('error', 'Kişinin kötü durumu yok')
                end
            else
                exports['mythic_notify']:SendAlert('error', 'Medikitin yok')
            end
        end, 'medikit')
    end
end)

RegisterNetEvent('ls-radio:use')
AddEventHandler('ls-radio:use', function()
    --Polis Telsiz Menusu
end)

--[[
RegisterServerEvent('telsiz:kodu')
AddEventHandler('telsiz:kodu', function( data, type )
    function TelsizKoduSor()
    ESX.UI.Menu.Open(
        'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
        {
            title = "Telsiz kodunuzu belirtiniz:"
        },
    function(data2, menu2)
        TriggerServerEvent('esx_policejob:telsizKodu',data2.value)
        menu2.close()
    end, function(data2, menu2)
        menu2.close()
    end)
end
    -- body
end)   ]]



RegisterNetEvent('FlipVehicle')
AddEventHandler('FlipVehicle', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vehicle = nil
    if IsPedInAnyVehicle(ped, false) then vehicle = GetVehiclePedIsIn(ped, false) else vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71) end
        if DoesEntityExist(vehicle) then
        exports['chubbsprogbar']:Progress({
            name = "flipping_vehicle",
            duration = 8000,
            label = "Arabayı Çeviriyorsun",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "random@mugging4",
                anim = "struggle_loop_b_thief",
                flags = 49,
            }
        }, function(status)

            local playerped = PlayerPedId()
            local coordA = GetEntityCoords(playerped, 1)
            local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
            local targetVehicle = getVehicleInDirection(coordA, coordB)
            SetVehicleOnGroundProperly(targetVehicle)
        end)
    else
        exports['mythic_notify']:SendAlert('error', 'Araba zaten düz durumda', 7000)
    end
end)

function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle

    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)    
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        
        offset = offset - 1

        if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    
    if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end