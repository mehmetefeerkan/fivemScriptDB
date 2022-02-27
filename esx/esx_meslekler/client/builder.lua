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

ESX                         = nil
local PlayerData            = nil
local Duty                  = false
local LoadProduct           = nil
local UnloadingProduct      = nil
local WheelBarrow           = nil
local objectWheelBarrow     = nil
local sackObjects = {
    sack1 = nil,
    sack2 = nil,
    sack3 = nil
}

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

Citizen.CreateThread(function()
    for _, v in pairs(Config.Builder) do
        for i=1, #v.DutyPos, 1 do
            AddBlip(v.DutyPos[i].x, v.DutyPos[i].y, v.DutyPos[i].z, _U('builder_blipname'), 475, 39)
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if DoesEntityExist(objectWheelBarrow) and IsEntityAnObject(objectWheelBarrow) then
			if IsControlPressed(0, Keys['X']) then
				builderstartAnim('amb@lo_res_idles@', 'world_human_muscle_free_weights_lo_res_base')
			end
			
			if IsEntityPlayingAnim(PlayerPedId(), 'amb@lo_res_idles@', 'world_human_muscle_free_weights_lo_res_base', 3) == false then
				Citizen.Wait(2500)
				builderstartAnim('amb@lo_res_idles@', 'world_human_muscle_free_weights_lo_res_base')
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)

        for _, v in pairs(Config.Builder) do
            for i=1, #v.DutyPos, 1 do
                if Vdist(pedCoords.x, pedCoords.y, pedCoords.z, 
                v.DutyPos[i].x, v.DutyPos[i].y, v.DutyPos[i].z) < 10.0 then
				DrawMarker(0, v.DutyPos[i].x, v.DutyPos[i].y, v.DutyPos[i].z, 
                0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 250, 0, 255, 0, 1, 1, 0, nil, nil, 0)
				sleep = 5
				end
                if Vdist(pedCoords.x, pedCoords.y, pedCoords.z, 
                v.DutyPos[i].x, v.DutyPos[i].y, v.DutyPos[i].z) < 1.0 then
                    FloatingHelpText(_U('builder_help_text'))

                    if IsControlPressed(0, Keys['E']) then
                        ShowBuilderDutyMenu()
                    end
                end
            end

            if LoadProduct then
                for i=1, #v.LoadProduct, 1 do
                    if Vdist(pedCoords.x, pedCoords.y, pedCoords.z, 
                    v.LoadProduct[i].x, v.LoadProduct[i].y, v.LoadProduct[i].z) < 10.0 then
					DrawMarker(27, v.LoadProduct[i].x, v.LoadProduct[i].y, v.LoadProduct[i].z - 0.9, 
                    0, 0, 0, 0, 0, 0, 6.0, 6.0, 1.0, 255, 116, 0, 255, 0, 1, 1, 0, nil, nil, 0)
					sleep = 5
					end
                    if Vdist(pedCoords.x, pedCoords.y, pedCoords.z, 
                    v.LoadProduct[i].x, v.LoadProduct[i].y, v.LoadProduct[i].z) < 3.0 then
                        FloatingHelpText(_U('builder_loadproduct_text'))

                        if IsControlPressed(0, Keys['E']) then
                            Citizen.Wait(500)
                            if DoesEntityExist(objectWheelBarrow) and IsEntityAnObject(objectWheelBarrow) and sackObjects[1] == nil then
                                FreezeEntityPosition(PlayerPedId(), 1)
								ESX.ShowNotification('Yükler el arabasına dolduruluyor...')
								Citizen.Wait(3500)
								
								sackObjects[1] = CreateObject(GetHashKey('prop_feed_sack_01'), 0, 0, 0, 1)
                                AttachEntityToEntity(sackObjects[1], objectWheelBarrow, 0, 0.249999925, 0.0100000016, 0.479999959, 
                                74.0000076, -3.99999857, -90.0000153, 1, 1, 0, 1, 0, 1)
                                
                                sackObjects[2] = CreateObject(GetHashKey('prop_feed_sack_01'), 0, 0, 0, 1)
                                AttachEntityToEntity(sackObjects[2], objectWheelBarrow, 0, -0.150000259, 0.210000068, 0.660000026, 
                                88.8997803, -10.800005, 8.09998608, 1, 1, 0, 1, 0, 1)
                                
                                sackObjects[3] = CreateObject(GetHashKey('prop_feed_sack_01'), 0, 0, 0, 1)
                                AttachEntityToEntity(sackObjects[3], objectWheelBarrow, 0, 0.349999845, 0.210000068, 0.660000026, 
                                88.8997803, -10.800005, 16.5000172, 1, 1, 0, 1, 0, 1) 
								
								FreezeEntityPosition(PlayerPedId(), 0)
							else
                                ESX.ShowNotification(_U('builder_err_loadproduct'))
                            end
                        end
                    end
                end
            end

            if UnloadingProduct then
                for i=1, #v.UnloadingProduct, 1 do
                    if Vdist(pedCoords.x, pedCoords.y, pedCoords.z, 
                    v.UnloadingProduct[i].x, v.UnloadingProduct[i].y, v.UnloadingProduct[i].z) < 10.0 then
					DrawMarker(27, v.UnloadingProduct[i].x, v.UnloadingProduct[i].y, v.UnloadingProduct[i].z - 0.9, 
                    0, 0, 0, 0, 0, 0, 6.0, 6.0, 1.0, 22, 171, 0, 255, 0, 1, 1, 0, nil, nil, 0)
					sleep = 5
					end
                    if Vdist(pedCoords.x, pedCoords.y, pedCoords.z, 
                    v.UnloadingProduct[i].x, v.UnloadingProduct[i].y, v.UnloadingProduct[i].z) < 6.0 then
                        FloatingHelpText(_U('builder_unloadingproduct_text'))

                        if IsControlPressed(0, Keys['E']) then
                            if DoesEntityExist(objectWheelBarrow) and IsEntityAnObject(objectWheelBarrow) and sackObjects[1] ~= nil then
                                ESX.ShowNotification('Yük boşaltılıyor...')
								FreezeEntityPosition(PlayerPedId(), 1)
                                Citizen.Wait(3500)

                                for k, v in pairs(sackObjects) do
                                    if DoesEntityExist(v) and IsEntityAnObject(v) then
                                        DeleteObject(v)
                                        sackObjects[k] = nil
                                    end
                                end
								FreezeEntityPosition(PlayerPedId(), 0)
                                TriggerServerEvent('esx_builder:canPay', GetPlayerServerId(PlayerId()))
                            else
								ESX.ShowNotification(_U('builder_err_unloadingproduct'))
							end
                        end
                    end
                end
            end

            if WheelBarrow then
                for i=1, #v.WheelBarrow, 1 do
                    if Vdist(pedCoords.x, pedCoords.y, pedCoords.z, 
                    v.WheelBarrow[i].x, v.WheelBarrow[i].y, v.WheelBarrow[i].z) < 10.0 then
					DrawMarker(1, v.WheelBarrow[i].x, v.WheelBarrow[i].y, v.WheelBarrow[i].z - 0.9, 
                    0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 0, 202, 255, 255, 0, 1, 1, 0, nil, nil, 0)
					sleep = 5
					end
                    if Vdist(pedCoords.x, pedCoords.y, pedCoords.z, 
                    v.WheelBarrow[i].x, v.WheelBarrow[i].y, v.WheelBarrow[i].z) < 2.0 then
                        FloatingHelpText(_U('builder_wheelbarrow_text'))

                        if IsControlPressed(0, Keys['E']) then
                            ShowBuilderWheelBarrowMenu()
                        end
                    end
                end
            end
        end
		Citizen.Wait(sleep)
    end
end)

function ShowBuilderWheelBarrowMenu()
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'menu', {
            title = _U('builder_wheelbarrow_title'),
            align = 'top-left',
            elements = {
                { label = 'El Arabası Al', value = 'take' },
                { label = 'El Arabasını İade Et', value = 'lost' },
            }
        },

        function(data, menu)
            menu.close()

            if data.current.value == 'take' then
                if DoesEntityExist(objectWheelBarrow) and IsEntityAnObject(objectWheelBarrow) then
                    DeleteObject(objectWheelBarrow)
                    objectWheelBarrow = nil
                end

                ClearPedTasks(PlayerPedId())
                builderstartAnim('amb@lo_res_idles@', 'world_human_muscle_free_weights_lo_res_base')
                local coords = {
                    x = GetEntityCoords(PlayerPedId()).x,
                    y = GetEntityCoords(PlayerPedId()).y,
                    z = GetEntityCoords(PlayerPedId()).z
                }
                local ped = PlayerPedId()
                objectWheelBarrow = CreateObject(GetHashKey('prop_wheelbarrow01a'), coords.x, coords.y, coords.z, 1)
                AttachEntityToEntity(objectWheelBarrow, ped, 45, 0.7200, 0.6800, 0.2100, -104.0000, 149.0000, -123.0100, false, false, false, 1, 2, true)
            elseif data.current.value == 'lost' then
                ClearPedTasks(PlayerPedId())
                if DoesEntityExist(objectWheelBarrow) and IsEntityAnObject(objectWheelBarrow) then
                    DeleteObject(objectWheelBarrow)
                    objectWheelBarrow = nil
                end

                for k, v in pairs(sackObjects) do
                    if DoesEntityExist(v) and IsEntityAnObject(v) then
                        DeleteObject(v)
                        sackObjects[k] = nil
                    end
                end
            end
        end,

        function(data, menu)
            menu.close()
        end
    )
end

function ShowBuilderDutyMenu()
    local playerPed = PlayerPedId()
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'menu', {
            title = _U('builder_duty_title'),
            align = 'top-left',
            elements = {
                { label = 'Mesai Başla', value = 'dutyon' },
                { label = 'Mesai Bitir', value = 'dutyoff' },
            }
        },

        function(data, menu)
            menu.close()

            if data.current.value == 'dutyon' then
                if Duty then
                    ESX.ShowNotification(_U('builder_err_duty_on'))
                else
                    bSetDuty(true)
                end
            elseif data.current.value == 'dutyoff' then
                if Duty then
                    bSetDuty(false)                   
                else
                    ESX.ShowNotification(_U('builder_err_duty_on'))
                end
            end
        end,

        function(data, menu)
            menu.close()
        end
    )
end

function bSetDuty(bool)
    Duty = bool
    if bool then
        ESX.ShowNotification(_U('builder_duty_on'))
        buildersetUniform(playerPed)
        for _, v in pairs(Config.Builder) do
            for i=1, #v.LoadProduct, 1 do
				LoadProduct = AddBlipForCoord(v.LoadProduct[i].x, v.LoadProduct[i].y, v.LoadProduct[i].z) 
				SetBlipSprite(LoadProduct, 501)
				SetBlipDisplay(LoadProduct, 2)
				SetBlipAsFriendly(LoadProduct, true)
				SetBlipAsShortRange(LoadProduct, true)
				SetBlipScale(LoadProduct,0.8)
				SetBlipAlpha(LoadProduct, 255)
				SetBlipColour(LoadProduct, 0)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('builder_blipname_loadproduct'))
				EndTextCommandSetBlipName(LoadProduct)
            end

            for i=1, #v.UnloadingProduct, 1 do
				UnloadingProduct = AddBlipForCoord(v.UnloadingProduct[i].x, v.UnloadingProduct[i].y, v.UnloadingProduct[i].z) 
				SetBlipSprite(UnloadingProduct, 514)
				SetBlipDisplay(UnloadingProduct, 2)
				SetBlipAsFriendly(UnloadingProduct, true)
				SetBlipAsShortRange(UnloadingProduct, true)
				SetBlipScale(UnloadingProduct, 0.8)
				SetBlipAlpha(UnloadingProduct, 255)
				SetBlipColour(UnloadingProduct, 0)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('builder_blipname_unloadingproduct'))
				EndTextCommandSetBlipName(UnloadingProduct)
            end

            for i=1, #v.WheelBarrow, 1 do
				WheelBarrow = AddBlipForCoord(v.WheelBarrow[i].x, v.WheelBarrow[i].y, v.WheelBarrow[i].z) 
				SetBlipSprite(WheelBarrow, 515)
				SetBlipDisplay(WheelBarrow, 2)
				SetBlipAsFriendly(WheelBarrow, true)
				SetBlipAsShortRange(WheelBarrow, true)
				SetBlipScale(WheelBarrow, 0.8)
				SetBlipAlpha(WheelBarrow, 255)
				SetBlipColour(WheelBarrow, 0)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('builder_blipname_wheelbarrow'))
				EndTextCommandSetBlipName(WheelBarrow)
            end
        end

    else
        if DoesBlipExist(LoadProduct) then
            RemoveBlip(LoadProduct)
        end

        if DoesBlipExist(UnloadingProduct) then
            RemoveBlip(UnloadingProduct)
        end

        if DoesBlipExist(WheelBarrow) then
            RemoveBlip(WheelBarrow)
        end
		
		for k, v in pairs(sackObjects) do
			if DoesEntityExist(v) and IsEntityAnObject(v) then
				DeleteObject(v)
				sackObjects[k] = nil
			end
		end
		
		if DoesEntityExist(objectWheelBarrow) and IsEntityAnObject(objectWheelBarrow) then
			DeleteObject(objectWheelBarrow)
			objectWheelBarrow = nil
		end

        LoadProduct           = nil
        UnloadingProduct      = nil
        WheelBarrow           = nil
        ESX.ShowNotification(_U('builder_duty_off'))
        ResetSkin()
		ClearPedTasks(PlayerPedId())
    end
end

function ResetSkin()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end

function buildersetUniform(playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.BuilderUniforms.male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.BuilderUniforms.male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		else
			if Config.BuilderUniforms.female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.BuilderUniforms.female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		end
	end)
end

function AddBlip(x, y, z, name, spriteID, colour)
    local blip = AddBlipForCoord(x, y, z) 
    SetBlipSprite(blip, spriteID)
    SetBlipDisplay(blip, 2)
    SetBlipAsFriendly(blip, true)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.8)
    SetBlipAlpha(blip, 255)
    SetBlipColour(blip, colour)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(blip)
end

function FloatingHelpText(text)   
    BeginTextCommandDisplayHelp("STRING") 
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

function builderstartAnim(lib, anim)
 	
	Citizen.CreateThread(function()

	  RequestAnimDict(lib)
	  
	  while not HasAnimDictLoaded( lib) do
	    Citizen.Wait(5)
	  end

	  TaskPlayAnim(PlayerPedId(), lib ,anim , 4.00, -4.00, -1, 63, 0.00, false, false, false)
	end)

end