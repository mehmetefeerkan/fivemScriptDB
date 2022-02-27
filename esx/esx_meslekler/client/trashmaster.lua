Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX              = nil
local PlayerData = nil
local duty       = false
local dutyBlips = {
    CarSpawnBlip = nil
}

local cp = 0
local cblip = nil
local playerVehicle = nil
local garbagebag = nil
local taked = false
local ownedVehicle = nil

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

-- Load Containers
Citizen.CreateThread(function()
    for _, v in pairs(Config.Trasher) do
        for i=1, #v.Containers, 1 do
            local x = v.Containers[i].x
            local y = v.Containers[i].y
            local z = v.Containers[i].z
            local angle = v.Containers[i].a
            local retval, groundZ = GetGroundZFor_3dCoord(x, y, z, 0)
            if retval then
                z = groundZ
            else
                z = z - 1.5
            end

            if not IsObjectNearPoint(GetHashKey('prop_bin_14a'), x, y, z, 3.0) then
                local obj = CreateObject(GetHashKey('prop_bin_14a'), x, y, z)
                SetEntityHeading(obj, angle - 180.0)
                SetEntityCollision(obj, 1, 1)
                FreezeEntityPosition(obj, 1)
                --SetEntityAsMissionEntity(obj, 1, 1)
                SetEntityInvincible(obj, 1)
            end
        end    
    end
end)

function FloatingHelpText(text)   
    BeginTextCommandDisplayHelp("STRING") 
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

function GetObjectFrontEnd(x, y, z, angle)
    local t_objFrontEnd = {}
    local angleTrig = angle + 90.0
    x = x + Cos(angleTrig) * 1.2
    y = y + Sin(angleTrig) * 1.2
    t_objFrontEnd = {
        ['x'] = x,
        ['y'] = y,
        ['z'] = z,
    }

    local retval , groundZ = GetGroundZFor_3dCoord_2(t_objFrontEnd.x, t_objFrontEnd.y, t_objFrontEnd.z, 1)
    if retval then
        t_objFrontEnd.z = groundZ
    end
    return t_objFrontEnd
end

Citizen.CreateThread(function()
    for _, v in pairs(Config.Trasher) do
        for i=1, #v.Duty, 1 do
            local blip = AddBlipForCoord(v.Duty[i].x, v.Duty[i].y, v.Duty[i].z)
            SetBlipAlpha(blip, 255)
            SetBlipAsFriendly(blip, 1)
            SetBlipAsShortRange(blip, 1)
            SetBlipDisplay(blip, 2)
            SetBlipScale(blip, 0.8)
            SetBlipSprite(blip, 318)
            SetBlipColour(blip, 21)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(_U('trasher_blip_main'))
            EndTextCommandSetBlipName(blip)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        for _, v in pairs(Config.Trasher) do
            for i=1, #v.Duty, 1 do
			if Vdist(x, y, z, v.Duty[i].x, v.Duty[i].y, v.Duty[i].z) < 10.0 then
                DrawMarker(0, v.Duty[i].x, v.Duty[i].y, v.Duty[i].z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 210, 0, 200, 0, 1, 2, 0, nil, nil, 0)
            sleep = 5
			end
                if Vdist(x, y, z, v.Duty[i].x, v.Duty[i].y, v.Duty[i].z) < 1.0 then
                    FloatingHelpText(_U('trasher_display_help'))

                    if IsControlPressed(0, Keys['E']) then
                        ShowTrasherDutyMenu()
                    end
                end
            end

            if duty then
                for i=1, #v.CarSpawn, 1 do
                    if Vdist(x, y, z, v.CarSpawn[i].x, v.CarSpawn[i].y, v.CarSpawn[i].z) < 10.0 then
					DrawMarker(39, v.CarSpawn[i].x, v.CarSpawn[i].y, v.CarSpawn[i].z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 100, 67, 29, 200, 0, 1, 2, 0, nil, nil, 0)
					sleep = 5
					end
                    if Vdist(x, y, z, v.CarSpawn[i].x, v.CarSpawn[i].y, v.CarSpawn[i].z) < 1.0 then
                        FloatingHelpText(_U('trasher_carspawn_help'))

                        if IsControlPressed(0, Keys['E']) then
                            ShowTrasherCarSpawn()
                        end
                    end
                end
            end
        end
		Citizen.Wait(sleep)
    end
end)

function ShowTrasherCarSpawn()
    Wait(300)
    local spawnCoords = { ['x'] = -572.43, ['y'] = -1785.39, ['z'] = 22.27, ['h'] = 145.21 }
	local vehicles = ESX.Game.GetVehiclesInArea(spawnCoords, 15.0)
	
	if #vehicles > 0 then
		ESX.ShowNotification('Araç çıkarmak için bölgedeki araçların uzaklaşması gerekiyor.')
    else
        ESX.TriggerServerCallback('esx_trashmaster:canPay', function(bool)
            if bool then
                ESX.Game.SpawnVehicle('trash', spawnCoords, spawnCoords.h, function(vehicle)
                    TaskEnterVehicle(PlayerPedId(), vehicle, 5000, -1, 2.0, 16, 0)
                    playerVehicle = vehicle
					ownedVehicle = vehicle
                end)
            else
                ESX.ShowNotification(_U('trasher_carspawn_err_pay'))
            end
        end)
	end
end

function ShowTrasherDutyMenu()
    ESX.UI.Menu.CloseAll()
    
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'menu',
        {
            title = _U('trasher_duty_menu_title'),
            align = 'top-left',
            elements = {
                { label = 'Mesaiye Başla', value = 'dutyon' },
                { label = 'Mesaiyi Bitir', value = 'dutyoff' }
            }
        },

        function(data, menu)
            if data.current.value == 'dutyon' then
                menu.close()
                if duty then
                    ESX.ShowNotification(_U('trasher_err_duty_menu_on'))
                else
                    SetDuty(true)
                end
            elseif data.current.value == 'dutyoff' then
                menu.close()
                if not duty then
                    ESX.ShowNotification(_U('trasher_err_duty_menu_off'))
                else
                    SetDuty(false)
                end
            end
        end,

        function(data, menu)
            menu.close()
        end
    )
end

function SetDuty(bool)
    duty = bool
    if duty then
        ESX.ShowNotification(_U('trasher_duty_start'))
        trashsetuniform(PlayerPedId())
        CreateVehicleSpawnPointForTrasherDuty()
        PlayerStartCP(1) -- cp start
    else
        ESX.ShowNotification(_U('trasher_duty_end'))
        ResetSkin()
		if ownedVehicle ~= nil and IsEntityAVehicle(ownedVehicle) and GetEntityModel(ownedVehicle) == GetHashKey('trash') then
			ESX.Game.DeleteVehicle(ownedVehicle)
		end
        ResetDuty()
		ownedVehicle = nil
		DeleteWaypoint()
		if dutyBlips.CarSpawnBlip ~= nil and DoesBlipExist(dutyBlips.CarSpawnBlip) then
			RemoveBlip(dutyBlips.CarSpawnBlip)
			dutyBlips.CarSpawnBlip = nil
		end
    end
end

function PlayerStartCP(cpLevel)
    if cpLevel == 11 then
        if DoesBlipExist(cblip) then
            RemoveBlip(cblip)
        end

        Citizen.CreateThread(function()
            cblip = AddBlipForCoord(-581.4, -1777.99, 22.59)
            SetBlipAlpha(cblip, 255)
            SetBlipAsFriendly(cblip, 1)
            SetBlipAsShortRange(cblip, 1)
            SetBlipDisplay(cblip, 2)
            SetBlipScale(cblip, 0.8)
            SetBlipSprite(cblip, 50)
            SetBlipColour(cblip, 3)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName('Araç Teslimat Yeri')
            EndTextCommandSetBlipName(cblip)

            SetNewWaypoint(-581.4, -1777.99)

            while cp > 0 do
               Citizen.Wait(10)
               local x1, y1, z1 = table.unpack(GetEntityCoords(PlayerPedId()))
               local retval , groundZ = GetGroundZFor_3dCoord_2(-581.4, -1777.99, 22.59, 1)
               if not retval then
                groundZ = 22.59 - 1.0
               end
                DrawMarker(1, -581.4, -1777.99, groundZ, 0, 0, 0, 0, 0, 0, 10.0, 10.0, 0.9, 255, 39, 25, 155, 0, 0, 2, 0, nil, nil, 0)
            
               if Vdist(x1, y1, z1, -581.4, -1777.99, 22.59) < 10.0 then
                    FloatingHelpText('Görevi tamamlamak için ~INPUT_CONTEXT~ tuşuna basın!')

                    if IsControlPressed(0, Keys['E']) then
                        ShowTrasherEndMenu()
                        Wait(500)
                        break
                    end
                end
            end
        end)
    else
        if DoesBlipExist(cblip) then
            RemoveBlip(cblip)
        end

        cp = cpLevel
        cblip = AddBlipForCoord(Config.Trasher[1].Containers[cp].x, Config.Trasher[1].Containers[cp].y, Config.Trasher[1].Containers[cp].z)
        SetBlipAlpha(cblip, 255)
        SetBlipAsFriendly(cblip, 1)
        SetBlipAsShortRange(cblip, 1)
        SetBlipDisplay(cblip, 2)
        SetBlipScale(cblip, 0.8)
        SetBlipSprite(cblip, 514)
        SetBlipColour(cblip, 10)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('Çöp')
        EndTextCommandSetBlipName(cblip)

        SetNewWaypoint(Config.Trasher[1].Containers[cp].x, Config.Trasher[1].Containers[cp].y)

        Citizen.CreateThread(function()
            while duty and not taked do
				Citizen.Wait(10)
				if cp == 0 then break end
				local ped = PlayerPedId()
				local x1, y1, z1 = table.unpack(GetEntityCoords(PlayerPedId()))
				local x = Config.Trasher[1].Containers[cp].x
				local y = Config.Trasher[1].Containers[cp].y
				local z = Config.Trasher[1].Containers[cp].z
				local angle = Config.Trasher[1].Containers[cp].a
				local trashfrontend = GetObjectFrontEnd(x, y, z, angle)
				DrawMarker(1, trashfrontend.x, trashfrontend.y, trashfrontend.z, 
				0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.9, 255, 0, 0, 100, 0, 0, 2, 0, nil, nil, 0)

				if GetVehiclePedIsIn(ped, false) == 0 and Vdist(x1, y1, z1, trashfrontend.x, trashfrontend.y, trashfrontend.z) < 1.2 then
					FloatingHelpText(_U('trasher_display_trash'))

					if IsControlPressed(0, Keys['E']) then
						TakeTrash()
					end
				end
            end
        end)
    end
end

function ShowTrasherEndMenu()
	if ownedVehicle ~= nil then
		ESX.UI.Menu.CloseAll()
		local ped = PlayerPedId()

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'menu',
			{
				title = 'Temizlik - Menü',
				align = 'top-left',
				elements = {
					{ label = 'Yükü Boşalt', value = 'keep'},
					{ label = 'Yükü Boşalt + Aracı Sil', value = 'end'},
				}
			},

			function(data, menu)
				if data.current.value == 'keep' then
					menu.close()
					DeleteWaypoint()
					TriggerServerEvent('esx_trasher:confirmPay', GetPlayerServerId(PlayerId()))
					ResetDuty()
					PlayerStartCP(1)
				elseif data.current.value == 'end' then
					menu.close()
					if GetEntityModel(GetVehiclePedIsIn(ped, false)) == GetHashKey('trash') then
						ESX.Game.DeleteVehicle(GetVehiclePedIsIn(ped, false))
					end
					DeleteWaypoint()
					TriggerServerEvent('esx_trasher:confirmPay', GetPlayerServerId(PlayerId()))
					ResetDuty()
					ownedVehicle = nil
					PlayerStartCP(1)
				end
			end,

			function(data, menu)
				menu.close()
				DeleteWaypoint()
				TriggerServerEvent('esx_trasher:confirmPay', GetPlayerServerId(PlayerId()))
				ResetDuty()
				PlayerStartCP(1)
			end
		)
	else
		
		DeleteWaypoint()
		TriggerServerEvent('esx_trasher:confirmPay', GetPlayerServerId(PlayerId()))
		ResetDuty()
		PlayerStartCP(1)
	end
end

function ResetDuty()
    cp = 0
    if cblip ~= nil and DoesBlipExist(cblip) then
        RemoveBlip(cblip)
        cblip = nil
    end
	
    playerVehicle = nil
    garbagebag = nil
    taked = false
	DeleteWaypoint()
end

function TakeTrash()
    Wait(500)
    if DoesEntityExist(garbagebag) and IsEntityAnObject(garbagebag) then
        ESX.ShowNotification('Zaten çöpü almışsınız!')
    else
        local ped = PlayerPedId()
        local vehicleLast = GetVehiclePedIsIn(ped, true)
        
        if vehicleLast ~= 0 and GetEntityModel(vehicleLast) == GetHashKey('trash') then
            taked = true
            TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
            exports["t0sic_loadingbar"]:StartDelayedFunction("Çöp topluyorsun", 4000, function()
            
            ClearPedTasks(PlayerPedId())
            garbagebag = CreateObject(GetHashKey("prop_cs_street_binbag_01"), 0, 0, 0, true, true, true) -- creates object
            AttachEntityToEntity(garbagebag, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.4, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand    
            TaskPlayAnim(PlayerPedId(-1), 'anim@heists@narcotics@trash', 'walk', 1.0, -1.0,-1,49,0,0, 0,0)
            local trunk = GetWorldPositionOfEntityBone(vehicleLast, GetEntityBoneIndexByName(vehicleLast, "platelight"))
            Citizen.CreateThread(function()
                while garbagebag ~= nil do
                    Citizen.Wait(10)
                    local x1, y1, z1 = table.unpack(GetEntityCoords(PlayerPedId()))
                    DrawMarker(1, trunk.x, trunk.y, trunk.z, 
                    0, 0, 0, 0, 0, 0, 2.0, 2.0, 0.9, 255, 0, 0, 100, 0, 0, 2, 0, nil, nil, 0)

                    if GetVehiclePedIsIn(ped, false) == 0 and Vdist(x1, y1, z1, trunk.x, trunk.y, trunk.z) < 2.0 then
                        FloatingHelpText(_U('trasher_display_trash_move'))

                        if IsControlPressed(0, Keys['E']) then
                            MoveTrash()
                        end
                    end
                end
            end)
        end)
        else
            ESX.ShowNotification('Çöpü almak için en son çöp kamyonuna binmiş olmalısınız!')
        end
    end
end

function MoveTrash()
    Wait(500)
    if DoesEntityExist(garbagebag) and IsEntityAnObject(garbagebag) then
        ClearPedTasksImmediately(PlayerPedId())
        ClearPedTasks(PlayerPedId())
        startAnim('anim@heists@narcotics@trash', 'throw_b')
        Citizen.Wait(800)
        ClearPedTasks(PlayerPedId())
        DeleteObject(garbagebag)
        SetEntityAsNoLongerNeeded(garbagebag)
        garbagebag = nil
        PlayerStartCP(cp + 1)
        taked = false
        SetVehicleDoorShut(vehicleLast, 5, false)
    end
end


function startAnim(lib, anim)
 	
	Citizen.CreateThread(function()

	  RequestAnimDict(lib)
	  
	  while not HasAnimDictLoaded( lib) do
	    Citizen.Wait(5)
	  end

	  TaskPlayAnim(PlayerPedId(), lib ,anim ,8.0, -8.0, -1, 0, 0, false, false, false )

	end)

end

function CreateVehicleSpawnPointForTrasherDuty()
    for _, v in pairs(Config.Trasher) do
        for i=1, #v.CarSpawn, 1 do
			if dutyBlips.CarSpawnBlip ~= nil and DoesBlipExist(dutyBlips.CarSpawnBlip) then
				RemoveBlip(dutyBlips.CarSpawnBlip)
				dutyBlips.CarSpawnBlip = nil
			end
		
            dutyBlips.CarSpawnBlip = AddBlipForCoord(v.CarSpawn[i].x, v.CarSpawn[i].y, v.CarSpawn[i].z)
            SetBlipAlpha(dutyBlips.CarSpawnBlip, 255)
            SetBlipAsFriendly(dutyBlips.CarSpawnBlip, 1)
            SetBlipAsShortRange(dutyBlips.CarSpawnBlip, 1)
            SetBlipDisplay(dutyBlips.CarSpawnBlip, 2)
            SetBlipScale(dutyBlips.CarSpawnBlip, 0.8)
            SetBlipSprite(dutyBlips.CarSpawnBlip, 635)
            SetBlipColour(dutyBlips.CarSpawnBlip, 4)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(_U('trasher_blip_carspawn'))
            EndTextCommandSetBlipName(dutyBlips.CarSpawnBlip)
        end
    end
end

function ResetSkin()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end

function trashsetuniform(playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.TrasherUniforms.male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.TrasherUniforms.male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		else
			if Config.TrasherUniforms.female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.TrasherUniforms.female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		end
	end)
end